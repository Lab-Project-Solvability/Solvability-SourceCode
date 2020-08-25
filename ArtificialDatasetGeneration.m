%% Create Immanent Dataset 

% Generate random numbers between 0 and 70 for the rectangles and Struct
% Generation:

numShapes = 100;
shapeCollection = [];
shapeType = ["Rectangular Cuboid", "Cube"];

for i = 1:numShapes
    % Generate a random number to choose the shapeType
    typeIdx = randi(2);
    shapeCollection(i).form = shapeType(typeIdx);
      
    if shapeCollection(i).form == 'Rectangular Cuboid'
        shapeCollection(i).length = randi(20);
        shapeCollection(i).width = randi(20);
        shapeCollection(i).height = randi(20);
        shapeCollection(i).targetVolume = shapeCollection(i).length*shapeCollection(i).width*shapeCollection(i).height;
        
    elseif shapeCollection(i).form == 'Cube'
        shapeCollection(i).length = randi(20);
        shapeCollection(i).width = shapeCollection(i).length;
        shapeCollection(i).height = shapeCollection(i).length;
        shapeCollection(i).targetVolume = shapeCollection(i).length*shapeCollection(i).width*shapeCollection(i).height;
    end

end



