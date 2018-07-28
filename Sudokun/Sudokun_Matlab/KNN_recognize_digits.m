close all;
% trainPath = 'C:\Users\kobex\Desktop\PCA\Test_PCA\';
trainPath = 'C:\Users\kobex\Desktop\PCA\template_4.53\*\'; %defined trainPath
file = '*.jpg'; %define all the files to read
imgDir = dir([trainPath file]);    % return a structure with filenames
trnX = zeros(784,6948);   %set initial training set
%%
for i=1:length(imgDir)  
        I = imread([imgDir(i).name]); %read all jpg files in the directory
%         if size(I,3)>1
%             I = rgb2gray(I);
%         end
        I = im2double(I); %convert to double
        I = reshape(I,[784,1]); %reshape to a long row vector
%         I = imbinarize(I);
        trnX(:,i) = I; %save each row vector in a large training set matrix trnX
end

%% assign labels to each training image
trnY_0 = zeros(1,450); %the label for digit '0' as an example.
trnY_1 = ones(1,630); trnY_2 = 2*ones(1,585); trnY_3 = 3*ones(1,720);
trnY_4 = 4*ones(1,1080); trnY_5 = 5*ones(1,720); trnY_6 = 6*ones(1,693);
trnY_7 = 7*ones(1,585); trnY_8 = 8*ones(1,765); trnY_9 = 9*ones(1,720);
trnY = [trnY_0 trnY_1 trnY_2 trnY_3 trnY_4 trnY_5 trnY_6 trnY_7 trnY_8 trnY_9];

%% save all the data in a struct for convinience
data = struct;
data.trnX = trnX;
data.trnY = trnY;
% data.tstX = tstX;
% data.tstY = tstY;
save('data.mat','data')