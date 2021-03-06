
function new_image = get_inbetween_image(image, u, v)
    %---------------------------------------------------------------------
    % Task b: Generate new x- and y-values of new frame
    %---------------------------------------------------------------------
    
    [sizeY,sizeX,sizeCol]=size(image(:,:,:));
    
    new_image = image;  
    
    %calculate the offset
    xOffset=round(u./2);
    yOffset=round(v./2);
    
    %calculate the x and y values of the image
    [oldX,oldY]=meshgrid(1:sizeX,1:sizeY);
    
    %calculate the new x and y values of the pixels
    newX=oldX+xOffset;
    newY=oldY+yOffset;
    
    %take care of values which exceed the dimensions of the frame
    for y=1:sizeY
        for x=1:sizeX
                                    
            if (newX(y,x) < 1)
                newX(y,x) = 1;
            end
            if (newX(y,x) > sizeX)
                newX(y,x) = sizeX;
            end
            if (newY(y,x) < 1)
                newY(y,x) = 1;
            end
            if (newY(y,x) > sizeY)
                newY(y,x) = sizeY;
            end
            
        end
        
    end
            
    %---------------------------------------------------------------------
    % Task c: Generate new frame
    %---------------------------------------------------------------------
    
    %calculating the new image and interpolate the colours for each of the
    %RGB-channels
    new_image=single(new_image);
    new_image(:,:,1)=interp2(oldX,oldY,new_image(:,:,1),newX,newY);
    new_image(:,:,2)=interp2(oldX,oldY,new_image(:,:,2),newX,newY);
    new_image(:,:,3)=interp2(oldX,oldY,new_image(:,:,3),newX,newY);

end
