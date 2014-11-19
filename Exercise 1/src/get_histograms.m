function [bok,scribble_count, fg_scribbles, histo_fg, histo_bg] = get_histograms(input_directory,file_list)     
%function [bok,scribble_count, fg_scribbles, histo_fg, histo_bg] = get_histograms(input_directory,file_list,bins) 
    % load reference frame and its foreground and background scribbles
    bok=false;
    scribble_count=0;
    reference_frame=[];
    fg_scribbles=[];
    histo_fg=[];
    histo_bg=[];
    for j = 1:numel(file_list)
        frame_name = file_list(j).name;

        if (strcmp(frame_name(1),'s') == 1) % scribble files begin with s
           frame = imread([input_directory '/' frame_name]); %read image      
           scribble_count=scribble_count +1;
           frames_scribbles(:,:,:,scribble_count) = frame(:,:,:);             
        elseif (strcmp(frame_name(1),'r') == 1) % reference file begin with r
           frame = imread([input_directory '/' frame_name]); % read image     
           reference_frame=uint8(frame(:,:,:));
        end
    end
    frames_scribbles=uint8(frames_scribbles);
   
    if ((scribble_count==2) && (~isempty(reference_frame))) 
        bok=true;
    else 
        return;
    end;
    

    %----------------------------------------------------------------------
    % Task a: Filter user scribbles to indicate foreground and background   
    %----------------------------------------------------------------------

    
    %We create two arrays (foreground, background) with the same size as
    %the reference frame. Initially both arrays are filled with zeros. 
    [m,n,o]=size(reference_frame);
    fg_scribbles_map = zeros(m,n);
    bg_scribbles_map = zeros(m,n);
    for i=1:m
        for j=1:n
            %we compare the foreground scribbles with the reference frame
            %and insert a 1 in our scribble map
            if frames_scribbles(i,j,1,1) ~= reference_frame(i,j,1)
                fg_scribbles_map(i,j)=1;   
            end
            %we do the same for the background scribbles
            if frames_scribbles(i,j,1,2) ~= reference_frame(i,j,1)
                bg_scribbles_map(i,j)=1;   
            end
        end
    end 
    disp(bg_scribbles_map);
    
    

    %----------------------------------------------------------------------
    % Task b: Generate color models for foreground and background
    %----------------------------------------------------------------------
    
    
end