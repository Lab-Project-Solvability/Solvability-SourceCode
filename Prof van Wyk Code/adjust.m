%% Weight Vector Adjustment

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

% The weight voctor of the neural network (wi) in the direction of the perpendicular 
% to the pattern plane (i.e. the plane associated with the input pattern p) in the weight 
% space. The change in the wieght vector is proportional to the perpindicular distance of 
% the weight vector to the patter plane. The constant of proportionality is 1 < mu < 2.

% Input: wi - the unadjusted weight vector. N x 1 
%        p  - pattern vector. N x 1
%        mu - proportionality constant. 

% Output: wo - Agjusted weight vector. N x 1. 

function wo = adjust(wi, p, mu)

v = p/norm(p);
wo = wi - mu.*(wi.*v).*v;

end