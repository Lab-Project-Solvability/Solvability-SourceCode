%% Code for  a neural network

pattern = [0:64];

z = '00000000';

binPattern = '';
for i = 0:length(pattern)-1
    temp = dec2bin(i);
    binPattern = [binPattern; [z(1:8-length(temp)), temp]];
end