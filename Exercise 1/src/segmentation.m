function foreground_map = segmentation(frames,FGScribbles,Hfc,Hbc,bins)
    %----------------------------------------------------------------------
    % Task c: Generate cost-volume
    %----------------------------------------------------------------------
   
    
    %Das Funktioniert noch nicht! Keine Ahnung wie das geht :(
    CostVol = Hfc(1)/(Hfc(1)+Hbc(1));
    %disp(CostVol);

    
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
