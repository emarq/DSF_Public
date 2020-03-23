%This function plots clusters detected by HDBSCAN
function PlotDetectedClustersbyHDBSCAN1inGUI(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,app)
    
cla(app.T2F3,'reset')
%ColorsForPlot = distinguishable_colors(size(hdbscanCluster,2));
AlldataPoints=importdata(DatasetName);
Xsave=cell(size(hdbscanCluster,2),1);
DataSaver=cell(size(hdbscanCluster,2),1);
ClusterCounter=0;
HOLDon=true(1);

for i=1:size(hdbscanCluster,2)
    if hdbscanCluster(i).persistence>=hdbscanPersistencyThreshold
        ClusterCounter=ClusterCounter+1;
        Xtemp=hdbscanCluster(i).atomPositions;
        Probability=hdbscanCluster(i).probabilities;
        [row, ~]=find(Probability(:,1)>=hdbscanProbabilityThreshold);
        X=Xtemp(row,1:3);
        Xsave{i,1}=X;
        ColorsForPlot=hdbscanCluster(i).color;
        DataSaver{ClusterCounter,1}=[X ones(size(X,1),1).*ColorsForPlot(1,1) ones(size(X,1),1).*ColorsForPlot(1,2) ones(size(X,1),1).*ColorsForPlot(1,3)];
        %SelProbTemp=Probability(row,1);
        %SelectedColor=ColorsForPlot(i,1:3);
        %TransparencyOutput=Transparency(X,SelProbTemp,SelectedColor);
        %if HOLDon
        %    hold(app.T2F3,'on')
        
        %    HOLDon=false(1);
        %end
        %arrayfun(@(a) plot3(app.T2F3,a.X,a.Y,a.Z,'.','color',a.Col,'MarkerSize',8),TransparencyOutput, 'uni', 0);
    end
end

DataSaver=cell2mat(DataSaver);
scatter3(app.T2F3,DataSaver(:,1),DataSaver(:,2),DataSaver(:,3),5.*ones(size(DataSaver,1),1),DataSaver(:,4:6),'filled')

hold(app.T2F3,'on')
Xsave=cell2mat({cat(1,Xsave{:})});

MaxNumAtomToPlot=str2double(char(app.T1EFT4.Value));
if size(AlldataPoints,1)>MaxNumAtomToPlot   %if we have more than 250,000 atom of interest, we only present
    rng(7,'twister');%To ensure the randperm generates the same number array for plots T1F1 and T2F2
    INDEX=randperm(size(AlldataPoints,1),MaxNumAtomToPlot);
    AlldataPointsForPlot=AlldataPoints(INDEX,1:3);
    AlldataPointsForPlot(ismember(AlldataPointsForPlot,Xsave,'rows'),:)=[]; %Noise points
    plot3(app.T2F3,AlldataPointsForPlot(:,1),AlldataPointsForPlot(:,2),AlldataPointsForPlot(:,3),'.','color','k','MarkerSize',2)
else
    AlldataPoints(ismember(AlldataPoints,Xsave,'rows'),:)=[]; %Noise points
    plot3(app.T2F3,AlldataPoints(:,1),AlldataPoints(:,2),AlldataPoints(:,3),'.','color','k','MarkerSize',2)
end
view(app.T2F3,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
hold(app.T2F3,'off')
xlim(app.T2F3,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T2F3,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T2F3,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
% axis(app.T2F3,'equal')
%xlabel(app.T2F3,'X (nm)')
%ylabel(app.T2F3,'Y (nm)')
%zlabel(app.T2F3,'Z (nm)')
TITLE=({[num2str(ClusterCounter) ' detected dense objects (black atoms are noise)' ];...
    ['Persistence score>= ' num2str(hdbscanPersistencyThreshold) '  Probability>= ' num2str(hdbscanProbabilityThreshold)]});
title(app.T2F3,TITLE)
%set(app.T2F3,'color','white');
pbaspect(app.T2F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T2F3.Visible=true;
%axis(app.T2F3,'off')
drawnow
end