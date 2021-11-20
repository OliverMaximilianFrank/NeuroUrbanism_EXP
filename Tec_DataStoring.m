function Tec_DataStoring(name,first,second)

global data 

% Timer
current_time = GetSecs;
event_time = current_time - data.prefs.present.start_time;
% Event Counter
data.prefs.present.events = data.prefs.present.events +1; 
% Store in struct
if nargin == 1
    data.output.results(data.prefs.present.events,:) = {name,num2str(data.prefs.present.trial_count_all),...
            num2str(event_time)};
elseif nargin == 2
    data.output.results(data.prefs.present.events,:) = {strcat(name,'_',first),...
        num2str(data.prefs.present.trial_count_all),num2str(event_time)};  
else
    data.output.results(data.prefs.present.events,:) = {strcat(name,'_',first,'_',second),...
        num2str(data.prefs.present.trial_count_all),num2str(event_time)};  
end
    
end 