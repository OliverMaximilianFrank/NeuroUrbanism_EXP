function Tec_Input

global data     


%% Logging

% Get time for orientation in later analysis, saved as strings
% Create a concise date/time string
t = clock;      
data.input.startTimeString = [num2str(t(1)),'-',num2str(t(2)),'-',num2str(t(3)),'-',num2str(t(4)),'-',num2str(t(5))];   


%% VP Counter 

% Count the number of participants by counting the stored data files in the
% data folder 
% Note: If the folder is empty, the first participant is conducted 
if isempty(dir(strcat(pwd,'\Data'))) 
    data.input.ParticipantNumber = '1';
else 
    data.input.ParticipantNumber = num2str(length(dir(strcat(pwd,'\Data'))) -1);
end 