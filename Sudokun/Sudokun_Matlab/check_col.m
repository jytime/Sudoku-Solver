function result= check_col(matrix,i ,j ,num)
%input: the unsolved sudoku puzzel, namely 'matrix'; position index i,j; and
%possible values
%output: whether the possible values can be filled in the current cell or
%not
%This function returns a result (true or false) to determine whether a
%blank cell can be filled by different possible values in terms of column check.
%The general rule is for each column, none of the digits from 1-9 can be
%repeated.
    result = true;
    for row = 1:9
        if matrix(row,j) == num
            result = false;
            break;
        end
    end
end