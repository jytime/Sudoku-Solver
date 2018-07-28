function puzzle = recognizeKNN(cropped_image) %28*28*1*81
%input: the cropped_image with 81 digits ready to be recognized
%output: recoginiztion result, combining them all as the puzzle
%This function is to recognize the digits by using k-nearest neighbours
load('data.mat','data'); %load data
trnX = data.trnX;
trnY = data.trnY;

tstX = reshape(cropped_image,[784,81]); %reshape 28*28*1*81 to 784*1, same
%with training image size

tst_num = size(tstX, 2); %define the number of test image, actually it is 81

puzzle = zeros(1, tst_num); %set tge puzzel as all 0 initially
for i = 1:tst_num
    tem = tstX(:,i) - trnX;
    dist = sum(tem.^2, 1); %compute the Eculidien distance between the test
    %image and each training image
    [~, index] = sort(dist); %use sort function to find the smallest distance
    puzzle(i) = mode(trnY(index(1:3))); %assign the label to each test image
    % with the most common result using mode function
%   puzzle(i) = trnY(index);
end
puzzle = reshape(puzzle,9,9); %convert to a standard 9*9 puzzel
puzzle = puzzle' ;
%time_elapsed = toc;
% accuracy = sum(out == tstY) / tst_num;

end