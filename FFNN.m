%% Program to train and develop NN

%%  Get the data

% Create intitial datasets
immanentDataset = createImmanentDataset(1600,20);

% Do test for immanence
if (testImmanence(immanentDataset))
    inputs = [immanentDataset.length; immanentDataset.width; immanentDataset.height];
    targets = [immanentDataset.targetVolume];

    net = feedforwardnet([3,2,2], 'trainlm')
    
    % Choose the ReLU activation function : 'poslin'
    % Choose the sigmoid activation function : 'logsig'
    net.layers{1}.transferFcn = 'poslin' 
    net.layers{2}.transferFcn = 'poslin' 
    net.layers{3}.transferFcn = 'poslin' 
    
    [net, tr] = train(net, inputs, targets);
    
    %% Bayesian Backpropagation Function
    
%     net = feedforwardnet([3,3,3], 'trainbr')
%     
%     % Choose the ReLU activation function
%     net.layers{1}.transferFcn = 'poslin' 
%     net.layers{2}.transferFcn = 'poslin' 
%     net.layers{3}.transferFcn = 'poslin' 
%     
%     % Train the NN 
%     [net, tr] = train(net, inputs, targets);
    
    % Test the NN
    inputs(:,5)
    testInput= [2; 3; 4]
    output = net(inputs(:,5))
    output1 = net(testInput)
else
    disp('dataset is not immanent')
end




