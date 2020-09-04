%% Sigmoid Activation Function

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

function y = sigmoid(x, o)

B = 1; 
y = [1]./(1 + exp(-B*x))+o;

end