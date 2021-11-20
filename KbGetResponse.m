function [response,rt] = KbGetResponse(keys,waittime,restrictKeys)
% 'KbGetResponse' acquires responses (according to pre-defined keys) and
% accurate response times (depending on hardware capabilities) from
% keyboards with a time resolution of 1 ms. This function either waits
% indefinitely or for a limited maximum response time. It can be aborted by
% hitting 'escape'.
%
% Input arguments:
%
% 'keys'            [required] Matrix containing rows of integer key code
% alternatives for different responses. Row 1 contains key codes for
% response '1', row 2 contains key codes for response '2', and so on.
% Alternatives can be helpful in cases where multiple key layouts are used
% (e.g. W/A/S/D and the arrow keys for left vs. right handed participants,
% respectively, or e.g. if a key pad is used and errors due to the numlock
% state shall be avoided.
% 
% Example: The following matrix contains the key codes for 'A', 'a', and
% 'LEFT' (arrow) as response key alternatives for response label '1', and
% the key codes for 'D','d', and 'RIGHT' (arrow) as response key
% alternatives for response label '2': 
% 
% keys =    [65, 37;
%           68, 39]
% 
% CAUTION: PsychToolbox (PTB) key codes not necessarily reflect ASCII key
% codes, e.g. 'A' and 'a' have the same PTB key code (65).
% 
% HINT: The following line of code can be used to enumerate key codes:
% 'WaitSecs(.25);[~,keyCode]=KbWait;find(keyCode)'. The initial 'WaitSecs'
% command ensures that the enter key executing this line will not let the
% 'KbWait' command return.
%
% 'waittime'        [default: -1] The maximum allowed response time in
% seconds (integer or real). If 'waittime' elapses, this function returns
% with an invalid response label. A value of '-1' lets the function wait
% indefinitely.
%
% 'restrictKeys'    [default: false] Whether or not responses are
% restricted to the key codes contained by 'keys' (logical). If responses
% are restricted, other keys will have no effect. Not limiting responses to
% certain keys can be helpful for training purpopses (together with proper
% feedback). A value of 'false' (or '0') will not limit responses.
%
% Output arguemnts:
%
% 'response'        Returns an integer response label. If a valid key was
% pressed, 'response' will contain its row number in 'keys' (i.e. '1', '2'
% etc.). If an invalid key or multiple keys were pressed, 'response'
% returns the value '-1'. If no response was logged and 'waittime' elapsed,
% the value '-99' will be returned. If 'escape' was pressed, the value '27'
% (key code for 'escape') will be returned.
%
% 'rt'              Returns the response time in seconds (real), or a value
% very close to the maximum response time in case no response was logged
% and 'waittime' elapsed.
%
% This function can only deliver accurate (valid, reliable) response times 
% if appropriate input hardware is used, such as special-purpose scientific
% gear or at least gaming hardware with low-latency chips and drivers.
%
% Created by Ole Traupe, Technische Universität Berlin (2018).

try
    
    % get start time
    t1 = GetSecs;       %low-level java-based PTB system time function
    
    % check input arguments
    if nargin<1
        fprintf('ERROR: Response keys required. Type ''help KbGetResponse'' for further information.\n')
        return
    end
    if nargin<2
        fprintf('WARNING: Max. response time not defined, will wait indefinitely!\n')
        waittime=-1;
    end
    if nargin<3
        fprintf('WARNING: Key presses not restricted to set response keys. Any input will be accepted!\n')
        restrictKeys=false;
    end
    
    % make sure output arguments exist
    response = [];
    rt = [];
    
    % suppress output to Matlab window
    ListenChar(2)                       %don't forget to turn this off in any case
    
    % restrict input to pre-set keys
    if restrictKeys
        RestrictKeysForKbCheck([keys(:);27]);   %try/catch ensures this restriction to be removed in any case
    end
    
    % clear input cue and wait until no key is pressed
    FlushEvents('keyDown');             %discard all the chars from the Event Manager queue
    [isPressed,~,keycode] = KbCheck;    %check for keyboard status
    while isPressed                     %wait till no key is pressed (to avoid keys being held down)
        WaitSecs(0.001);                    %wait a short wile and
        [isPressed,~,keycode] = KbCheck;    %check again
    end
    
    % acquire response and rt
    check = 0;          
    now = GetSecs;
    %while ~isPressed && (check <= waittime)            %'waittime=-1' for an indefinite rt will not work
    while ~isPressed && ~(floor(check)==waittime)       %returns if key pressed or time elapsed
        now = WaitSecs('UntilTime', now + 0.001);       %ensures loop durations closest to 1 ms
        [isPressed,t2,keycode] = KbCheck;               %get keyboard status, time, and key coes
        check = GetSecs - t1;                           %log overall elapsed time of this function call
    end
    
    % determine response and rt
    rt = t2-t1;                         % determine response time
    k = find(keycode);                  % get all pressed keys
    
    if any(k == 27), response = 27; RestrictKeysForKbCheck([], ListenChar(0)); return, end             %'escape' pressed
    if floor(check)==waittime, response = -99; RestrictKeysForKbCheck([], ListenChar(0)); return, end  %time elapsed
    if numel(k)==1, [response,~] = find(k==keys); end                                   %valid response ocurred
    if isempty(response), response = -1; end            %invalid response or multiple key presses ocurred
    
    % remove key/output restrictions
    RestrictKeysForKbCheck([]);
    ListenChar(0)
    
    % for debugging purposes show response and rt
    %disp(['response: ',num2str(response)]);
    %disp(['rt: ',num2str(rt)]);
    
catch e                             %in case of an error
%     disp(e.message)                 %show the error message
    RestrictKeysForKbCheck([]);     %remove any key and 
    ListenChar(0)                   %output restrictions
end