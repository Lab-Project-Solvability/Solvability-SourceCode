%% Function to Train a Single Classifier

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

% Input: P - Pattern matrix. 
%        a - Corresponding output vecotor of a single classifier
%        Nt - Number of trials
%        Nr - Number of returns
%        mu - Training parameter

% Output W - Final weight matrix
%        s - Training Result Flag
%            0 = Unsuccessful training
%            1 = Successful Training

% Number of neurons per classifier

function [W,s] = trainClassifier(P, a, Nt, Nr, mu)
Nn = 5; 
randn('seed',0);
[Np, Ni] = size(P)
s = 0;
cr = 0;

while (s~=1) && (cr < Nr)
    cr = cr + 1; 
    if cr ==1
        fprintf('Run %g:\n', cr); 
    else
        fprintf('Rerun %g:\n', cr); 
    end
    ct = 0; 
    W = rand(Nn,Ni); 
    while (s~=1) & (ct < Nt)
        ct = ct + 1; 
        fprintf('Trial %g:\n', ct)
        
        % Perform 1 training trial
        for i = 1:Np
            % Evaluate the classifier output with the i-th pattern applied
           [iv, av, ac] = classifier(W, P(i,:).');
           % Check if the weights must be adjusted
           if (ac~=a(i))
               t = ac*(ac*av>0).*iv;
               [ans, j] = min(t+1e10*(~t));
               
               disp(j)
               % Perform Weight Adjustment
               ans = adjust(W(j,:).',P(i,:).',mu);
               W(j,:) = ans.';
           end
        end
        s = Np + 1; 
        % Test to see whether the network is fully trained
        for i = 1:Np
            % Evaluate classifier output with the i-th pattern applied
            [ans, ans, ac] = classifier(W, P(i,:).');
            
            if (ac ==a(i))
                s = s - 1; 
            end 
        end
        
        fprintf('Bad Classifications: %g:\n', s-1)
        
    end
end
end
