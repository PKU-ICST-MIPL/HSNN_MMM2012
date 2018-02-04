function [ kernel ] = computehsnncosinekernel( labelATrain, dataATrain, dataATest, labelBTrain, dataBTrain, dataBTest, k)
nATrain = size(dataATrain, 1);
nATest = size(dataATest, 1);
[dataATrain, dataATest] = znorm(dataATrain,dataATest);
[dataBTrain, dataBTest] = znorm(dataBTrain,dataBTest);
kernelACosine = computecosinekernel([dataATrain; dataATest]);
kernelACosinePart = kernelACosine(1:nATrain + nATest, 1:nATrain);

nBTrain = size(dataBTrain, 1);
nBTest = size(dataBTest, 1);
kernelBCosine = computecosinekernel([dataBTrain; dataBTest]);
kernelBCosinePart = kernelBCosine(1:nBTrain + nBTest, 1:nBTrain);

kernel = computehsnnkernel(labelATrain, kernelACosinePart, labelBTrain, kernelBCosinePart, nATrain, nATest, nBTrain, nBTest, k);

end