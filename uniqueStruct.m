%% Function to determine unique structures

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