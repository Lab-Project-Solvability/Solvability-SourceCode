%% Immanence Testing

%%  Initialisation
shapeCollection = [];
% Shapes U 
U = [];
% Calculated Volume : N(T(u))
V = [];
% Data points : M(u)
W = [];
% Array to check immanence
WtoX = [];
VtoX = [];

immanence = false;

%% Create Dataset

% Generate random numbers between 0 and 20 for the shgape dimensions and Struct
% Generation:
shapeCollection = createImmanentDataset(100, 20);

for i = 1:size(shapeCollection,2)
   U(i) = shapeCollection(i).form; 
   V(i) = shapeCollection(i).targetVolume;
end
%% Prof Theory

% Get struct values that are unique
temp = uniqueStruct(shapeCollection);

% Get bubbles

% ShapeCollection.form = U
% ShapeCollection.targetVolume = V


for i = 1:size(temp,2)
    
    % Since N is the identity map, V = X, but only the unique ones 
    VtoX(i) = temp(i).targetVolume;
    
    % M(u) = W, but only unique points would be mapped
    W(i).x = temp(i).length;
    W(i).y = temp(i).width;
    W(i).z = temp(i).height;
    
    % S = N(T(pre-image of M(w))) = N(T(u)) = X
    WtoX(i) = W(i).x* W(i).y.* W(i).z;
    
end

%% Test for immanence

% Immanence: for each w that is an element of M(U) there exists a unique x
% that is an element of N(T(U)) such that T(pre-image of M(w)) is a sub-element
% or equal to pre-image of N(x)

isSubset = all(ismember(WtoX, VtoX));

% If T(M^-1(w)) is a subset of N^-1(x), then immanence is depicted

disp(isSubset)

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


