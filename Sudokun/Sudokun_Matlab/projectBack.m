function output_image=projectBack(input_image,image_filled,H,scale,left_corner,width)
% input:    input_image    the captured image
%           image_filled   the image where the puzzle has been filled by blue digits
%           H              the transformation matrix
%           scale          the magnitude of enlargement 
%           left_corner    location of the left-top corner is
%                          (left_corner,left_corner), in the standard planar
%           width          the width of the square puzzle in the standard planar
% output:   output_image   the captured image with answers
% this function will project the solved results to the input planar

    % enlarge the image to increase digits clarity
    img_enlarge=imresize(image_filled,scale,'nearest');
    % read in the background
    output_image=im2double(input_image);
    r=left_corner;
    w=width;
    % project the image from the standard planar to the original planar
    for m=scale*r:scale*(r+w)
        for n=scale*r:scale*(r+w)           
           point=[n/scale,m/scale];
           % we only project the information pixels
           if img_enlarge(m,n,1)==0&&img_enlarge(m,n,2)==0&&img_enlarge(m,n,3)==1
               % using the inverse transformation matrix, project the point
               pro_point=project2d(inv(H),point);
               % avoid the decimals
               pro_point=round(pro_point);
               x=pro_point(1);
               y=pro_point(2);
               output_image(y,x,1)=0;
               output_image(y,x,2)=0;
               output_image(y,x,3)=1;          
           end
        end
    end

end