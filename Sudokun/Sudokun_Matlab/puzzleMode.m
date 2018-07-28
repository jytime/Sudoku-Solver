function puzzle = puzzleMode(puzzle1,puzzle2,puzzle3)
%find the mode of three kinds of puzzles(OCR, CNN, KNN)
%input: puzzle1 9*9 double matrix, puzzle2 9*9 double matrix, puzzle3 double 9*9 matrix
%output: puzzle 9*9 double matrix

%build a large matrix to contain all puzzles
puzzleAll = zeros(9,9,3);
puzzleAll(:,:,1) = puzzle1;
puzzleAll(:,:,2) = puzzle2;
puzzleAll(:,:,3) = puzzle3;

%find the mode
puzzle = mode(puzzleAll,3);

end

