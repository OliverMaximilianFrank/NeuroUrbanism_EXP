function Tec_Markers(arg1,arg2)
% input arguments:
% arg1: run mode (initialization vs. marker sending)
% arg2: string marker description (see marker table)


global data

switch arg1     %run mode for this function
    
    
    %% initialization
    case 0
       
        
        
        % set up labstreaminglayer (lsl)
        disp('Loading LSL library...');
        lib = lsl_loadlib();                                                %for this to work, the Matlab LSL wrapper has to be on the path (with all sub-folders)
        

        data.output.LSL.MarkerStreamName = 'Tectonic_Markers';          % helpful name known to the experimenter
        data.output.LSL.ContentType = 'Markers';                        % by convention, LSL markers are of type 'Marker'
        data.output.LSL.nChannels = 1;                                  % have 2 channel per experiemnt
        data.output.LSL.regularRate = 0;                                % are sampled irregularly; regular streams get special treatment on import which would greatly disrupt marker synchronicity
        data.output.LSL.dataFormat = 'cf_string';                       % and are of string format
        data.output.LSL.uniqueSourceID = 'myuniquesourceid2021';       % could be anything; might be used for continuing recording after PC or nework trouble


        disp('Creating a new marker stream info...');                       %containing all the above settings
        info = lsl_streaminfo(lib,data.output.LSL.MarkerStreamName,data.output.LSL.ContentType,data.output.LSL.nChannels,data.output.LSL.regularRate,data.output.LSL.dataFormat,data.output.LSL.uniqueSourceID);
        
        disp('Opening an outlet...');
        data.output.LSL.outlet = lsl_outlet(info);                          %this is where markers are 'written' to
        disp('Done.')
        
        pause(1);
        
    
    %% regular marker sending
    case 1
        

        data.output.LSL.outlet.push_sample({arg2});
                
    
    %% de-initialization
    case 2
        
        % log the experiment end time (helpful for cutting surplus physiological data in order to reduce file sizes)
        data.output.endMeasurement = GetSecs;

        marker_str = [];
        marker_str = [marker_str, 'measurement:end;'];
        data.output.LSL.outlet.push_sample({marker_str});

end