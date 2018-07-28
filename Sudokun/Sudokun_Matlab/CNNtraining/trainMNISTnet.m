%% Load in MNIST data
[trainImage,trainNum] = readMNIST('train-images-idx3-ubyte','train-labels-idx1-ubyte',60000,0);
[testImage,testNum] = readMNIST('t10k-images-idx3-ubyte','t10k-labels-idx1-ubyte',10000,0);
trainImage = reshape(trainImage,[28,28,1,60000]);
testImage = reshape(testImage,[28,28,1,10000]);
trainNum = categorical(trainNum);
testNum = categorical(testNum);
%% Set up network
layers = [
    imageInputLayer([28 28 1])
    convolution2dLayer(3,8,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,32,'Padding',1)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];
options = trainingOptions('adam', ...
    'MaxEpochs',4, ...
    'ValidationData',{testImage,testNum}, ...
    'ValidationFrequency',30, ...
    'ValidationPatience',Inf, ...
    'Verbose',false, ...
    'Plots','training-progress');
net = trainNetwork(trainImage,trainNum,layers,options);
net.Layers
save('MNIST_net','net');
%% Classify Validation Images and Compute Accuracy
YPred = classify(net,testImage);
YValidation = testNum;
accuracy = sum(YPred == YValidation)/numel(YValidation)