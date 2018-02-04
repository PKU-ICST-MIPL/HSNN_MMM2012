function [mapIA, mapIT, mapTA, mapTI] = HSNN(I_tr, T_tr, I_te, T_te, trainCat, testCat, k)
 
% *************************************************************************
% *************************************************************************
% Parameters:
% I_tr: the feature matrix of image instances for training
%              dimension : tr_n * d_i
% T_tr: the feature matrix of text instances for training
%              dimension : tr_n * d_t
% I_te: the feature matrix of image instances for test
%              dimension : te_n * d_i
% T_te: the feature matrix of text instances for test
%              dimension : te_n * d_t
% trainCat: the category list of data for training
%              dimension : tr_n * 1
% testCat: the category list of data for test
%              dimension : te_n * 1
% k: kNN parameter, default: 30
% *************************************************************************
% *************************************************************************

dataTextTrain = T_tr;
dataImageTrain = I_tr;
dataTextTest = T_te;
dataImageTest = I_te;

dataTextTrain = dataTextTrain + 0.001;
dataTextTest = dataTextTest + 0.001;

labelTrain = trainCat;
labelTest = testCat;

[dataImageTrain, dataImageTest] = znorm(dataImageTrain,dataImageTest);
[dataTextTrain, dataTextTest] = znorm(dataTextTrain,dataTextTest);

kernelImageCmcpCosine = computehsnncosinekernel(labelTrain, ...
        dataImageTrain, dataImageTest, labelTrain, dataTextTrain, dataTextTest, k);
kernelTextCmcpCosine = computehsnncosinekernel(labelTrain, ...
        dataTextTrain, dataTextTest, labelTrain, dataImageTrain, dataImageTest, k);

mapIT = evaluateMAPPR(kernelImageCmcpCosine, labelTest, labelTest);
mapTI = evaluateMAPPR(kernelTextCmcpCosine, labelTest, labelTest);

W_IT = kernelImageCmcpCosine;
W_TI = kernelTextCmcpCosine;
W_II = computehsnncosinekernel(labelTrain, dataImageTrain, dataImageTest, labelTrain, dataImageTrain, dataImageTest, k);
W_TT = computehsnncosinekernel(labelTrain, dataTextTrain, dataTextTest, labelTrain, dataTextTrain, dataTextTest, k);
W_I = [W_II W_IT];
mapIA = evaluateMAPPR(W_I, labelTest, [labelTest; labelTest]);
W_T = [W_TI W_TT];
mapTA = evaluateMAPPR(W_T, labelTest, [labelTest; labelTest]);