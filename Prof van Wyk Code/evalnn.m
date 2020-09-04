%% Evaluate the Neural Network

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

[Np, Ni] = size(P); 

for i = 1:Np
   [ans ans o1] = classifier(W1, P(i,:).'); 
   o1 = floor((o1+1)/2);
   [ans ans o2] = classifier(W2, P(i,:).'); 
   o2 = floor((o2+1)/2);
   [ans ans o3] = classifier(W3, P(i,:).'); 
   o3 = floor((o3+1)/2);
   [ans ans o4] = classifier(W4, P(i,:).'); 
   o4 = floor((o4+1)/2);
   
   disp('Input Pattern P ', i-1)
   disp('Classification ', o1, o2)
   disp(o3, o4)
end