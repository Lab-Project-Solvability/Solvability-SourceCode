%% Immanence Testing

%%  Initialisation
shapeCollection = [];
% Shapes
% U = [];
% Actual Volume : T(U)
VtoX = [];
% Data points : M(u)
W = [];
% Calculated Volume : N(T(u))
WtoX = [];

immanence = false;

%% Create Dataset

% Generate random numbers between 0 and 20 for the shgape dimensions and Struct
% Generation:
shapeCollection = createImmanentDataset(100, 20);

%% Prof Theory

% Get struct values that are unique
temp = uniqueStruct(shapeCollection);

% Get bubbles
for i = 1:size(temp,2)
    VtoX(i) = temp(i).targetVolume;
    
    W(i).x = temp(i).length;
    W(i).y = temp(i).width;
    W(i).z = temp(i).height;
    
    WtoX(i) = W(i).x* W(i).y.* W(i).z;
    
end

%% Test for immanence
if WtoX(j) == VtoX(j)
    immanence = true;
end

disp(immanence)

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


