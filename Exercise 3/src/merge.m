%xpos, ypos: position for foreground (fg) in background (bg)
function result = merge(xpos, ypos, bg, fg, foreground_map )
    %---------------------------------------------------------------------
    % Task c: Merge foreground and background
    %---------------------------------------------------------------------
    [fg_y,fg_x,~] = size(fg);
    [bg_y,bg_x,~] = size(bg);
    
    new_fg_map(:,:,1) = foreground_map;
    new_fg_map(:,:,2) = foreground_map;
    new_fg_map(:,:,3) = foreground_map;
    
    fg = uint8(fg);
    
    fg_cut_out = fg.*new_fg_map;
    new_fg = zeros(bg_y,bg_x,3);
    
    new_fg(ypos:(ypos+fg_y-1),xpos:(xpos+fg_x-1),1:3) = fg_cut_out;
    new_fg = uint8(new_fg);
    
    new_bg = ones(bg_y,bg_x,3);
    new_bg(ypos:(ypos+fg_y-1),xpos:(xpos+fg_x-1),1:3) = ~new_fg_map;
    new_bg = uint8(new_bg);
    new_bg = new_bg.*bg;
    
    result = new_bg + new_fg;
end