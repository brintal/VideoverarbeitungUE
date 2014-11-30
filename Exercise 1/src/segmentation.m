function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
    %----------------------------------------------------------------------
    % Task c: Generate cost-volume
    %----------------------------------------------------------------------
   
    
    [sizeY,sizeX,sizeCol,sizeFrame]=size(frames(:,:,:,:));
    foreground_map = zeros(sizeY,sizeX,sizeCol);   
    
    
    
    %Zum Berechnen der Cost-Volume Matrix müssen wir für jeden Frame jeden
    %einzelnen Pixel durchgehen und für diesen die Cost-Volume berechnen.
    for counterFrame=1:sizeFrame
        for counterY=1:sizeY
            for counterX=1:sizeX

                %Zuerst müssen wir uns für den Farbwert jedes Pixels den
                %entsprechenden "Bin" suchen wo der Farbwert enthalten ist
                imr=double(frames(counterY,counterX,1,counterFrame));
                img=double(frames(counterY,counterX,2,counterFrame));
                imb=double(frames(counterY,counterX,3,counterFrame));
                f=double(bins)/256.0;
                relevantBin=floor(imr*f) + floor(img*f)*bins + floor(imb*f)*bins*bins+1; 

                %Diesen Bin verwenden wir um die volume-cost zu berechnen
                %Wir erstellen eine 3 dimensionale Matrix mit der cost-volume
                %information für jeden einzelnen pixel.
                %Benötigt zum Aufrufen des Guidedfilters (siehe unten)
                foreground_map(counterY,counterX,counterFrame) =  Hfc(relevantBin)/(Hfc(relevantBin)+Hbc(relevantBin)); 
            end
        end
    end
    
    %Wir ersetzen alle NaN-Werte durch 0, d.h. weisen sie dem Hintergrund
    %zu
    foreground_map(isnan(foreground_map))=0;

        
    %Wir verwenden die Cost-Volume-Matrix und die original-Frames zum
    %Aufruf des Guided Filters.
    eps = 0.1^2;
    rt = sizeFrame;
    vidDst = guidedfilter_vid_color(frames, foreground_map, 3, rt, eps);
    
    %Wir ersetzen wiederum alle NaN-Werte durch 0
    vidDst(isnan(vidDst))=0;
    
    %Wir wenden auf die gefilterte Matrix einen Grenzwert an, um entweder 0
    %oder 1 als Wert zu erhalten.
    thresholdVal=6;
    vidDst=floor(vidDst.*thresholdVal);
    vidDst=ceil(vidDst.*(1/thresholdVal));
    
    %Durch Aufruf von keepConnected werden alle Bereiche die nicht mit dem
    %FG Scribbles verbunden sind entfernt.
    connected_vidDst=keepConnected(vidDst(:,:,:),FGScribbles);

    %Fürs Guided feathering wird der guided filter noch einmal mit den
    %gleichen Werten aufgerufen, alle NaN-Werte entfernt und mit dem
    %gleichen Grenzwert gerunded.
    vidDst = guidedfilter_vid_color(frames, connected_vidDst, 3, rt, eps);
    vidDst(isnan(vidDst))=0;
    vidDst=floor(vidDst.*thresholdVal);
    vidDst=ceil(vidDst.*(1/thresholdVal));
    
    %Wir setzen die resultierende Matrix mit den Binary Maps als
    %return-Wert
    foreground_map=vidDst;
    
    
end
