%% Create Rectangular Cuboids

% Generate random numbers between 0 and 70 for the rectangles and Struct
% Generation:

numShapes = 60; 
shapeCollection = [];

for i = 1:
    shapeCollection(i).form = 'Rectangular Cuboid';
    shapeCollection(i).length = 70 .* rand();
    shapeCollection(i).width = 70 .* rand();
    shapeCollection(i).height = 70 .* rand();
    shapeCollection(i).targetVolume = shapeCollection(i).length*shapeCollection(i).width*shapeCollection(i).height ;
    
end