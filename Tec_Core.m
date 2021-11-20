function Tec_Core

% The whole scene structure is defined here, the components are defined in
% Tec_Stimuli and Tec_Preferences 

global data

%% Variable Declaration 

% Screen sizes 
cw = data.prefs.present.cross_halfwidth;
pw = data.prefs.present.cross_penwidth;

% number of trials and blocks 
% ntrials = data.prefs.present.ntrials;

% Block definition (Add blocks here if necessary)
baseline = data.prefs.present.trials_list_baseline;
experiment = data.prefs.present.trials_list_experiment;
% Blocks array
blocks = [baseline experiment];

% Number of trials in experiment
ntrials_experiment = data.prefs.present.ntrials_experiment;

% List of randomized index numbers for each csv file 
list_baseline = randperm(length(data.prefs.present.trials_list_baseline{1}));
list_experiment = randperm(length(data.prefs.present.trials_list_experiment{1}));

% Click definition 
click_txt = data.stimuli.screen.click;

% Instruction Baseline definition
instruction_one = data.stimuli.screen.instructionBase1;
instruction_two = data.stimuli.screen.instructionBase2;
instruction_three = data.stimuli.screen.instructionBase3;
instruction_four = data.stimuli.screen.instructionBase4;
% Instruction array
instructions = {instruction_one instruction_two instruction_three instruction_four};

% Experiment Start  definition
ExStart_one = data.stimuli.screen.exstart1;
ExStart_two = data.stimuli.screen.exstart2;
ExStart_three = data.stimuli.screen.exstart3;
ExStart_four = data.stimuli.screen.exstart4;
% Instruction array
ExStarts = {ExStart_one ExStart_two ExStart_three ExStart_four};

% Question definition one
first_question_one = data.stimuli.screen.meet_question1;
first_question_two = data.stimuli.screen.read_question1;
% Question array
first_questions = {first_question_one first_question_two};

% Question definition two
second_question_one = data.stimuli.screen.meet_question2;
second_question_two = data.stimuli.screen.read_question2;
% Question array
second_questions = {second_question_one second_question_two};

% Screen Size 
screenWidth = data.prefs.screen.scrsz(3);
screenHeight = data.prefs.screen.scrsz(4);
    
% Hide Cursor
HideCursor();

