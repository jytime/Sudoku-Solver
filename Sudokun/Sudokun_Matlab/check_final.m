function result= check_final(matrix,i ,j ,num)
%input: the unsolved sudoku puzzel, namely 'matrix'; position index i,j; and
%possible values
%output: whether the possible values can be filled in the current cell or
%not
%This function returns a result (true or false) to determine whether a
%blank cell can be filled by different possible values in terms of the
%final check.
%The general rule is for each row/column/grid, none of the digits from 1-9 can be
%repeated.
    if check_row(matrix,i,j,num) == false;
        result = false;
    elseif check_col(matrix,i,j,num) == false;
        result = false;
    elseif check_grid(matrix,i,j,num) == false;
        result = false;
    else
        result = true;
    end
    
end