function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
    %----------------------------------------------------------------------
    % Task c: Generate cost-volume
    %----------------------------------------------------------------------
   
    
    %ACHTUNG: Wird im Moment nur für den ersten Frame berechnet! Schleife fehlt
    %noch!
    [m,n,o,p]=size(frames(:,:,:,:));
    foreground_map = zeros(m,n,o);
    foreground_map_new = zeros(m,n,o);    
    
    %ACHTUNG MUSS ENTFERNT WERDEN
    %p=1;
    
    for h=1:p
        for i=1:m
            for j=1:n

                %Zuerst müssen wir uns für den Farbwert jedes Pixels den
                %entsprechenden "Bin" suchen wo der Farbwert enthalten ist
                imr=double(frames(i,j,1,h));
                img=double(frames(i,j,2,h));
                imb=double(frames(i,j,3,h));
                f=double(bins)/256.0;
                relevantBin=floor(imr*f) + floor(img*f)*bins + floor(imb*f)*bins*bins+1; 

                %diesen Bin verwenden wir um die volume-cost zu berechnen und
                %zu überprüfen ob es sich um Teil des Vordergrunds handelt.
                %Falls ja speichern wir den Pixel in die foreground_map

    %             if (( (Hfc(relevantBin)/(Hfc(relevantBin)+Hbc(relevantBin))))>0.5)
    %                 foreground_map(i,j,1,1) = double(frames(i,j,1,1))/256.0;
    %                 foreground_map(i,j,2,1) = double(frames(i,j,2,1))/256.0;
    %                 foreground_map(i,j,3,1) = double(frames(i,j,3,1))/256.0;    
    % 
    %             end

                %Wir erstellen eine 3 dimensionale Matrix mit der cost-volume
                %information für jeden einzelnen pixel. Muss einkommentiert werden. 
                %Benötigt zum Aufrufen des Guidedfilters (siehe unten)
                foreground_map(i,j,h) =  Hfc(relevantBin)/(Hfc(relevantBin)+Hbc(relevantBin)); 
            end
        end
    end
    foreground_map(isnan(foreground_map))=0;
    disp(foreground_map);
    imshow (foreground_map(:,:,1));
    %foreground_map_new=rgb2gray(foreground_map(:,:,:,1));
    %image (rgb2gray(foreground_map(:,:,:,1)));
    
    %----------------------------------------------------------------------
    % Task e: Filter cost-volume with guided filter
    %----------------------------------------------------------------------
    
    %Direktes Aufrufen des Boxfilters funktioniert, muss aber durch den
    %Auruf von guidedfilter_vid_color ersetzt werden.
     %vidDst = boxfilter_vid(foreground_map, 3, 1)
     %vidDst(:,:,1,:)=double(vidDst(:,:,1,:))/256.0;
     %vidDst(:,:,2,:)=double(vidDst(:,:,2,:))/256.0;
     %vidDst(:,:,3,:)=double(vidDst(:,:,3,:))/256.0;
     %image (vidDst(:,:,:,1));
        
    %Hier muss der guidedfilter in irgendeiner Art aufgerufen werden. Das
    %funktioniert aber noch nicht!
    eps = 0.1^2;
    vidDst = guidedfilter_vid_color(frames, foreground_map, 3, 1, eps);
    vidDst(isnan(vidDst))=0;
    thresholdVal=8;
    vidDst=floor(vidDst.*thresholdVal);
    vidDst=ceil(vidDst.*(1/thresholdVal));
    
    
    %----------------------------------------------------------------------
    % Task f: delete regions which are not connected to foreground scribble
    %----------------------------------------------------------------------
    
    connected_vidDst=keepConnected(vidDst(:,:,:),FGScribbles);

    
    %----------------------------------------------------------------------
    % Task g: Guided feathering
    %----------------------------------------------------------------------
    vidDst = guidedfilter_vid_color(frames, connected_vidDst, 3, 1, eps);
    vidDst(isnan(vidDst))=0;
    vidDst=floor(vidDst.*thresholdVal);
    vidDst=ceil(vidDst.*(1/thresholdVal));
    
    imshow (vidDst(:,:,2));
    foreground_map=vidDst;
    
    
end
