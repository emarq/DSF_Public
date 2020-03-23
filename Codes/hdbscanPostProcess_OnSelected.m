%Post processing HDBSCAN analysis results
function [hdbscanCluster,noise]=hdbscanPostProcess_OnSelected(PositionDataset,hdbscanProbabilityThreshold)

    hdbscanLabels=importdata('HDBSCANoutputsFirst/Labels.txt');
    hdbscanPersistence=importdata('HDBSCANoutputsFirst/Persistence.txt');
    hdbscanProbabilities=importdata('HDBSCANoutputsFirst/Probabilities.txt');
    
    SiZePositionDatasetCol=size(PositionDataset,2); %Determines whether dataset is 2D or 3D

    %Labels==-1 means NOISE
    %Since real cluster labels start from 0, 
    %the counter i starts from 0.
    NoiseLabel=-1;
    
    
    UniqueLabels=unique(hdbscanLabels);
    NoiseCells=cell(size(UniqueLabels,1),1);
    hdbscanCluster=[];
    
    if ismember(NoiseLabel,UniqueLabels)
        [row, ~]=find(hdbscanLabels==-1);
        noise=PositionDataset(row,1:SiZePositionDatasetCol);
        for i=0:(size(UniqueLabels,1)-2)                                    
            hdbscanCluster(i+1).labels=i;
            [row, ~]=find(hdbscanLabels==i);
            prob=hdbscanProbabilities(row,1);
            INDEX=(prob>=hdbscanProbabilityThreshold);
            hdbscanCluster(i+1).probabilities=prob(INDEX,1);
            hdbscanCluster(i+1).persistence=hdbscanPersistence(i+1,1);
            tempPos=PositionDataset(row,1:SiZePositionDatasetCol);
            hdbscanCluster(i+1).atomPositions=tempPos(INDEX,:);
            NoiseCells{i+1,1}=tempPos(~INDEX,:);            
        end
    else
        noise=[];
        for i=0:(size(UniqueLabels,1)-1)                                    
            hdbscanCluster(i+1).labels=i;
            [row, ~]=find(hdbscanLabels==i);
            prob=hdbscanProbabilities(row,1);
            INDEX=(prob>=hdbscanProbabilityThreshold);
            hdbscanCluster(i+1).probabilities=prob(INDEX,1);
            hdbscanCluster(i+1).persistence=hdbscanPersistence(i+1,1);
            tempPos=PositionDataset(row,1:SiZePositionDatasetCol);
            hdbscanCluster(i+1).atomPositions=tempPos(INDEX,:);
            NoiseCells{i+1,1}=tempPos(~INDEX,:);
        end
    end
    NoiseCells=cell2mat(NoiseCells);
    noise=[noise;NoiseCells];
    
  

end