%This function plots clusters detected by HDBSCAN
function PlotDetectedClustersbyHDBSCAN1inGUIsmall(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,app)
    
cla(app.T2F4,'reset')
%ColorsForPlot = distinguishable_colors(size(hdbscanCluster,2));
DataSaver=cell(size(hdbscanCluster,2),1);
ClusterCounter=0;
%HOLDon=true(1);

for i=1:size(hdbscanCluster,2)
    if hdbscanCluster(i).persistence>=hdbscanPersistencyThreshold
        ClusterCounter=ClusterCounter+1;
        Xtemp=hdbscanCluster(i).atomPositions;
        Probability=hdbscanCluster(i).probabilities;
        [row, ~]=find(Probability(:,1)>=hdbscanProbabilityThreshold);
        X=Xtemp(row,1:3);
        ColorsForPlot=hdbscanCluster(i).color;
        DataSaver{ClusterCounter,1}=[X ones(size(X,1),1).*ColorsForPlot(1,1) ones(size(X,1),1).*ColorsForPlot(1,2) ones(size(X,1),1).*ColorsForPlot(1,3)];
        %Xsave=[Xsave;X];
        %SelProbTemp=Probability(row,1);
        
        %TransparencyOutput=Transparency(X,SelProbTemp,SelectedColor);
        %if HOLDon
        %  hold(app.T2F4,'on')
        %  HOLDon=false(1);
        
        %end
        %arrayfun(@(a) plot3(app.T2F4,a.X,a.Y,a.Z,'.','color',a.Col,'MarkerSize',8),TransparencyOutput, 'uni', 0);
    end
end
DataSaver=cell2mat(DataSaver);
%AlldataPoints(ismember(AlldataPoints,Xsave,'rows'),:)=[]; %Noise points

h=scatter3(app.T2F4,DataSaver(:,1),DataSaver(:,2),DataSaver(:,3),5.*ones(size(DataSaver,1),1),DataSaver(:,4:6),'filled');
app.handleT2F4=h;

%plot3(app.T2F4,AlldataPoints(:,1),AlldataPoints(:,2),AlldataPoints(:,3),'.','color','k','MarkerSize',2)
%hold(app.T2F4,'off')
view(app.T2F4,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T2F4,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T2F4,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T2F4,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
%axis(app.T2F4,'equal')
xlabel(app.T2F4,'X (nm)')
ylabel(app.T2F4,'Y (nm)')
zlabel(app.T2F4,'Z (nm)')
TITLE=({['Number of detected dense objects is ' num2str(ClusterCounter)];...
    ['Persistence score>= ' num2str(hdbscanPersistencyThreshold) '  Probability>= ' num2str(hdbscanProbabilityThreshold)]});
title(app.T2F4,TITLE)

%set(app.T2F4,'color','white');
pbaspect(app.T2F4,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T2F4.Visible=true;
%axis(app.T2F4,'off')
drawnow
end