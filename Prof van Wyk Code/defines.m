%% Character Definition

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

% Neural Network Input Defintion

% 5 x 4 dot matrices

one = [ 0 1 0 0; 1 1 0 0; 0 1 0 0; 0 1 0 0; 1 1 1 0];
    
two = [ 0 1 1 0; 1 0 0 1; 0 0 1 0; 0 1 0 0; 1 1 1 1];
    
three = [ 1 1 1 0; 0 0 0 1; 0 1 1 0; 0 0 0 1; 1 1 1 0];

four = [ 1 0 0 0;1 0 1 0; 1 1 1 1; 0 0 1 0; 0 0 1 0];

five = [ 1 1 1 1; 1 0 0 0; 1 1 1 0; 0 0 0 1; 1 1 1 0];
     
six = [ 0 1 1 1; 1 0 0 0; 1 1 1 0; 1 0 0 1; 0 1 1 0];
    
seven = [ 1 1 1 1; 0 0 0 1; 0 0 1 0; 0 1 0 0; 0 1 0 0];
      
eight = [ 0 1 1 0; 1 0 0 1; 0 1 1 0; 1 0 0 1; 0 1 1 0];

nine = [ 0 1 1 0; 1 0 0 1; 0 1 1 1; 0 0 0 1; 1 1 1 0];

zero = [ 0 1 1 0; 1 0 0 1; 1 0 0 1; 1 0 0 1; 0 1 1 0];
     
threshold = 1; 

%%%%%%%%

% data = table2struct(readtable('immanentTrainingData.xlsx'));
%  
% P = [data.length; data.width; data.height];
% A = [data.targetVolume];

P = [[zero,  threshold] 
     [one,   threshold]
     [two,   threshold]
     [three, threshold]
     [four,  threshold]
     [five,  threshold]
     [six,   threshold]
     [seven, threshold]
     [eight, threshold]
     [nine,  threshold]];
 
 %% 
clear one two three four five six seven eight nine zero
 
 % Neural Network Ouput Definition
 
 A = [0 0 0 0;
      0 0 0 1;
      0 0 1 0;
      0 0 1 1;
      0 1 0 0;
      0 1 0 1;
      0 1 1 0;
      0 1 1 1;
      1 0 0 0;
      1 0 0 1;
      1 0 1 0;
      1 0 1 1;
      1 1 0 0; 
      1 1 0 1;
      1 1 1 0;
      1 1 1 1];
  
 A = 2*A - 1; 