function Tec_Save

global data;

% save the complete experiment variable 'data' to a Matlab data file
save(data.prefs.output.matfFilename,'data');

% De-initialize the marker system with the parameter '2'
Tec_Markers(2);        
    
% Close experiment 
Screen('CloseAll')

