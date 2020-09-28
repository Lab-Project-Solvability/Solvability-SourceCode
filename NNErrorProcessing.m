%% Error processing

% Do error processing for the transcendent dataset with 3 added features

% Read in the data

folder = 'C:\Users\Margie\Documents\University\University\IE_YOS4\SEM2\Lab Project ELEN4002\NNDev\Solvability-SourceCode';
baseFileName = 'transcendentDataset-AddedFeatures.xlsx'
fullFileName = fullfile(folder, baseFileName);

targetVol = xlsread(fullFileName, 'H2:H2001');
calcVol = xlsread(fullFileName, 'J2:J2001');

% Mean squared error

mse = immse(targetVol,calcVol)

% Relative and Absolute Error

for i = 1:size(targetVol,1)
    absoluteError(i) = calcVol(i) - targetVol(i);
    relativeError(i) = absoluteError(i)/targetVol(i); 
    accuracy(i) = relativeError(i)*100;
end

% Maximum Error
maxError = max(relativeError)

% Mean Accuracy 

meanAccuracyPerc = mean(accuracy)

xlswrite('transcendentDataset-AddedFeatures.xlsx',mse, 1 , 'K2')
xlswrite('transcendentDataset-AddedFeatures.xlsx',absoluteError', 1 , 'L2')
xlswrite('transcendentDataset-AddedFeatures.xlsx',relativeError', 1 , 'M2')
xlswrite('transcendentDataset-AddedFeatures.xlsx',accuracy', 1 , 'N2')
xlswrite('transcendentDataset-AddedFeatures.xlsx',maxError, 1 , 'O2')
xlswrite('transcendentDataset-AddedFeatures.xlsx',meanAccuracyPerc, 1 , 'P2')

%% 

% Do error processing for the transcendent dataset with 1 added feature

% Read in the data

folder = 'C:\Users\Margie\Documents\University\University\IE_YOS4\SEM2\Lab Project ELEN4002\NNDev\Solvability-SourceCode';
baseFileName = 'transcendentDataset-AddedFeatures_v2.xlsx'
fullFileName = fullfile(folder, baseFileName);

targetVol = xlsread(fullFileName, 'F2:F2001');
calcVol = xlsread(fullFileName, 'H2:H2001');

% Mean squared error

mse = immse(targetVol,calcVol)

% Relative and Absolute Error

for i = 1:size(targetVol,1)
    absoluteError(i) = calcVol(i) - targetVol(i);
    relativeError(i) = absoluteError(i)/targetVol(i); 
    accuracy(i) = relativeError(i)*100;
end

% Maximum Error
maxError = max(relativeError)

% Mean Accuracy 

meanAccuracyPerc = mean(accuracy)

xlswrite('transcendentDataset-AddedFeatures_v2.xlsx',mse, 1 , 'I2')
xlswrite('transcendentDataset-AddedFeatures_v2.xlsx',absoluteError', 1 , 'J2')
xlswrite('transcendentDataset-AddedFeatures_v2.xlsx',relativeError', 1 , 'K2')
xlswrite('transcendentDataset-AddedFeatures_v2.xlsx',accuracy', 1 , 'L2')
xlswrite('transcendentDataset-AddedFeatures_v2.xlsx',maxError, 1 , 'M2')
xlswrite('transcendentDataset-AddedFeatures_v2.xlsx',meanAccuracyPerc, 1 , 'N2')
