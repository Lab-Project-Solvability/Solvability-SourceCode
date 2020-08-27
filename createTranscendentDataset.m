%% Function to create a Transcendent Dataset

function dataset = createTranscendentDataset(numShapes, randomRange)
shapeType = ["Rectangular Cuboid", "Cube", "Sphere", "Cylinder", "Cone"];

for i = 1:numShapes
    % Generate a random number to choose the shapeType
    typeIdx = randi(5);
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
        
    elseif dataset(i).form == 'Sphere'
        dataset(i).length = randi(randomRange);
        dataset(i).width = dataset(i).length;
        dataset(i).height = dataset(i).length;
        % Volume Sphere = 4/3 * r^3 * pi
        dataset(i).targetVolume = (dataset(i).length/2)^3*(4/3)*pi;
        
    elseif dataset(i).form == 'Cylinder'
        dataset(i).length = randi(randomRange);
        dataset(i).width = dataset(i).length;
        dataset(i).height = randi(randomRange);
        %Volume Cylinder = Pi * r^2 * h
        dataset(i).targetVolume = (dataset(i).length/2)^2*dataset(i).height*pi;
        
    elseif dataset(i).form == 'Cone'
        dataset(i).length = randi(randomRange);
        dataset(i).width = dataset(i).length;
        dataset(i).height = randi(randomRange);
        % Volume Cone = 1/3 * pi * r^2 * h
        dataset(i).targetVolume = (dataset(i).length/2)^2*(1/3)*pi*dataset(i).height;
    end
    
end

end

