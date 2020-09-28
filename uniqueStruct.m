%% Function to determine unique structures

%The following function is obtained and adapted from :
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
            skipFlag=1;
            % ((temp.form ~= newStruct(j).form) && (temp.length == newStruct(j).length) && (temp.width == newStruct(j).width) && (temp.height == newStruct(j).height) && (temp.targetVolume == newStruct(j).targetVolume))
        elseif((~isequal(temp.form, newStruct(j).form)) && (isequal(temp.length, newStruct(j).length)) && ...
                (isequal(temp.width, newStruct(j).width)) && (isequal(temp.height, newStruct(j).height)) && ...
                (isequal(temp.targetVolume, newStruct(j).targetVolume)))
            skipFlag = 1;
        end
    end
    if skipFlag==0
        newStruct(k)=temp; k=k+1;
    end
end
end