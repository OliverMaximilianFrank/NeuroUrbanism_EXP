function Tec_Stimuli

global data

%% All text modules needed in Tec_Core are previously drawn here 

% CLICK TO CONTINUE 
% Open an offscreen window
data.stimuli.screen.click = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a string
data.stimuli.text.click = 'Please click to continue.';         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.click, data.stimuli.text.click,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);  


% INSTRUCTION BASE1
% Open an offscreen window
data.stimuli.screen.instructionBase1 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text lines as chars
new = newline;
first = 'You are now prepared to start the first part of the experiment.';
second = 'In this part we will show you a fixation cross';
third = 'and then an image of a space.';
fourth = 'Simply look at the space (it will disappear after some seconds).';
fifth = 'Please click to continue.';
data.stimuli.text.instructionBase1 = [first new second new third new fourth new new fifth];             
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.instructionBase1, data.stimuli.text.instructionBase1,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);  

% INSTRUCTION BASE2
% Open an offscreen window
data.stimuli.screen.instructionBase2 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'We then ask you three questions:';
second = '"1. How beautiful is the space?"';
third = '"2. How interesting is the space?"';
fourth = '"3. How complex is the space?"';
fifth = 'You can indicate the answer by using your mouse';
sixth = 'to press a button on a range from “no at all” to “very much”.';
seventh = 'Please click to continue.';
data.stimuli.text.instructionBase2 = [first new new second new third new fourth ...
    new new fifth new sixth new new seventh];          
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.instructionBase2, data.stimuli.text.instructionBase2,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);  

% INSTRUCTION BASE3
% Open an offscreen window
data.stimuli.screen.instructionBase3 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'There are no right or wrong answers.';
second = 'We are simply interested in your opinion.';
third = 'After you have answered these questions';
fourth = 'the next trial will start soon after.';
fifth = 'Please click to continue.';
data.stimuli.text.instructionBase3 = [first new second new new third new fourth new new fifth];          
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.instructionBase3, data.stimuli.text.instructionBase3,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);  

% INSTRUCTION BASE4
% Open an offscreen window
data.stimuli.screen.instructionBase4 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'Please get ready and fixate first on the fixation cross.';
second = 'Please click to continue.';
data.stimuli.text.instructionBase4 = [first new new second];          
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.instructionBase4, data.stimuli.text.instructionBase4,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);  


% MEETING1
% Open an offscreen window
data.stimuli.screen.meet_question1 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a string
data.stimuli.text.meet_question1 = 'Would you want to MEET somebody in this space?';         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.meet_question1, data.stimuli.text.meet_question1,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);                                             

% MEETING2
% Open an offscreen window
data.stimuli.screen.meet_question2 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a string
data.stimuli.text.meet_question2 = 'Where would you want to MEET somebody in this space?';         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.meet_question2, data.stimuli.text.meet_question2,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);    


% READING1
% Open an offscreen window
data.stimuli.screen.read_question1 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a string
data.stimuli.text.read_question1 = 'Would you want to READ a book in this space?';         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.read_question1, data.stimuli.text.read_question1,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);    

% READING2
% Open an offscreen window
data.stimuli.screen.read_question2 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
data.stimuli.text.read_question2 = 'Where would you want to READ a book in this space?';         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.read_question2, data.stimuli.text.read_question2,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);   


% EXPERIMENT START1
% Open an offscreen window
data.stimuli.screen.exstart1 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'The second and main part of the experiment starts now.';
second = 'We will show you the spaces again for some seconds.';
third = 'On the beginning of each trial we will ask you'; 
fourth = 'one out of two possible questions:';
fifth = '1. "Would you want to meet somebody here?"';
sixth = '2. "Would you want to read a book here?"';
seventh = 'Please click to continue.';
data.stimuli.text.exstart1 = [first new second new new third new fourth new new fifth new sixth new new seventh];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.exstart1, data.stimuli.text.exstart1,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);

% EXPERIMENT START2
% Open an offscreen window
data.stimuli.screen.exstart2 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'Then we will ask you to indicate WHERE you would want to meet somebody';
second = 'or WHERE you want to read a book.';
third = 'You will be able to indicate the location';
fourth = 'by clicking on the picture with the left mouse button.';
fifth = 'Please click to continue.';
data.stimuli.text.exstart2 = [first new second new new third new fourth new new fifth];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.exstart2, data.stimuli.text.exstart2,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);

% EXPERIMENT START3
% Open an offscreen window
data.stimuli.screen.exstart3 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'Finally we ask you how likely you would to want';
second = 'to meet somebody or read a book at the chosen place.';
third = 'You can indicate the answer by using your mouse';
fourth = 'to press a button on a range from “no at all” to “very much”.';
fifth = 'Please click to continue.';
data.stimuli.text.exstart3 = [first new second new new third new fourth new new fifth];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.exstart3, data.stimuli.text.exstart3,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);

% EXPERIMENT START4
% Open an offscreen window
data.stimuli.screen.exstart4 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = '"Start main experiment"';
second = 'Please click to continue.';
data.stimuli.text.exstart4 = [first new new second];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.exstart4, data.stimuli.text.exstart4,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);


% BREAK1 - AFTER BASELINE 
% Open an offscreen window
data.stimuli.screen.break1 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'Thank you!';
second = 'The first part is over.';
third = 'Please take a break for two minutes.';
fourth = 'We would like you to keep the EEG cap and eyetracker on.';
% put them in an array 
data.stimuli.text.break1 = [first new second new third new fourth]; 
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.break1, data.stimuli.text.break1,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5); 

% BREAK2 - EXPERIMENT FIRST QUARTER
% Open an offscreen window
data.stimuli.screen.break2 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'Thank you!';
second = 'This was the first quarter of the main experiment.';
third = 'Please take a break for two minutes.';
data.stimuli.text.break2 = [first new second new third];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.break2, data.stimuli.text.break2,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);    

% BREAK3 - EXPERIMENT HALF
% Open an offscreen window
data.stimuli.screen.break3 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'Thank you!';
second = 'This was the first half of the main experiment.';
third = 'Please take a break for two minutes.';
data.stimuli.text.break3 = [first new second new third];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.break3, data.stimuli.text.break3,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);

% BREAK4 - EXPERIMENT THIRD QUARTER
% Open an offscreen window
data.stimuli.screen.break4 = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'Thank you!';
second = 'This was the third quarter of the main experiment.';
third = 'Please take a break for two minutes.';
data.stimuli.text.break4 = [first new second new third];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.break4, data.stimuli.text.break4,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);


% END 
% Open an offscreen window
data.stimuli.screen.end = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'Thank you!';
second = 'You are almost done.';
third = 'We will now remove the EEG-cap and the eyetracker';
fourth = 'and then ask you some questions about yourself.';
data.stimuli.text.end = [first new second new third new fourth];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.end, data.stimuli.text.end,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);    


% EXPERIMENT ESCAPE
% Open an offscreen window
data.stimuli.screen.escape = Screen('OpenOffscreenWindow', data.prefs.screen.whichScreen, data.prefs.screen.colors.standbackcol);     
% Define the text as a char
new = newline;
first = 'The Experiment was interrupted.';
second = 'Data incomplete.';
data.stimuli.text.escape = [first new second];         
% Draw this text to the offscreen window
DrawFormattedText(data.stimuli.screen.escape, data.stimuli.text.escape,...
    'center', 'center', data.prefs.screen.colors.standtextcol, [], [], [], 1.5);
