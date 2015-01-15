function output = change_illumination(frame, luma_factor)
    %---------------------------------------------------------------------
    % Task a: Adjust brightness and resize foreground object
    %---------------------------------------------------------------------
    % convert from rgb colour space to hsv colour space
    hsv_frame = rgb2hsv(frame);
    % change the value in the hsv colour space
    hsv_frame(:,:,3) = luma_factor*hsv_frame(:,:,3);
    % convert back to rgb
    output = uint8(hsv2rgb(hsv_frame)*255);
end

