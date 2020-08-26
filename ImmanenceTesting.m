%% Immanence Testing

%%  Initialisation
shapeCollection = [];
immanence = false;

%% Create Dataset

% Generate random numbers between 0 and 20 for the shgape dimensions and Struct
% Generation:
shapeCollection = createImmanentDataset(100, 20);

if (testImmanence(shapeCollection))
    disp('The dataset is Immanent')
else
    disp('The dataset is Transcendent')
end
%% Functions

function dataset = createImmanentDataset(numShapes, randomRange)
shapeType = ["Rectangular Cuboid", "Cube"];

for i = 1:numShapes
    % Generate a random number to choose the shapeType
    typeIdx = randi(2);
    dataset(i).form = shapeType(typeIdx);
    
    if dataset(i).form == 'Rectangular Cuboid'
        dataset(i).length = randi(randomRange);
        dataset(i).width = randi(randomRange);
        dataset(i).height = randi(randomRange);
        %Volume Rectangular Prism = l * w * h
        dataset(i).targetVolume = dataset(i).length*dataset(i).width*dataset(i).height;
        
    elseif dataset(i).form == 'Cube'
        dataset(i).length = randi(randomRange);
        dataset(i).width = dataset(i).length;
        dataset(i).height = dataset(i).length;
        % Volume Cube = l * w * h
        dataset(i).targetVolume = dataset(i).length*dataset(i).width*dataset(i).height;
    end
    
end

end

% The following function is obtained and adapted from :
%Valerio Biscione (2020). uniqueStruct (https://www.mathworks.com/matlabcentral/fileexchange/53871-uniquestruct),
%MATLAB Central File Exchange. Retrieved August 25, 2020.
function newStruct=uniqueStruct(oldStruct)
newStruct(1)=oldStruct(1); %this is sort of intializing.
k=2;
for i=1:numel(oldStruct)
    skipFlag=0;
    temp=oldStruct(i);
    for j=1:numel(newStruct)
        if isequaln(temp, newStruct(j))
            if isequal(temp.form, newStruct(j).form)
                skipFlag=1;
            end
        end
    end
    if skipFlag==0
        newStruct(k)=temp; k=k+1;
    end
end
end


function immanence = testImmanence(dataset)
%% Initialisation

% Shapes U 
U = [];
% Calculated Volume : N(T(u))
V = [];
% Data points : M(u)
W = [];
% Array to check immanence
UtoV = [];
X = [];

%%  Get struct values that are unique
uniqueDataset = uniqueStruct(dataset);

%% Get bubbles

% ShapeCollection.form = U

for i = 1:size(dataset,2)
    U(i).form = dataset(i).form;
    U(i).x = dataset(i).length;
    U(i).y = dataset(i).width;
    U(i).z = dataset(i).height;
    U(i).volume = dataset(i).targetVolume;
end

for i = 1:size(uniqueDataset,2)
    
    % M(u) = W, but only unique points would be mapped. U -> W map
    W(i).x = uniqueDataset(i).length;
    W(i).y = uniqueDataset(i).width;
    W(i).z = uniqueDataset(i).height;
    
    
    % ShapeCollection.targetVolume = V - unique volumes only
    V(i) = uniqueDataset(i).targetVolume;
    
    % Since N is the identity map, V = X, but only the unique ones
    X(i) = V(i);
    
end

%% Test for immanence

% Prof Theory
% Immanence: for each w that is an element of M(U) there exists a unique x
% that is an element of N(T(U)) such that T(M^-1(w)) is a sub-element
% or equal to N^-1(x)

% Steps:
% 1. Get each unique w in W find each u in U that maps to it
% 2. Use the unique u in U to calculate V
% 3. Iterate over all x in X and compute V from these X values
% 4. If the V determined at 2 is a subset of the V determined from 3 =>
% immanenece

% 1.
temp = size(U, 2);
count = 0;

for i = 1:size(W,2)
    for j = 1:size(U,2)
        if ((U(j).x == W(i).x) && (U(j).y == W(i).y) && (U(j).z == W(i).z))
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
end

%3.
for i = 1:size(X,2)
    XtoV(i) = X(i);
end

%4.
if (all(ismember(UtoV, XtoV)))
    immanence = true;
else
    immanence = false;
end

end
