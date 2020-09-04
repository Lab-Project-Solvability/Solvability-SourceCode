%% Pattern Classification

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

function [i, a1, a2] = classifier(W, p)

% Evaluate the output of each neuron
i = W*p; 
% Sigmoid of the output of each neuron
a1 = sigmoid(i,-0.5);
% Vote counting
a2 = sign(sum(a1));

end