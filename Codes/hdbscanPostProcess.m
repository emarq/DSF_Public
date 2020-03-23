%Post processing HDBSCAN analysis results
function hdbscanCluster=hdbscanPostProcess(PositionDataset)

hdbscanLabels=importdata('HDBSCANoutputsFirst/Labels.txt');
hdbscanPersistence=importdata('HDBSCANoutputsFirst/Persistence.txt');
hdbscanProbabilities=importdata('HDBSCANoutputsFirst/Probabilities.txt');

SiZePositionDatasetCol=size(PositionDataset,2); %Determines whether dataset is 2D or 3D

%Labels==-1 means NOISE
%Since real cluster labels start from 0,
%the counter i starts from 0.
NoiseLabel=-1;
UniqueLabels=unique(hdbscanLabels);
hdbscanCluster=[];

if ismember(NoiseLabel,UniqueLabels)
    for i=0:(size(UniqueLabels,1)-2)
        hdbscanCluster(i+1).labels=i;
        [row col]=find(hdbscanLabels==i);
        hdbscanCluster(i+1).probabilities=hdbscanProbabilities(row,1);
        hdbscanCluster(i+1).persistence=hdbscanPersistence(i+1,1);
        hdbscanCluster(i+1).atomPositions=PositionDataset(row,1:SiZePositionDatasetCol);
    end
else
    for i=0:(size(UniqueLabels,1)-1)
        hdbscanCluster(i+1).labels=i;
        [row col]=find(hdbscanLabels==i);
        hdbscanCluster(i+1).probabilities=hdbscanProbabilities(row,1);
        hdbscanCluster(i+1).persistence=hdbscanPersistence(i+1,1);
        hdbscanCluster(i+1).atomPositions=PositionDataset(row,1:SiZePositionDatasetCol);
    end
end

ColorsForPlot = distinguishable_colors(size(hdbscanCluster,2));
for i=1:size(hdbscanCluster,2)
    hdbscanCluster(i).color=ColorsForPlot(i,:);
end
end