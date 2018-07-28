function puzzle = recognizeCNN(cropped_image)
% This function takes in the cropped images as a 28*28*1*81 matrix and
% outputs the recognized puzzle (9*9 matrix) using CNN.
% Load the pre-trained network
load MNIST_transfer_net netTransfer
% Make classfication
result = classify(netTransfer, cropped_image);
% Output the puzzle as a 9*9 matrix
result = reshape(result,9,9);
result = double(result)-1;
puzzle = result';
end