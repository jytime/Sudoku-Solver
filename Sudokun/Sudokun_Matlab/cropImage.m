function [cropped_imgs, check_num] = cropImage(norm_image,left_corner,width,dimension)
% input: norm_image     normalized image
%        left_corner    location of the left-top corner is
%                       (left_corner,left_corner), in the standard planar
%        width          the width of the square puzzle in the standard planar
%        dimension      the dimension of the puzzle, e.g., 9*9
% output: cropped_imgs  a 28*28*1*81 matrix; each digit is resized to a
%                       28*28 image; in all 81 digits
%         check_num     a 1*81 vector
%                       some subimages do not contain digits; we can set
%                       their check_num as 0 to ignore them;
% This function takes in the normalized image and outputs the 81 cropped
% digits.

%% parameter preparing
grid_width=width/dimension;
label=1;
cropped_imgs=ones(28,28,1,dimension^2);
check_num = zeros(9,9);

%% cropping
for n=1:dimension
    for m=1:dimension
        % crop the pre-set position
        temp=imcrop(norm_image,[(m-1)*grid_width+8+left_corner (n-1)*grid_width+8+left_corner grid_width-12 grid_width-12]);
        % resize the digit image to 28*28
        temp_resized=imresize(temp,[28,28]);
        
        % detect how many information pixels in each digit image
        len = length(find (temp_resized == 0));
        % only if there are enough information pixels, we assume this
        % region will contain a digit
        if len >= 40
            check_num(n,m) = 1;
        end
        
        cropped_imgs(:,:,:,label)=temp_resized;
        label=label+1;
    end
end

cropped_imgs = imcomplement(cropped_imgs);

%% Closing for bad image
% se = strel('disk',1);
% cropped_imgs = imclose(cropped_imgs,se);

end
