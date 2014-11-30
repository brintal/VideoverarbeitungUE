function [bok,scribble_count, fg_scribbles, histo_fg, histo_bg] = get_histograms(input_directory,file_list,bins) 
    % load reference frame and its foreground and background scribbles
    bok=false;
    scribble_count=0;
    reference_frame=[];
    fg_scribbles=[];
    histo_fg=[];
    histo_bg=[];
    for countX = 1:numel(file_list)
        frame_name = file_list(countX).name;

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
    

    %Wir erzeugen zwei Arrays für Vordergrund und Hintergrund die gleich
    %groß sind wie der Reference-Frame. Initial werden diese mit Nullen
    %gefüllt.
    [sizeY,sizeX,sizeCol]=size(reference_frame);
    fg_scribbles_map = zeros(sizeY,sizeX);
    fg_scribbles_colors = [];
    bg_scribbles_map = zeros(sizeY,sizeX);
    bg_scribbles_colors = [];
    fgCounter = 1;
    bgCounter = 1;
    for countY=1:sizeY
        for countX=1:sizeX
            %Wir vergleichen die Foreground-Scribbles mit dem Reference
            %Frame und fügen eine 1 in die scribbles-map ein
            if frames_scribbles(countY,countX,1,1) ~= reference_frame(countY,countX,1)
                fg_scribbles_map(countY,countX)=1;  
                fg_scribbles_colors(fgCounter,1)=reference_frame(countY,countX,1);
                fg_scribbles_colors(fgCounter,2)=reference_frame(countY,countX,2);
                fg_scribbles_colors(fgCounter,3)=reference_frame(countY,countX,3);
                fgCounter = fgCounter+1;
            end
            %Das gleiche machen wir für den Hintergrund
            if frames_scribbles(countY,countX,1,2) ~= reference_frame(countY,countX,1)
                bg_scribbles_map(countY,countX)=1;   
                bg_scribbles_colors(bgCounter,1)=reference_frame(countY,countX,1);
                bg_scribbles_colors(bgCounter,2)=reference_frame(countY,countX,2);
                bg_scribbles_colors(bgCounter,3)=reference_frame(countY,countX,3);
                bgCounter = bgCounter+1;
            end
        end
    end 

    
    %Rückgabe-Werte setzen
    fg_scribbles=fg_scribbles_map;  
    histo_fg=colHist(fg_scribbles_colors(:,1),fg_scribbles_colors(:,2),fg_scribbles_colors(:,3),bins);
    histo_bg=colHist(bg_scribbles_colors(:,1),bg_scribbles_colors(:,2),bg_scribbles_colors(:,3),bins);

    
end