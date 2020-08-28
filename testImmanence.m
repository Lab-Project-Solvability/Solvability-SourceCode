%% Function to test for Immanence according to Prof's theory

function immanence = testImmanence(dataset)
%% Initialisation

% Shapes U
U = [];
% Calculated Volume : N(T(u))
V = [];
X = [];
% Data points : M(u)
W = [];
% Mapping
UtoV = [];
XtoV = [];

%%  Get struct values that are unique
uniqueDataset = uniqueStruct(dataset);

%% Get bubbles

for i = 1:size(dataset,2)
    U(i).form = dataset(i).form;
    U(i).x = dataset(i).length;
    U(i).y = dataset(i).width;
    U(i).z = dataset(i).height;
end

for j = 1:size(uniqueDataset,2)
    
    % M(u) = W, but only unique points would be mapped. U -> W map
    W(j).x = uniqueDataset(j).length;
    W(j).y = uniqueDataset(j).width;
    W(j).z = uniqueDataset(j).height;
    
    % ShapeCollection.targetVolume = V - unique volumes only
    V(j) = uniqueDataset(j).targetVolume;
    
    % Since N is the identity map, V = X
    X(j) = V(j);
    
end

%% Test for immanence

% Prof Theory
% Immanence: for each w that is an element of M(U)= W there exists a unique x
% that is an element of N(T(U)) such that T(M^-1(w)) = V is a sub-element
% or equal to N^-1(x) = V

% Steps:
% 1. Get each unique w in W find each u in U that maps to it
% 2. Use the unique u in U to calculate V
% 3. Iterate over all x in X and compute V from these X values
% 4. If the V determined at 2 is a subset of the V determined from 3 =>
% immanenece

% 1.
temp = size(U, 2);
count = 0;

for k = 1:size(U,2)
    for l = 1:size(W,2)
        if ((U(k).x == W(l).x) && (U(k).y == W(l).y) && (U(k).z == W(l).z))
            count = count + 1;
        end
    end
end

% 2.
% The unique target volume from the shape collection is the mapping from U
% to V. Thus the V(i) bubble can be used for comparison.
if count == temp
    for m = 1:size(V,2)
        UtoV(m) = V(m);
    end
else
    immanence = false;
    return
end

%3.
for n = 1:size(X,2)
    XtoV(n) = X(n);
end

%4.
% Check that T(M^-1(w)) is subset of N^-1(x)
if (all(ismember(UtoV, XtoV)))
    immanence = true;
else
    immanence = false;
end

end
