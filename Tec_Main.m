function Tec_Main

%% Tectronic Experiment Main Script 
% Research on perception of architectural differences by conducting EEG,
% Eye Tracking and Opinion Data 
% This is the Main Script. All other scripts are called and started here,
% so it gives the whole written programm its structure.


%% Preparation

clear;
sca;  

% Clear Matlab output
clc;            

% Create global data var (containing settings and timing parameters, input, and output)
global data    

    
    %% Input
    % Get run parameters and participant demographics
    Tec_Input;
    % Hide toolbar and cursor 
    % ShowHideWinTaskbarMex(0)
    HideCursor;  
    
    
    %% General Adjustments
    % Synchronization Test of the Screen and the Software
    % Screen('Preference', 'SkipSyncTests', 0);
    % If sync tests are skipped, offscreen windows don't seem to work properly
    % this command skips it, necessary so that the eye tracker and the
    % psychtoolbox can run at the same time
    % Attention: No bad consequences experienced so far, but possible!
    Screen('Preference', 'SkipSyncTests', 1);  
    % Verbosity of the saved information of the screen 
    Screen('Preference', 'Verbosity', 0);
    % Synch testing parameters in the beginning of the experiment 
    [data.PTBdiag.SyncTestSettings.maxStddev, data.PTBdiag.SyncTestSettings.minSamples, ...
        data.PTBdiag.SyncTestSettings.maxDeviation, data.PTBdiag.SyncTestSettings.maxDuration] = ...
        Screen('Preference', 'SyncTestSettings', 0.0003, 120, 0.01, 5);
    % Font Size of presented text on screen
    Screen('Preference', 'DefaultFontSize', 48);
    
    
    %% Variables 
    % Preperation of variables 
    Tec_Preferences;       
    
    
    %% Stimuli
    % Preperation of screens
    Tec_Stimuli;    
    

    %% Initialize Markers for LSL
    %initialize the marker system with the parameter '0'
    Tec_Markers(0);               
    
    
    %% Procedure
    % Execution of actual experiment 
    Tec_Core;
    
    
    %% Saving
    % Storing all Data in different files and close experiment afterwards 
    Tec_Save;          
    
    
end 