% Initialize the Escape Check 
% Empty all commands, start listening them
FlushEvents('keyDown');
ListenChar(1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% INSTRUCTION BASELINE

% Initialize start time for data storing 
data.prefs.present.start_time = GetSecs;

% Loop for all four instruction screens 
for j = 1:4
    % InstructionOnSet Data Storing 
    Tec_DataStoring('InstructionOnSet', num2str(j))
    % LSL Marker (equal time stamp strategy as in Tec_DataStoring)
    marker_str = ['InstructionOnSet',';','InstructionNumber:',num2str(j),';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);    
    
    % First Instruction part 
    current_instruction = instructions{j};
    % Flip Window
    Screen('CopyWindow', current_instruction, data.prefs.screen.window1);
    Screen(data.prefs.screen.window1, 'Flip');    
        
    % Click while loop 
    click = 0;
    while ~click    
        % Get response 
        [~, ~, click] = GetMouse; 

    end

    % InstructionClick Data Storing 
    Tec_DataStoring('InstructionClick',num2str(j))
    % LSL Marker 
    marker_str = ['InstructionClick',';','InstructionNumber:',num2str(j),';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);  
    
    % BlackScreenOnSet Data Storing 
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);  
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)
    
end 


%% Instruction Escape 

% After every instruction and every trial the KbGetResponse function waits 
% for one second, if the participant wants to escape, only in this time 
% window this is possible 
[response, ~] = KbGetResponse(27, 1, 0);

if response==27
    % InstructionEscapeOnSet Data Storing 
    Tec_DataStoring('InstructionEscapeOnSet')
    % LSL Marker 
    marker_str = ['InstructionEscapeOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);  
    
    % Escape Screen Flip
    Screen('CopyWindow', data.stimuli.screen.escape, data.prefs.screen.window1);
    Screen(data.prefs.screen.window1, 'Flip');
    pause(1.5)
    
    % Closing Routine
    Tec_Save;
    return;  
    
end   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% BASELINE 

% Start iterating through the first block 
for t = 1:length(blocks{1})   
    % Count the trials 
    data.prefs.present.trial_count_all = data.prefs.present.trial_count_all + 1; 
    
    %% Click to continue    

    % BaseClickToContinueOnSet Data Storing 
    Tec_DataStoring('ClickToContinueOnSet')
    % LSL Marker 
    marker_str = ['ClickToContinueOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);  
    
    % Window Flip 
    Screen('CopyWindow', click_txt, data.prefs.screen.window1);
    Screen(data.prefs.screen.window1, 'Flip');

    % Click while loop 
    click = 0;
    while ~click
        % Get response 
        [~, ~, click] = GetMouse;   

    end 

    % ClickToContinueClick Data Storing 
    Tec_DataStoring('ClickToContinueClick')
    % LSL Marker 
    marker_str = ['ClickToContinueClick',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);  
    
    % BlackScreenOnSet Data Storing  
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)
    
    
    %% Prior adjustments 
    
    % Name of stim file 
    tarstim = char(blocks{1}(list_baseline(t)));
    
    % Directory of file 
    tarpath = [data.prefs.present.stimpath,tarstim,'.jpg'];

    % Read image for processing 
    tarimg = imread(tarpath);


    %% Inter trial interval with fixation cross
    
    % Choose current iti
    iti_dur = data.prefs.present.iti_durations(data.prefs.present.trial_count_all);
    
    % Fixation cross
    Screen('DrawLine', data.prefs.screen.window1, data.prefs.screen.colors.standtextcol,...
        data.prefs.screen.center(1)-cw, data.prefs.screen.center(2),...
        data.prefs.screen.center(1)+cw, data.prefs.screen.center(2), pw);
    Screen('DrawLine', data.prefs.screen.window1, data.prefs.screen.colors.standtextcol,...
        data.prefs.screen.center(1),    data.prefs.screen.center(2)-cw, data.prefs.screen.center(1),...
        data.prefs.screen.center(2)+cw, pw);
    
    % FixationCrossOnSet Data Storing 
    Tec_DataStoring('FixationCrossOnSet')
    % LSL Marker 
    marker_str = ['FixationCrossOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);

    % Window Flip 
    Screen('Flip', data.prefs.screen.window1, [], 1, 0);
    pause(iti_dur)


    %% Simple first ERP analyses with fixation cross

    % Show stimulus       
    tartex = Screen('MakeTexture', data.prefs.screen.window1, double(tarimg));
    % Scale image with 1/2 (images were rendered with higher resolution for 
    % better quality)
    rect = [0 0 screenWidth screenHeight];
    dstRects = CenterRectOnPointd(rect, screenWidth/2, screenHeight/2);
    % Draw it 
    Screen('DrawTexture', data.prefs.screen.window1, tartex, [], dstRects);
    
    % Draw Fixation Cross above
    Screen('DrawLine', data.prefs.screen.window1, data.prefs.screen.colors.standtextcol,...
        data.prefs.screen.center(1)-cw, data.prefs.screen.center(2),...
        data.prefs.screen.center(1)+cw, data.prefs.screen.center(2), pw);
    Screen('DrawLine', data.prefs.screen.window1, data.prefs.screen.colors.standtextcol,...
        data.prefs.screen.center(1),    data.prefs.screen.center(2)-cw, data.prefs.screen.center(1),...
        data.prefs.screen.center(2)+cw, pw);
    
    % FixationCrossAndStimulusOnSet Data Storing
    Tec_DataStoring('FixationCrossAndStimulusOnSet',tarstim)  
    % LSL Marker 
    marker_str = ['FixationCrossAndStimulusOnSet',';','Stimulus:',tarstim,';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Window flip
    Screen('Flip', data.prefs.screen.window1, [], 1, 0);
    pause(0.5)

    
    %% Show stimulus only 
    
    % Show stimulus       
    tartex = Screen('MakeTexture', data.prefs.screen.window1, double(tarimg));
    % Scale image with 1/2 (images were rendered with higher resolution for 
    % better quality)
    rect = [0 0 screenWidth screenHeight];
    dstRects = CenterRectOnPointd(rect, screenWidth/2, screenHeight/2);
    % Draw it 
    Screen('DrawTexture', data.prefs.screen.window1, tartex, [], dstRects);
    
    % StimulusOnSet Data Storing 
    Tec_DataStoring('StimulusOnSet',tarstim)
    % LSL Marker 
    marker_str = ['StimulusOnSet',';','Stimulus:',tarstim,';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Window Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(4)
    
    % BlackScreenOnSet Data Storing  
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)                     

                                    
    %% Likert Questions 
    
    % Randomize likert questions
    var_lik = randperm(3,3);
    

    %% Likert 1 
    
    % LikertOnSet Data Storing 
    Tec_DataStoring(strcat('LikertOnSet',strcat('_',num2str(var_lik(1)))))
    % LSL Marker 
    marker_str = ['LikertOnSet',';','Likert:',num2str(var_lik(1)),';', ...
        'TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Likert Flip and Response Catch
    [resp, ~] = Tec_Likert(data.prefs.screen.window1,data.prefs.screen.scrsz,7,var_lik(1));
    % LikertClick Moment Data Storing 
    Tec_DataStoring(strcat('LikertClick',strcat('_',num2str(var_lik(1)))),num2str(resp))
    % LSL Marker 
    marker_str = [strcat('LikertClick',';','Likert:',num2str(var_lik(1))),';','LikertResponse:',num2str(resp), ';', ...
        'TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    
    % BlackScreenOnSet Data Storing  
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)


    %% Likert 2 
    
    % LikertOnSet Data Storing 
    Tec_DataStoring(strcat('LikertOnSet',strcat('_',num2str(var_lik(2)))))
    % LSL Marker 
    marker_str = ['LikertOnSet',';','Likert:',num2str(var_lik(2)),';', ...
        'TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Likert Flip and Response Catch
    [resp, ~] = Tec_Likert(data.prefs.screen.window1,data.prefs.screen.scrsz,7,var_lik(2));
    % LikertClick Moment Data Storing 
    Tec_DataStoring(strcat('LikertClick',strcat('_',num2str(var_lik(2)))),num2str(resp))
    % LSL Marker 
    marker_str = [strcat('LikertClick',';','Likert:',num2str(var_lik(2))),';','LikertResponse:',num2str(resp),';', ...
        'TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    
    % BlackScreenOnSet Data Storing  
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)


    %% Likert 3 
    
    % LikertOnSet Data Storing 
    Tec_DataStoring(strcat('LikertOnSet',strcat('_',num2str(var_lik(3)))))
    % LSL Marker 
    marker_str = ['LikertOnSet',';','Likert:',num2str(var_lik(3)),';', ...
        'TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Likert Flip and Response Catch
    [resp, ~] = Tec_Likert(data.prefs.screen.window1,data.prefs.screen.scrsz,7,var_lik(3));
    % LikertClick Moment Data Storing 
    Tec_DataStoring(strcat('LikertClick',strcat('_',num2str(var_lik(3)))),num2str(resp))
    % LSL Marker 
    marker_str = [strcat('LikertClick',';','Likert:',num2str(var_lik(3))),';','LikertResponse:',num2str(resp), ';', ...
        'TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    
    % BlackScreenOnSet Data Storing  
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','EndTrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)
    
    
    %% Escape Check Baseline
    
    [response, ~] = KbGetResponse(27, 1, 0);

    if response==27
        % InstructionEscapeOnSet Data Storing 
        Tec_DataStoring('BaselineEscapeOnSet')
        % LSL Marker 
        marker_str = ['BaselineEscapeOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
        Tec_Markers(1, marker_str);
        % Escape Screen Flip
        Screen('CopyWindow', data.stimuli.screen.escape, data.prefs.screen.window1);
        Screen(data.prefs.screen.window1, 'Flip');
        pause(1.5)

        % Closing Routine
        Tec_Save;
        return;  

    end   

end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Halftime Break between Baseline and Experiment 
% Get right window 
Screen('CopyWindow', data.stimuli.screen.break1, data.prefs.screen.window1);

% ExperimentHalftimeOnSet Data Storing 
Tec_DataStoring('ExperimentHalftimeOnSet')
% LSL Marker 
marker_str = ['ExperimentHalftimeOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
Tec_Markers(1, marker_str);

% Halftime Flip
Screen(data.prefs.screen.window1, 'Flip');
pause(120)

% BlackScreenOnSet Data Storing  
Tec_DataStoring('BlackScreen')
% LSL Marker 
marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
Tec_Markers(1, marker_str);
% Black Screen Flip
Screen(data.prefs.screen.window1, 'Flip');
pause(0.5)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% START EXPERIMENT

% Loop for all four experiment instruction screens 
for i = 1:4
    % StartExperiment Data Storing 
    Tec_DataStoring('StartExperimentOnSet',num2str(i))
    % LSL Marker 
    marker_str = ['StartExperimentOnSet',';','InstructionNumber:',num2str(i),';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);

    % Get current startEx Screen 
    current_startExs = ExStarts{i};
    % Flip Window
    Screen('CopyWindow', current_startExs, data.prefs.screen.window1);
    Screen(data.prefs.screen.window1, 'Flip');    
        
    % Click while loop 
    click = 0;
    while ~click    
        % Get response 
        [~, ~, click] = GetMouse; 

    end

    % StartExperiment Data Storing 
    Tec_DataStoring('StartExperimentClick',num2str(i))
    % LSL Marker 
    marker_str = ['StartExperimentClick',';','InstructionNumber:',num2str(i),';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);

    % BlackScreenOnSet Data Storing 
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)
    
end 


%% Start Experiment Escape 

[response, ~] = KbGetResponse(27, 1, 0);

if response==27
    % InstructionEscapeOnSet Data Storing 
    Tec_DataStoring('ExperimentEscapeOnSet')
    % LSL Marker 
    marker_str = ['ExperimentEscapeOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Escape Screen Flip
    Screen('CopyWindow', data.stimuli.screen.escape, data.prefs.screen.window1);
    Screen(data.prefs.screen.window1, 'Flip');
    pause(1.5)

    % Closing Routine
    Tec_Save;
    return;  

end   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% EXPERIMENT 

% Construct array of alternately ones and twos in the same number as there 
% are trials in the experiment 
quest_arr = [ones((ntrials_experiment(1)),1)];
for u = 1:2:length(quest_arr)
    quest_arr(u) = quest_arr(u)*2;
end 

quest_arr_rand = [];

% Parse the meet/read questions in the same way as the stims are randomized 
for p = 1:length(blocks{2})
    quest_arr_rand = [quest_arr_rand quest_arr(list_experiment(p))];
end 
% Transpose 
quest_arr_rand = quest_arr_rand';


%% Start iterating through all stims in the experiment csv 

for t = 1:length(blocks{2})        
    % Continue with trial count 
    data.prefs.present.trial_count_all = data.prefs.present.trial_count_all +1;
    data.prefs.present.trial_count_exp = data.prefs.present.trial_count_exp +1;
    
    
    %% Initialize the Escape Check
    FlushEvents('keyDown');
    ListenChar;
    
    
    %% Click to continue
    
    % ClickToContinueOnSet Data Storing 
    Tec_DataStoring('ClickToContinueOnSet')
    % LSL Marker 
    marker_str = ['ClickToContinueOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    
    % Screen Set and Flip
    Screen('CopyWindow', click_txt, data.prefs.screen.window1);
    Screen(data.prefs.screen.window1, 'Flip');
        
    % Click Loop 
    click = 0;
    while ~click
        % Get response 
        [~, ~, click] = GetMouse;
        
    end
    
    % ClickToContinueClick Moment Data Storing 
    Tec_DataStoring('ClickToContinueClick')
    % LSL Marker 
    marker_str = ['ClickToContinueClick',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);

    % BlackScreenOnSet Data Storing  
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)
      
    
    %% Adjustments 

    tarstim = char(blocks{2}(list_experiment(t)));
    tarpath = [data.prefs.present.stimpath,tarstim,'.jpg'];
    tarimg = imread(tarpath);
    

    %% First question to show up - "Would you ...?"

    % Adjustments
    current_question_one = first_questions{quest_arr_rand(data.prefs.present.trial_count_exp)};
    Screen('CopyWindow', current_question_one, data.prefs.screen.window1);

    % QuestionOneOnSet Data Storing 
    Tec_DataStoring('QuestionOneOnSet',num2str(quest_arr_rand(data.prefs.present.trial_count_exp)))
    % LSL Marker 
    marker_str = ['QuestionOneOnSet',';','QuestionType:',num2str(quest_arr_rand(data.prefs.present.trial_count_exp)),...
        ';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Window Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(1.5)

    % BlackScreenOnSet Data Storing  
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)

    % Inter trial interval with fixation cross
    iti_dur = data.prefs.present.iti_durations(data.prefs.present.trial_count_all);

    % Fixation Cross
    Screen('DrawLine', data.prefs.screen.window1, data.prefs.screen.colors.standtextcol,...
        data.prefs.screen.center(1)-cw, data.prefs.screen.center(2),...
        data.prefs.screen.center(1)+cw, data.prefs.screen.center(2), pw);
    Screen('DrawLine', data.prefs.screen.window1, data.prefs.screen.colors.standtextcol,...
        data.prefs.screen.center(1),    data.prefs.screen.center(2)-cw, data.prefs.screen.center(1),...
        data.prefs.screen.center(2)+cw, pw);

    % FixationCrossOnSet Data Storing 
    Tec_DataStoring('FixationCrossOnSet')
    % LSL Marker 
    marker_str = ['FixationCrossOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Window Flip
    Screen('Flip', data.prefs.screen.window1, [], 1, 0);
    pause(iti_dur)


    %% Simple first ERP analyses with fixation cross

    % Show stimulus       
    tartex = Screen('MakeTexture', data.prefs.screen.window1, double(tarimg));
    % Scale image with 1/2 (images were rendered with higher resolution for 
    % better quality)
    rect = [0 0 screenWidth screenHeight];
    dstRects = CenterRectOnPointd(rect, screenWidth/2, screenHeight/2);
    % Draw it 
    Screen('DrawTexture', data.prefs.screen.window1, tartex, [], dstRects);

    % Draw Fixation Cross above
    Screen('DrawLine', data.prefs.screen.window1, data.prefs.screen.colors.standtextcol,...
        data.prefs.screen.center(1)-cw, data.prefs.screen.center(2),...
        data.prefs.screen.center(1)+cw, data.prefs.screen.center(2), pw);
    Screen('DrawLine', data.prefs.screen.window1, data.prefs.screen.colors.standtextcol,...
        data.prefs.screen.center(1),    data.prefs.screen.center(2)-cw, data.prefs.screen.center(1),...
        data.prefs.screen.center(2)+cw, pw);

    % FixationCrossAndStimulusOnSet Data Storing 
    Tec_DataStoring('FixationCrossAndStimulusOnSet',tarstim)
    % LSL Marker 
    marker_str = ['FixationCrossAndStimulusOnSet',';','Stimulus:',tarstim,';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Window flip
    Screen('Flip', data.prefs.screen.window1, [], 1, 0);
    pause(0.5)


    %% Show Stimulus only        
    tartex = Screen('MakeTexture', data.prefs.screen.window1, double(tarimg));
    % Scale image with 1/2 (images were rendered with higher resolution for 
    % better quality)
    rect = [0 0 screenWidth screenHeight];
    dstRects = CenterRectOnPointd(rect, screenWidth/2, screenHeight/2);
    % Draw it 
    Screen('DrawTexture', data.prefs.screen.window1, tartex, [], dstRects);

    % StimulusOnSet Data Storing 
    Tec_DataStoring('StimulusOnSet',tarstim)
    % LSL Marker 
    marker_str = ['StimulusOnSet',';','Stimulus:',tarstim,';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Window flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(4)

    % BlackScreenOnSet Data Storing   
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)

    
    %% Second question to show up "Where would you ...?"

    % Adjustments
    current_question_two = second_questions{quest_arr_rand(data.prefs.present.trial_count_exp)};
    Screen('CopyWindow', current_question_two, data.prefs.screen.window1);

    % QuestionTwoOnSet Data Storing 
    Tec_DataStoring('QuestionTwoOnSet',num2str(quest_arr_rand(data.prefs.present.trial_count_exp)))
    % LSL Marker 
    marker_str = ['QuestionTwoOnSet',';','QuestionType:',num2str(quest_arr_rand(data.prefs.present.trial_count_exp)),...
        ';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Window Flip 
    Screen(data.prefs.screen.window1, 'Flip');
    pause(1.5)


    %% Click to choose

    % Change Cursor to Cross, Set position and show 
    SetMouse(data.prefs.screen.scrsz(3)/2, data.prefs.screen.scrsz(4)/2)
    ShowCursor(2);

    % ClickToChooseOnSet Data Storing
    Tec_DataStoring('ClickToChooseOnSet')
    % LSL Marker 
    marker_str = ['ClickToChooseOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);


    % Show stimulus as the field for choosing the favorite coordinates       
    tartex = Screen('MakeTexture', data.prefs.screen.window1, double(tarimg));
    % Scale image with 1/2 (images were rendered with higher resolution for 
    % better quality)
    rect = [0 0 screenWidth screenHeight];
    dstRects = CenterRectOnPointd(rect, screenWidth/2, screenHeight/2);
    % Draw it 
    Screen('DrawTexture', data.prefs.screen.window1, tartex, [], dstRects);
    % Flip it to bring it from front buffer to main buffer 
    Screen(data.prefs.screen.window1, 'Flip');

    % Wait for Participant to choose coordinates for answering the question    
    % while loop
    click = 0;
    while ~click
        
        % Get response in x and y coordinates and a boolean for buttons
        % pressed (pressed = 1, not pressed = 0)
        [cursorX, cursorY, clicks] = GetMouse;
        % Get out of loop when clicked
        click = clicks(1);

    end 

    % Hide cursor again 
    HideCursor;

    % ClickToChooseClick Data Storing 
    Tec_DataStoring('ClickToChooseClick',num2str(cursorX),num2str(cursorY))
    % LSL Marker 
    marker_str = ['ClickToChooseOnSet',';','CoordinateX:',num2str(cursorX),';','CoordinateY:',num2str(cursorY),';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Window flip 
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)

    % BlackScreenOnSet Data Storing  
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)
    

    %% Likert 4 - "How likely ...?"

    % LikertOnSet Data Storing 
    Tec_DataStoring(strcat('LikertOnSet',strcat('_',num2str(quest_arr_rand(data.prefs.present.trial_count_exp)+3))))
    % LSL Marker 
    marker_str = ['LikertOnSet',';','Likert:',num2str(quest_arr_rand(data.prefs.present.trial_count_exp)+3),...
        ';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Likert Flip 
    [resp, ~] = Tec_Likert(data.prefs.screen.window1,data.prefs.screen.scrsz,7,...
        quest_arr_rand(data.prefs.present.trial_count_exp)+3);
    % LikertClick Moment Data Storing 
    Tec_DataStoring(strcat('LikertClick',strcat('_',num2str(quest_arr_rand(data.prefs.present.trial_count_exp)+3))),num2str(resp))
    % LSL Marker 
    marker_str = ['LikertClick',';','Likert:',num2str(quest_arr_rand(data.prefs.present.trial_count_exp)+3),';','LikertResponse:',num2str(resp)...
        ';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);

    % BlackScreenOnSet Data Storing    
    Tec_DataStoring('BlackScreen')
    % LSL Marker 
    marker_str = ['BlackScreen',';','EndTrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
    Tec_Markers(1, marker_str);
    % Black Screen Flip
    Screen(data.prefs.screen.window1, 'Flip');
    pause(0.5)


    %% Escape Check Experiment

    [response, ~] = KbGetResponse(27, 1, 0);

    if response==27
        % InstructionEscapeOnSet Data Storing 
        Tec_DataStoring('BaselineEscapeOnSet')
        % LSL Marker 
        marker_str = ['BaselineEscapeOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
        Tec_Markers(1, marker_str);
        % Escape Screen Flip
        Screen('CopyWindow', data.stimuli.screen.escape, data.prefs.screen.window1);
        Screen(data.prefs.screen.window1, 'Flip');
        pause(1.5)

        % Closing Routine
        Tec_Save;
        return;  

    end   
       
    
    %% Breaks 
    
    % First quarterbreak
    if data.prefs.present.trial_count_exp == length(blocks{2})/4 
        % Draw screen 
        Screen('CopyWindow', data.stimuli.screen.break2, data.prefs.screen.window1);
        
        % ExperimentQuarterbreakOnSet Data Storing 
        Tec_DataStoring('ExperimentFirstQuarterbreakOneOnSet')
        % LSL Marker 
        marker_str = ['ExperimentFirstQuarterbreakOneOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
        Tec_Markers(1, marker_str);

        % Quarterbreak flip
        Screen(data.prefs.screen.window1, 'Flip');
        pause(120)

        % BlackScreenOnSet Data Storing  
        Tec_DataStoring('BlackScreen')
        % LSL Marker 
        marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
        Tec_Markers(1, marker_str);
        % Black Screen Flip
        Screen(data.prefs.screen.window1, 'Flip');
        pause(0.5)
    
    % Second Quarterbreak - Halftime      
    elseif data.prefs.present.trial_count_exp == length(blocks{2})/2
        % Draw screen 
        Screen('CopyWindow', data.stimuli.screen.break3, data.prefs.screen.window1);
        
        % ExperimentQuarterbreakTwoOnSet Data Storing 
        Tec_DataStoring('ExperimentHalftimeOnSet')
        % LSL Marker 
        marker_str = ['ExperimentHalftimeOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
        Tec_Markers(1, marker_str);

        % Quarterbreak flip
        Screen(data.prefs.screen.window1, 'Flip');
        pause(120)

        % BlackScreenOnSet Data Storing  
        Tec_DataStoring('BlackScreen')
        % LSL Marker 
        marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
        Tec_Markers(1, marker_str);
        % Black Screen Flip
        Screen(data.prefs.screen.window1, 'Flip');
        pause(0.5)
    
    % Third quarterbreak
    elseif data.prefs.present.trial_count_exp == length(blocks{2})*3/4
        % Get right window 
        Screen('CopyWindow', data.stimuli.screen.break4, data.prefs.screen.window1);

        % ExperimentHalftimeOnSet Data Storing 
        Tec_DataStoring('ExperimentThirdQuarterbreakOnSet')
        % LSL Marker 
        marker_str = ['ExperimentThirdQuarterbreakOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
        Tec_Markers(1, marker_str);

        % Third quarterbreak Flip
        Screen(data.prefs.screen.window1, 'Flip');
        pause(120)

        % BlackScreenOnSet Data Storing  
        Tec_DataStoring('BlackScreen')
        % LSL Marker 
        marker_str = ['BlackScreen',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
        Tec_Markers(1, marker_str);
        % Black Screen Flip
        Screen(data.prefs.screen.window1, 'Flip');
        pause(0.5)

    end 

end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% End Screen 

% Get right window
Screen('CopyWindow', data.stimuli.screen.end, data.prefs.screen.window1);

% EndScreenOnSet Data Storing 
Tec_DataStoring('EndScreenOnSet')
% LSL Marker 
marker_str = ['EndScreenOnSet',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
Tec_Markers(1, marker_str);

% End screen flip
Screen(data.prefs.screen.window1, 'Flip');
pause(5)


%% END TIME 

% EndTime Data Storing 
Tec_DataStoring('EndTime')
% LSL Marker 
marker_str = ['EndTime',';','TrialNumber:',num2str(data.prefs.present.trial_count_all),';'];
Tec_Markers(1, marker_str);


%% Closing routine 

Tec_Save; 
