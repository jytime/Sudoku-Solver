function output_image = sudokuBrain(input_image)
% input:        captured rgb image
% output:       the captured image with the puzzle filled by blue digits
% sudokuBrain is the main function for understanding the input image and
% solving the sudoku
% this function includes image processing, denoising, puzzle vertices
% detection, image cropping,digits recognition,sudoku solving, puzzle filling
% and re-projection

disp('solving the sudoku');

%% parameter setting
% please see our project report for detailed explanation

% the width of the square puzzle in the standard planar
width=9*16*3;
% in the standard planar, the location of the left-top corner is (left_corner,left_corner)
left_corner=400;
% prepare for dimension extension; we can also solve 16*16 sudoku
dimension=9;


%% image processing and denoising
% convert the image to grayscale
image_gray = rgb2gray(input_image);
% increase contrast
image_gray = imadjust(image_gray ,[0.4 0.6], [0 1]);
% convert the image to binary format
% reverse black and white, to prepare for following recognition
image_bw = imcomplement(imbinarize(image_gray));
% denoise function
image_bw = bwareaopen(image_bw,30);

%% find the four vertices of the puzzle
% detect the edges by Hough transform
edges = findEdges(image_bw);
% find the four strongest lines, i.e., borders
borders = findBorders(edges);
% from the borders, we can get their intersections,i.e., the vertices
corners = findCorners(borders);

%% conduct 2D projection
% this part will project the input image to a standard planar, preparing
% for the following recognition section

% calculate the transformation matrix
H = homo2D(corners(:,1),corners(:,2),left_corner,width);
% project the whole input image
image_norm = projectImage(H,imcomplement(image_bw),left_corner,width);

%% image cropping
% crop the puzzle into 81 subimages
[cropped_image, check_num] = cropImage(image_norm,left_corner,width,dimension);

%% digits recognition
% OCR method
puzzleOcr = recognizeOcr(cropped_image, check_num);
% CNN method
puzzleCNN=recognizeCNN(cropped_image);
% KNN method (template matching)
puzzleKNN=recognizeKNN(cropped_image);
% three methods vote to get the confident results
puzzle = puzzleMode(puzzleOcr,puzzleCNN,puzzleKNN);

%% sudoku solving
% two solving methods
 [solution, sol] = sudoku2(puzzle);
% solution = solvePuzzle(puzzle);

% if the sudoku cannot be solved, error
if sol
    msgbox('Infeasible problem', 'error');
end

%% fill the puzzle and re-project
if ~sol
    % fill the puzzle with answers
    image_filled = fillPuzzle(double(image_norm),puzzle,solution,left_corner,width,dimension);
    % enlarge the puzzle and then project it back to the input form
    scale=2;
    output_image=projectBack(input_image,image_filled,H,scale,left_corner,width);
end
end

