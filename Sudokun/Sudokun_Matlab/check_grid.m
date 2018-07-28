function result= check_grid(matrix,i ,j ,num)
%input: the unsolved sudoku puzzel, namely 'matrix'; position index i,j; and
%possible values
%output: whether the possible values can be filled in the current cell or
%not
%This function returns a result (true or false) to determine whether a
%blank cell can be filled by different possible values in terms of the small grid check.
%The general rule is for each grid, none of the digits from 1-9 can be
%repeated.
    result = true; %initially set the result as true

    grid_row = floor((i-1)/3)+1; %grid position conversion for row

    grid_col = floor((j-1)/3)+1; %grid position conversion for column
    
    grid_row_start = grid_row *3 - 2; %grid starting row index
    grid_row_end = grid_row *3; %grid ending row index
    
    grid_col_start = grid_col *3 - 2; %grid starting column index
    grid_col_end = grid_col *3; %grid ending column index
    
    for row = grid_row_start:grid_row_end %for every element in the grid
        for col = grid_col_start:grid_col_end
            
           if matrix(row,col) == num %check if the number valid or not
               result = false;
           end
        end
    end
end