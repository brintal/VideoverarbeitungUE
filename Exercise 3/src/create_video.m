function create_video(video_filename, input_directory,file_extension)
    %---------------------------------------------------------------------
    % Task d: Create output video of all resulting frames
    %---------------------------------------------------------------------
    file_list = dir([input_directory '/*.' file_extension]);
    
    writerObj = VideoWriter(['..\output\' video_filename '.avi']);
    writerObj.FrameRate = 24;
    open(writerObj);
    for j = 1:numel(file_list)
        img = imread([input_directory '/' file_list(j).name]);
        writeVideo(writerObj, img);
    end
    close(writerObj);
end

