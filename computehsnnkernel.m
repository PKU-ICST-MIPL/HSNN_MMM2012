function [ kernelHsnn ] = computehsnnkernel( labelATrain, kernelASimilarity, labelBTrain, kernelBSimilarity, nATrain, nATest, nBTrain, nBTest, k)

[kernelASimilarity(1:nATrain, :) kernelASimilarity(nATrain+1:nATrain+nATest, :)] ...
    = znorm(kernelASimilarity(1:nATrain, :), kernelASimilarity(nATrain+1:nATrain+nATest, :));
[kernelBSimilarity(1:nBTrain, :) kernelBSimilarity(nBTrain+1:nBTrain+nBTest, :)] ...
    = znorm(kernelBSimilarity(1:nBTrain, :), kernelBSimilarity(nBTrain+1:nBTrain+nBTest, :));
kA = k;
kB = k;
[KN,I] = sort(kernelASimilarity,2,'descend');
for i = 1:nATrain+nATest
    knn = KN(i,:);
    knn = [0, knn(2:kA), zeros(1,nATrain-kA)];
    kernelASimilarity(i,I(i,:)) = knn;
end
[KN,I] = sort(kernelBSimilarity,2,'descend');
for i = 1:nBTrain+nBTest
    knn = KN(i,:);
    knn = [0, knn(2:kB), zeros(1,nBTrain-kB)];
    kernelBSimilarity(i,I(i,:)) = knn;
end
clear i knn KN I;

sumASimilarity = sum(kernelASimilarity, 2);
kernelASimilarity = kernelASimilarity./repmat(sumASimilarity, 1, nATrain);

sumBSimilarity = sum(kernelBSimilarity, 2);
kernelBSimilarity = kernelBSimilarity./repmat(sumBSimilarity, 1, nBTrain);
clear sumASimilarity sumBSimilarity;

labelConsistentMatrix = double((repmat(labelATrain,1,nBTrain))==(repmat(labelBTrain,1,nATrain))');

labelAList = unique(labelATrain);
labelBList = unique(labelBTrain);
labelList = union(labelAList, labelBList);
probabilityACategory = zeros(nATrain+nATest,length(labelList));
probabilityBCategory = zeros(nBTrain+nBTest,length(labelList));

for i = labelList'
    id = find(labelBTrain==i);
    kernelASimilarityId = kernelASimilarity(:,id);
    kernelASimilarityId = sum(kernelASimilarityId,2);
    probabilityACategory(:,i) = kernelASimilarityId;
    
    id = find(labelATrain==i);
    kernelBSimilarityId = kernelBSimilarity(:,id);
    kernelBSimilarityId = sum(kernelBSimilarityId,2);
    probabilityBCategory(:,i) = kernelBSimilarityId;
end
clear i id kernelASimilarityId kernelBSimilarityId;

kernelHsnn = probabilityACategory * probabilityBCategory';
kernelHsnn = kernelHsnn(nATrain+1:nATrain+nATest,nBTrain+1:nBTrain+nBTest);



end

