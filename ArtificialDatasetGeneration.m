%% Create Transcendent Dataset

% Generate random numbers between 0 and 20 for the shgape dimensions and Struct
% Generation:

numShapes = 400;
shapeCollection = [];
shapeType = ["Rectangular Cuboid", "Cube", "Sphere", "Cylinder", "Cone"];

for i = 1:numShapes
    % Generate a random number to choose the shapeType
    typeIdx = randi(5);
    shapeCollection(i).form = shapeType(typeIdx);
    
    if shapeCollection(i).form == 'Rectangular Cuboid'
        shapeCollection(i).length = randi(20);
        shapeCollection(i).width = randi(20);
        shapeCollection(i).height = randi(20);
        %Volume Rectangular Prism = l * w * h
        shapeCollection(i).targetVolume = shapeCollection(i).length*shapeCollection(i).width*shapeCollection(i).height;
        
    elseif shapeCollection(i).form == 'Cube'
        shapeCollection(i).length = randi(20);
        shapeCollection(i).width = shapeCollection(i).length;
        shapeCollection(i).height = shapeCollection(i).length;
        % Volume Cube = l * w * h
        shapeCollection(i).targetVolume = shapeCollection(i).length*shapeCollection(i).width*shapeCollection(i).height;
        
    elseif shapeCollection(i).form == 'Sphere'
        shapeCollection(i).length = randi(20);
        shapeCollection(i).width = shapeCollection(i).length;
        shapeCollection(i).height = shapeCollection(i).length;
        % Volume Sphere = 4/3 * r^3 * pi
        shapeCollection(i).targetVolume = (shapeCollection(i).length/2)^3*(4/3)*pi;
        
    elseif shapeCollection(i).form == 'Cylinder'
        shapeCollection(i).length = randi(20);
        shapeCollection(i).width = shapeCollection(i).length;
        shapeCollection(i).height = randi(20);
        %Volume Cylinder = Pi * r^2 * h
        shapeCollection(i).targetVolume = (shapeCollection(i).length/2)^2*shapeCollection(i).height*pi;
        
    elseif shapeCollection(i).form == 'Cone'
        shapeCollection(i).length = randi(20);
        shapeCollection(i).width = shapeCollection(i).length;
        shapeCollection(i).height = randi(20);
        % Volume Cone = 1/3 * pi * r^2 * h
        shapeCollection(i).targetVolume = (shapeCollection(i).length/2)^2*(1/3)*pi*shapeCollection(i).height;
    end
    
end

