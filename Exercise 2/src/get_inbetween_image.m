
function new_image = get_inbetween_image(image, u, v)
    %---------------------------------------------------------------------
    % Task b: Generate new x- and y-values of new frame
    %---------------------------------------------------------------------
    
    [sizeY,sizeX,sizeCol]=size(image(:,:,:));
    
    new_image = image;
    for y=1:sizeY
        for x=1:sizeX
            
            xOffset=round(u(y,x)/2);
            yOffset=round(v(y,x)/2);
            
            xVal = x+xOffset;
            yVal = y+yOffset;
            
            if (xVal < 1)
                xVal = 1;
            end
            if (xVal > sizeX)
                xVal = sizeX;
            end
            if (yVal < 1)
                yVal = 1;
            end
            if (yVal > sizeY)
                yVal = sizeY;
            end
            
            
            new_image(yVal,xVal,1)=image(y,x,1);
            new_image(yVal,xVal,2)=image(y,x,2);
            new_image(yVal,xVal,3)=image(y,x,3);

        end
        
    end
            
    %---------------------------------------------------------------------
    % Task c: Generate new frame
    %---------------------------------------------------------------------

end
