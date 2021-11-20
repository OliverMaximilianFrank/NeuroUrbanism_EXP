function Tec_Preferences 

global data

%% Get/Set screen parameters and open window

% screen selection and proportions
% Don't use more than one screen at a time !
% Screen 0 is chosen, the only one that is available 
% If you plug in the second Screen in the control room, you might put a 1
% in here so that the screen without bugs stands in the lab3
data.prefs.screen.whichScreen = 0;

% Definition of the ScreenSize and its center
% 'ScreenSize' should put it as FullScreen 
data.prefs.screen.scrsz = get(data.prefs.screen.whichScreen,'ScreenSize');
data.prefs.screen.center = data.prefs.screen.scrsz(3:4)/2;

% Open the experiment window
data.prefs.screen.window1 = Screen(data.prefs.screen.whichScreen, 'OpenWindow');

% Define Colors (might differ from the typical RGB values)
data.prefs.screen.colors.white = WhiteIndex(data.prefs.screen.window1);     
data.prefs.screen.colors.black = BlackIndex(data.prefs.screen.window1);     
data.prefs.screen.colors.standbackcol = data.prefs.screen.colors.black;     
data.prefs.screen.colors.standtextcol = data.prefs.screen.colors.white;

% Populate the selected background color, only once 
% Flip clears back buffer, but maintains the BackgroundColor
Screen(data.prefs.screen.window1, 'FillRect', data.prefs.screen.colors.standbackcol);
Screen(data.prefs.screen.window1, 'Flip');


%% Loading/Preparation of stimuli

% Basic stimuls path (can contain specific sub-folders)
data.prefs.present.stimpath = 'stim\';    

% Open the CSV files with the sequence of the stimuli 
% Three times, for each block there is one excel script 
% Open file, get handle 
fid = fopen([data.prefs.present.stimpath,'1_Baseline.csv']); 
% Read text from file 
data.prefs.present.trials_list_baseline = textscan(fid,'%s');      
fclose(fid);
% Open file, get handle
fid = fopen([data.prefs.present.stimpath,'2_Experiment.csv']); 
% Read text from file 
data.prefs.present.trials_list_experiment = textscan(fid,'%s');      
fclose(fid);

% Number of trials in each csv file (we only use that for experiment)
data.prefs.present.ntrials_baseline = length(data.prefs.present.trials_list_baseline{1});
data.prefs.present.ntrials_experiment = length(data.prefs.present.trials_list_experiment{1});

% Number of ntrials in total 
data.prefs.present.ntrials = length([data.prefs.present.trials_list_baseline{1};...
    data.prefs.present.trials_list_experiment{1}]);


%% graphical presentation parameters

% Where to put the stimulus picture 
data.prefs.present.hdisloc = 450;
% Dimensions of fixation cross (half the length of its lines)
data.prefs.present.cross_halfwidth = 50;    
% Width of cross lines
data.prefs.present.cross_penwidth = 5;  


%% trial timing and repetitions

% Inter trial interval (Increasing)
% Lower limit -> 500ms
data.prefs.present.iti_minDur = 0.5;
% Upper limit -> 2000ms
data.prefs.present.iti_maxDur = 2.0;     
% Randomized iti duration 
data.prefs.present.iti_durations = data.prefs.present.iti_minDur + ...
    (data.prefs.present.iti_maxDur-data.prefs.present.iti_minDur) .* rand(data.prefs.present.ntrials, 1);  

% Event Counter 
data.prefs.present.events = 0;

% Trial Counter
data.prefs.present.trial_count_all = 0;
data.prefs.present.trial_count_exp = 0;

%% response collection

% Prepare output struct
data.output.results = {};                      


%% Data output 

% Create Path for saving the result data 
data.prefs.present.datpath = 'data\'; 

% Create name of the file to be saved, Info caught in Tec_Input
if str2double(data.input.ParticipantNumber) < 10
    data.prefs.output.baseFilename = [data.prefs.present.datpath,'P','0',data.input.ParticipantNumber,...
        '_',data.input.startTimeString];
else 
    data.prefs.output.baseFilename = [data.prefs.present.datpath,'P',data.input.ParticipantNumber,...
    '_',data.input.startTimeString];
end

% Creation of file which contains the global 'data' struct variable
data.prefs.output.matfFilename = [data.prefs.output.baseFilename,'.mat'];   
