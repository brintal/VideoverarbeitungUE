function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
    %----------------------------------------------------------------------
    % Task c: Generate cost-volume
    %----------------------------------------------------------------------
   
    
    %ACHTUNG: Wird im Moment nur für den ersten Frame berechnet! Schleife fehlt
    %noch!
    [m,n,o]=size(frames(:,:,1));
    for i=1:m
        for j=1:n
            
            %Zuerst müssen wir uns für den Farbwert jedes Pixels den
            %entsprechenden "Bin" suchen wo der Farbwert enthalten ist
            imr=double(frames(i,j,1,1));
            img=double(frames(i,j,2,1));
            imb=double(frames(i,j,3,1));
            f=double(bins)/256.0;
            relevantBin=floor(imr*f) + floor(img*f)*bins + floor(imb*f)*bins*bins+1; 

            %diesen Bin verwenden wir um die volume-cost zu berechnen und
            %zu überprüfen ob es sich um Teil des Vordergrunds handelt.
            %Falls ja speichern wir den Pixel in die foreground_map
            if (( (Hfc(relevantBin)/(Hfc(relevantBin)+Hbc(relevantBin))))>0.5)
                foreground_map(i,j,1,1) = double(frames(i,j,1,1))/256.0;
                foreground_map(i,j,2,1) = double(frames(i,j,2,1))/256.0;
                foreground_map(i,j,3,1) = double(frames(i,j,3,1))/256.0;
            end
        end
    end
    image (foreground_map(:,:,:,1));
    
    
    %----------------------------------------------------------------------
    % Task e: Filter cost-volume with guided filter
    %----------------------------------------------------------------------
 
    
    %----------------------------------------------------------------------
    % Task f: delete regions which are not connected to foreground scribble
    %----------------------------------------------------------------------
    

    %----------------------------------------------------------------------
    % Task g: Guided feathering
    %----------------------------------------------------------------------
    foreground_map=[];
    
    
end
