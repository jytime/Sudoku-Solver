function result= check_row(matrix,i ,j ,num)
%input: the unsolved sudoku puzzel, namely 'matrix'; position index i,j; and
%possible values
%output: whether the possible values can be filled in the current cell or
%not
%This function returns a result (true or false) to determine whether a
%blank cell can be filled by different possible values in terms of row check.
%The general rule is for each row, none of the digits from 1-9 can be
%repeated.
    result = true;
    for col = 1:9
        if matrix(i,col) == num
            result = false;
            break;
        end
    end
end

