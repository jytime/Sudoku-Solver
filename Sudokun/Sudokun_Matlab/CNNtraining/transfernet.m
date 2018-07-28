%% Load Data
Path   = 'Dataset';
 imds = imageDatastore(Path,   'IncludeSubfolders', true,...
     'LabelSource', 'foldernames','ReadFcn',@customreader);
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.9,'randomized');
numTrainImages = numel(imdsTrain.Labels);
%% Load Pretrained Network
load MNIST_net
inputSize = net.Layers(1).InputSize;
%% Replace Final Layers
layersTransfer = net.Layers(1:end-3);
%Transfer the layers to the new classification task by replacing the last 
%three layers with a fully connected layer, a softmax layer, and a 
%classification output layer. Specify the options of the new fully 
%connected layer according to the new data. 
numClasses = numel(categories(imdsTrain.Labels));
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

%% Train Network
%Specify the training options. 
options = trainingOptions('sgdm', ...  
    'MaxEpochs',4, ...
    'InitialLearnRate',1e-3, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'ValidationPatience',Inf, ...
    'Verbose',false, ...
    'Plots','training-progress');

%Train the network.
netTransfer = trainNetwork(imdsTrain,layers,options);
save ('MNIST_transfer_net','netTransfer')
%% Classify Validation Images
[YPred,scores] = classify(netTransfer,imdsValidation);
%Visualization
idx = randperm(numel(imdsValidation.Files),16);
figure
for i = 1:16
    subplot(4,4,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label));
end

%Calculate the classification accuracy 
YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation)

function data = customreader(filename)
%CUSTOMREADER read in images as binary images
data1 = imread(filename);
data = imbinarize(data1);
end