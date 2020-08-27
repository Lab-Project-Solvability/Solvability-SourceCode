%% Function to Create an Immanent Dataset

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