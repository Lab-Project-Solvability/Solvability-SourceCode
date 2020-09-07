%% Train the Neural Network

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

defines; 

fprintf('Classifier 1: ')
[W1,s] = trainClassifier(P, A(:,1),100, 5, 1.5); 
if s > 1
    fprintf('Could not train the classifier 1'); 
end

fprintf('Classifier 2: ')
[W2,s] = trainClassifier(P, A(:,2),100, 5, 1.5); 
if s > 1
    fprintf('Could not train the classifier 2'); 
end

fprintf('Classifier 3: ')
[W3,s] = trainClassifier(P, A(:,3),100, 5, 1.5); 
if s > 1
    fprintf('Could not train the classifier 3'); 
end

fprintf('Classifier 4: ')
[W4,s] = trainClassifier(P, A(:,4),100, 5, 1.5); 
if s > 1
    fprintf('Could not train the classifier 4'); 
end

save nnparams P A W1 W2 W3 W4