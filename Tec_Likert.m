function [resp, rt] = Tec_Likert(win,winRect,nLikertRange,question)

% The likert scales are constructed here and their response is catched and given.
% Inspiration: hiobeen@yonsei.ac.kr
% modified by: Oliver Frank, TU Berlin, 2021

global data 

%% #1. Basic Setting 

% scale position 
scale_position = - floor(winRect(4) * .33); 


% Scale Parameters
% With the 255 one can impact the color of the likert bar 
hori_bar_mat = 255 * ones([floor(winRect(4)*(.1/10)) floor(winRect(3)*(1/2))]);
hori_bar_texture = Screen('MakeTexture', win, hori_bar_mat);
hori_bar_size = size(hori_bar_mat);
vert_bar_mat = 255 * ones([floor(winRect(4)*(.25/10)) floor(winRect(3)*(1/300))]);
vert_bar_texture = Screen('MakeTexture', win, vert_bar_mat);
vert_bar_size = size(vert_bar_mat);

% Scale Markers Specification
ovalSize = 40; 
ovalWidth = 4; 
ovalColor = [255 255 255];

% Create mouse instance
import java.awt.Robot; mouse = Robot; 


%% #2. Assessment method

% Center point
cp = [floor(winRect(3)*.5) floor(winRect(4)*.5)]; 
hori_bar_pos = [floor(cp(1) - .5*hori_bar_size(2)),...
    floor(cp(2) - .5*hori_bar_size(1)) - scale_position,...
    floor(cp(1) + .5*hori_bar_size(2)),...
    floor(cp(2) + .5*hori_bar_size(1)) - scale_position];

% Number of possible answers on likert scale 
nScaleColumns = nLikertRange;

% Possible mouse positions and limit its movement
possibleMoveSpace = [     ...
    round(hori_bar_pos(1)+winRect(1)),   ...
    round(.5 * (hori_bar_pos(2)+hori_bar_pos(4)) + winRect(2)),   ...
    round(hori_bar_pos(3)+winRect(1)),   ...
    round(.5 * (hori_bar_pos(2)+hori_bar_pos(4)) + winRect(2) + 1)];

initialMousePos = round(rand() * (possibleMoveSpace(3) - possibleMoveSpace(1)));
mouse.mouseMove(initialMousePos,(possibleMoveSpace(2)));


%% #3. Let's Get Response!

% Set Cursor position and show 
SetMouse(data.prefs.screen.scrsz(3)/2, data.prefs.screen.scrsz(4)/1.3)
ShowCursor('Hand');

% Initialization of click and runtime 
click = 0;
t1 = GetSecs;

% while loop waits for click answer to break out 
while ~click
    % Likert Bar Drawing
    % Hori bar draw
    Screen('DrawTexture', win, hori_bar_texture,...
        [0 0 hori_bar_size(2) hori_bar_size(1)], hori_bar_pos, 0, 1, 0, ovalColor);
    % Vert bars draw
    xRange = linspace(hori_bar_pos(1),hori_bar_pos(3),nScaleColumns);
    for xPos = xRange
        vert_bar_pos = [ xPos - vert_bar_size(2),...
            mean([hori_bar_pos(2) hori_bar_pos(4)]) - (.5*vert_bar_size(1)),...
            xPos + vert_bar_size(2),...
            mean([hori_bar_pos(2) hori_bar_pos(4)]) + (.5*vert_bar_size(1)),...
            ];
        Screen('DrawTexture', win, vert_bar_texture,...
            [0 0 vert_bar_size(2) vert_bar_size(1)], vert_bar_pos, 1, 1, 1, ovalColor);
    end
    
    
    % Get Response
    [cursorX, ~, click] = GetMouse;
    % Likert
    respRange = linspace(possibleMoveSpace(1), possibleMoveSpace(3), nLikertRange);
    LetsFindNearestOne = abs(respRange - cursorX);
    [~,nearestIdx] = (min(LetsFindNearestOne));    
    % ANSWER of Likert Scale 
    resp = nearestIdx;

    for xPos = xRange(nearestIdx)
        yPos =  .5 * (vert_bar_pos(2)+vert_bar_pos(4)) + winRect(2);
        Screen('FrameOval', win, ovalColor,...
            [ xPos-ovalSize*.5, yPos - ovalSize*.5,...
            xPos+ovalSize*.5, yPos + ovalSize*.5 ], ovalWidth);
    end

    
    %% Add Text to Likert Scale
    if question == 1
        % Question
        Screen('DrawText', win, 'How beautiful is the space?', ...
            cp(1) - .32 * cp(1), cp(2) - 0.2 * cp(2),[255 255 255]);
        % Answer
        Screen('DrawText', win, 'Not at all', cp(1) - .6 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
        Screen('DrawText', win, 'Very beautiful', cp(1) + .33 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
    elseif question == 2
        % Question
        Screen('DrawText', win, 'How complex is the space?', ...
            cp(1) - .32 * cp(1), cp(2) - 0.2 * cp(2),[255 255 255]);
        % Answer
        Screen('DrawText', win, 'Not at all', cp(1) - .6 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
        Screen('DrawText', win, 'Very complex', cp(1) + .34 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
    elseif question == 3
        % Question
        Screen('DrawText', win, 'How interesting is the space?', ...
            cp(1) - .32 * cp(1), cp(2) - 0.2 * cp(2),[255 255 255]);
        % Answer
        Screen('DrawText', win, 'Not at all', cp(1) - .6 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
        Screen('DrawText', win, 'Very interesting', cp(1) + .315 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
    elseif question == 4
        % Question
        Screen('DrawText', win, 'How likely would you want to MEET somebody here?', ...
            cp(1) - .57 * cp(1), cp(2) - 0.2 * cp(2),[255 255 255]);
        % Answer
        Screen('DrawText', win, 'Not at all', cp(1) - .6 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
        Screen('DrawText', win, 'Very much', cp(1) + .375 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
    else
        % Question
        Screen('DrawText', win, 'How likely would you want to READ a book here?', ...
            cp(1) - .53 * cp(1), cp(2) - 0.2 * cp(2),[255 255 255]);
        % Answer
        Screen('DrawText', win, 'Not at all', cp(1) - .6 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
        Screen('DrawText', win, 'Very much', cp(1) + .375 * cp(1), cp(2) + .5 * cp(2),[255 255 255]);
    end 


    %% Flip it all
    Screen('Flip', win);
    
end

% Extract Runtime 
t2 = GetSecs;
rt = t2-t1;

HideCursor;

% Close it 
return