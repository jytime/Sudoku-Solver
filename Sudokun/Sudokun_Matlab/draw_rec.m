function draw_rec(obj)
% input: the video input object
% this function will select the region of interest, read in image, process
% the captured and call the sudoku solving function


%% capture the interested image
% call the Matlab's inbuilt function imrect() to select the region of
% interest
h=imrect;
setColor(h,'Green');
% record the position of the region of interest
position=wait(h);
% after double-click, get the get the camera picture
img=getsnapshot(obj);
% crop the interested region from the captured image
sudoku_image=imcrop(img,position);
% the raw input image is not rgb image. we convert it
sudoku_image=ycbcr2rgb(sudoku_image);
% display the interested image in the screen
imshow(sudoku_image)
hold on

%% create the laser scanning animation
[w,l]=size(sudoku_image);
scanning(w,l);

%% call the key processing function and record the processing time
t0=cputime;
% understand the input image, solve the sudoku, and show the solved result
output_image = sudokuBrain(sudoku_image);
imshow(output_image);
% tout represents the whole processing time
tout=cputime-t0;

%% difficulty assessment
if tout<8
    msgbox('You are looking down on the most advanced AI! This sudoku is a no-brainer!', 'Proud');
else
    msgbox('This sudoku is worth a fight! Have a try, poor human!', 'Proud');
end

end