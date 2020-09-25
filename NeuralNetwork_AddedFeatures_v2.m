%% NN Development
% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created 31-Aug-2020 14:04:12
%
% This script assumes these variables are defined:
%
%   inputs - input data.
%   targets - target data.

%% Dataset Generation

% Generate and test the randomised dataset 
% For immanent data uncomment the lines below: 
% immanentDataset = createImmanentDataset(1000,20);
% if (testImmanence(immanentDataset))
%     writetable(struct2table(immanentDataset), 'testingImmanentData.xlsx')
% end

% For transcendent data uncomment the lines below: 
% transcendentDataset = createTranscendentDataset(4000,20);
% if not((testImmanence(immanentDataset)))
%     writetable(struct2table(transcendentDataset), 'transcendentDataset2.xlsx')
% end

%% Dataset Loading

% Read in the same training data
% x = inputs;
% t = targets;

% Uncomment the below code when you want to already have the data generated
data1 = table2struct(readtable('transcendentDataset-AddedFeatures_v2.xlsx'));
 
x1 = [data1.length; data1.width; data1.height; data1.number_sides];
t1 = [data1.targetVolume];

%% NN Training

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.

% Uncomment this line to train the NN
 trainFcn = 'trainbr';  

% Create a Fitting Network
% Uncomment these lines to trian the NN
 hiddenLayerSize = [10,10];
 net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
% Uncomment these lines to train the NN
 net.divideParam.trainRatio = 70/100;
 net.divideParam.valRatio = 15/100;
 net.divideParam.testRatio = 15/100;

% Choose activation functions for each layer
% Uncomment these lines to trian the NN
 net.layers{1}.transferFcn = 'logsig'
 net.layers{2}.transferFcn = 'logsig'
   
% Train the Network
% Uncomment this line to trian the NN
 [net,tr] = train(net,x1,t1);

%% NN Loading

%load trainedNet
%net = trainedNet; 

% Test the Network
y = net(x1);
e = gsubtract(t1,y);
performance = perform(net,t1,y)

xlswrite('transcendentDataset-AddedFeatures_v2.xlsx',y', 1 , 'H2')

% View the Network
view(net)

% Save the trained NN
% Uncomment these lines to save a new NN
 trainedNet_addedF_v2 = net; 
 save trainedNet_addedF_v2;

% Plots
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, ploterrhist(e)
% figure, plotregression(t,y)
% figure, plotfit(net,x,t)
