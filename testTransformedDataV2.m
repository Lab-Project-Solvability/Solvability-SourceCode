%% Test Immanence on transformed datasets
clear

data = table2struct(readtable('transcendentDataset-AddedFeatures_v2.xlsx')).';

%data = createImmanentDataset(1000, 10);

testImmanenceTransformedV2(data)

%% Function to test for Immanence according to Prof's theory
% Returns 1 if immanent
% Returns 0 if transcendent

function immanence = testImmanenceTransformedV2(dataset)
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
uniqueDataset = uniqueStructTransV2(dataset);

%% Get bubbles

for i = 1:size(dataset,2)
    U(i).form = dataset(i).form;
    U(i).x = dataset(i).length;
    U(i).y = dataset(i).width;
    U(i).z = dataset(i).height;
    U(i).f1 = dataset(i).number_sides; 
   
end

for i = 1:size(uniqueDataset,2)
    
    % M(u) = W, but only unique points would be mapped. U -> W map
    W(i).x = uniqueDataset(i).length;
    W(i).y = uniqueDataset(i).width;
    W(i).z = uniqueDataset(i).height;
    W(i).f1 = uniqueDataset(i).number_sides; 
  
    
    % ShapeCollection.targetVolume = V - unique volumes only
    V(i) = uniqueDataset(i).targetVolume;
    
    % Since N is the identity map, V = X
    X(i) = V(i);
    
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

for j = 1:size(U,2)
    for i = 1:size(W,2)
        if ((U(j).x == W(i).x) && (U(j).y == W(i).y) && (U(j).z == W(i).z) && ...
            (U(j).f1 == W(i).f1))
            count = count + 1;
        end
    end
end

% 2.
% The unique target volume from the shape collection is the mapping from U
% to V. Thus the V(i) bubble can be used for comparison.
if count == temp
    for i = 1:size(V,2)
        UtoV(i) = V(i);
    end
else
    immanence = false;
    return
end

%3.
for i = 1:size(X,2)
    XtoV(i) = X(i);
end

%4.
% Check that T(M^-1(w)) is subset of N^-1(x)
if (all(ismember(UtoV, XtoV)))
    immanence = true;
else
    immanence = false;
end

end