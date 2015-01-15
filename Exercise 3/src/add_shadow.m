%xpos, ypos: position for foreground shadow in background
function bg_with_shadow = add_shadow(xpos, ypos, bg, foreground_map )
    %---------------------------------------------------------------------
    % Task b: Add shadow of foreground object to background
    %---------------------------------------------------------------------
    % Create projected shadow of foreground_map
    T = maketform('affine',[10 -3 0 ; 10 5 0 ; 0 0 1]);
    shadow = imtransform(foreground_map,T,'XYScale',[12 22]);
    % Bring the shadow_map to the same size as the background
    [bg_y,bg_x,~] = size(bg);
    shadow_map = zeros(bg_y,bg_x);
    [shadow_y,shadow_x] = size(shadow);
    shadow_map(ypos:(ypos+shadow_y-1),xpos:(xpos+shadow_x-1)) = shadow;
    shadow_map = uint8(shadow_map);
    
    % Merge the shadow with the background
    r_shadow = 10;
    g_shadow = 10;
    b_shadow = 10;
    transparent_factor = 0.6;
    
    shadow_mapr1 = shadow_map*r_shadow*transparent_factor;
    shadow_mapr2 = (bg(:,:,1).*shadow_map)*(1-transparent_factor);
    shadow_mapr3 = (1-shadow_map).*bg(:,:,1);
    
    bg_with_shadow(:,:,1) = shadow_mapr1 + shadow_mapr2 + shadow_mapr3;
    
    shadow_mapg1 = shadow_map*g_shadow*transparent_factor;
    shadow_mapg2 = (bg(:,:,2).*shadow_map)*(1-transparent_factor);
    shadow_mapg3 = (1-shadow_map).*bg(:,:,2);
    
    bg_with_shadow(:,:,2) = shadow_mapg1 + shadow_mapg2 + shadow_mapg3;
    
    shadow_mapb1 = shadow_map*b_shadow*transparent_factor;
    shadow_mapb2 = (bg(:,:,3).*shadow_map)*(1-transparent_factor);
    shadow_mapb3 = (1-shadow_map).*bg(:,:,3);
    
    bg_with_shadow(:,:,3) = shadow_mapb1 + shadow_mapb2 + shadow_mapb3;
end

