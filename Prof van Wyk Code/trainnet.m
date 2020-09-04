%% Train the Neural Network

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

defines; 

disp('Classifier 1: ')
[W1,s] = traincla(P, A(:,1),100, 5, 1.6); 
if s > 1
    disp('Could not train the classifier 1'); 
end

disp('Classifier 2: ')
[W2,s] = traincla(P, A(:,2),100, 5, 1.6); 
if s > 1
    disp('Could not train the classifier 2'); 
end

disp('Classifier 3: ')
[W3,s] = traincla(P, A(:,3),100, 5, 1.6); 
if s > 1
    disp('Could not train the classifier 3'); 
end

disp('Classifier 4: ')
[W4,s] = traincla(P, A(:,1),100, 5, 1.6); 
if s > 1
    disp('Could not train the classifier 4'); 
end

save nnparams P A W1 W2 W3 W4