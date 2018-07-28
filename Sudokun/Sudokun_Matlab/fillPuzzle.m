function image_filled = fillPuzzle(image_norm,puzzle,solution,left_corner,width,dimension)
%   fill the result into norm image
%   input:    image_norm     the image after normalising
%             puzzle         the sudoku without answers,9*9 matrix
%             solution       the sudoku with answers,9*9 matrix
%             left_corner    location of the left-top corner is
%                            (left_corner,left_corner), in the standard planar
%             width          the width of the square puzzle in the standard planar
%             dimension      the dimension of the puzzle, e.g., 9*9
%   output:   the image where the puzzle has been filled by blue digits

% we only insert the answers
digits_matrix = solution - puzzle;

%% get position of the digit
[row,col,digit] = find(digits_matrix);
digits_index = [col,row];
side_length = width / dimension;
position = left_corner-0.5*side_length + side_length.*digits_index;
%% insert digits by matlab inbuild function and set the information of text
image_filled = insertText(image_norm,position,digit,'FontSize',40,'TextColor','blue','BoxOpacity',0,'AnchorPoint','Center');
end
