%% Function to print results of immanence testing 

function print(result)
if (testImmanence(result))
    disp('The dataset is Immanent')
else
    disp('The dataset is Transcendent')
end
end