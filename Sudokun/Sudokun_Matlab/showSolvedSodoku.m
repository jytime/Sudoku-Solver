function showSolvedSodoku(img_selected)
%% input:

output_image = sudokuBrain(img_selected);
%set(hb2, 'Enable', 'off');
imshow(output_image);
end