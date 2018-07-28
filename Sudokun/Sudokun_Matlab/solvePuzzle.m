function S = solvePuzzle(matrix, S)
%input: unsolved puzzel 'matrix', the previous solved puzzel
%output: the puzzle solution
%This function is to solve the sudoku puzzel by using backtracking.
%This algorithm literally visits all the empty cells in order, filling all
%possible digits and checking the validity of each digits in each empty
%cell. More clearly, starting from the first empty cell, if the digit ‘1’ is
%allowed after checking all the constraints (row, column and 9 grids box), 
%then place ‘1’ in the current cell and move to the next empty cell. 
%Otherwise, try digits from ‘2’ to ‘9’ on the current cell until one satisfying
%digits found. If none of the nine digits is allowed, then leaves the current
%cell blank and moves to the previous cell.This process ends when the last 
%cell is filled with a proper digit or when the Sudoku puzzle is unsolvable.
    if ~exist('S','var')  
        S = zeros([size(matrix),0]);  
    end 
    
    index = find(matrix(:)==0, 1); %find the first empty cell in the matrix

    if isempty(index)
        S(:,:,size(S,3)+1) = matrix;
    else
        [row,col] = ind2sub([9,9],index); 

        for num = 1:9 %call check_final function
            if check_final(matrix, row, col, num) == true
                matrix(row,col) = num;
                S = solvePuzzle(matrix, S);% use recursion
            end
        end
    end
end
