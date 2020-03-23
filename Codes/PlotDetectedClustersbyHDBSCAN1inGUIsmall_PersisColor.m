%This function plots clusters detected by HDBSCAN
function PlotDetectedClustersbyHDBSCAN1inGUIsmall_PersisColor(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,app)
    
cla(app.T2F5,'reset')
%ColorsForPlot = distinguishable_colors(size(hdbscanCluster,2));
%AlldataPoints=importdata(DatasetName);

ClusterCounter=0;
%HOLDon=true(1);

PersisSaver=cell(size(hdbscanCluster,2),1);
for i=1:size(hdbscanCluster,2)
    if hdbscanCluster(i).persistence>=hdbscanPersistencyThreshold
        PersisSaver{i,1}=hdbscanCluster(i).persistence;
    end
end
PersisSaver=cell2mat(PersisSaver);
MinPersis=min(PersisSaver);
MaxPersis=max(PersisSaver);

cmap = jet(256);


DataSaver=cell(size(hdbscanCluster,2),1);


for i=1:size(hdbscanCluster,2)
    if hdbscanCluster(i).persistence>=hdbscanPersistencyThreshold
        ClusterCounter=ClusterCounter+1;
        Xtemp=hdbscanCluster(i).atomPositions;
        Probability=hdbscanCluster(i).probabilities;
        [row, ~]=find(Probability(:,1)>=hdbscanProbabilityThreshold);
        X=Xtemp(row,1:3);
        
        %SelProbTemp=Probability(row,1);
        IndexTemperory=(round(255*(hdbscanCluster(i).persistence-MinPersis)/(MaxPersis-MinPersis))+1);
        if isnan(IndexTemperory) || IndexTemperory<1 
            IndexTemperory=1;
        end
        SelectedColor=cmap(IndexTemperory,1:3);
        DataSaver{ClusterCounter,1}=[X ones(size(X,1),1).*SelectedColor(1,1) ones(size(X,1),1).*SelectedColor(1,2) ones(size(X,1),1).*SelectedColor(1,3)];
        %PersisColorOutput=PersisColormaker(X,SelectedColor);
        %    if HOLDon
        %      hold(app.T2F5,'on')
        %      HOLDon=false(1);
        
        %   end
        % arrayfun(@(a) plot3(app.T2F5,a.X,a.Y,a.Z,'.','color',a.Col,'MarkerSize',8),PersisColorOutput, 'uni', 0);
    end
end

DataSaver=cell2mat(DataSaver);

scatter3(app.T2F5,DataSaver(:,1),DataSaver(:,2),DataSaver(:,3),5.*ones(size(DataSaver,1),1),DataSaver(:,4:6),'filled')

if MinPersis==MaxPersis
    MinPersis=MinPersis-0.01;
    MaxPersis=MaxPersis+0.01;
end
caxis(app.T2F5,[MinPersis,MaxPersis]);
colormap(app.T2F5,cmap)

%colorbar(app.T2F5,'position',[.9 (app.AxisLimits(3,1)+(0.2*(app.AxisLimits(3,2)-app.AxisLimits(3,1)))) .02 (0.6*(app.AxisLimits(3,2)-app.AxisLimits(3,1)))])

colorbar(app.T2F5,'position',[.9 0.35 .02 0.25])

%cb=colorbar(app.T2F5);
%set(cb,'position',[.9 .2 .02 .6])

% hold(app.T2F5,'off')
view(app.T2F5,str2num(char(app.T1EFT5.Value)),str2num(char(app.T1EFT6.Value)))
xlim(app.T2F5,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T2F5,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T2F5,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
%axis(app.T2F5,'equal')
xlabel(app.T2F5,'X (nm)')
ylabel(app.T2F5,'Y (nm)')
zlabel(app.T2F5,'Z (nm)')
TITLE=({['Coloring dense objects based on their stability'];...
    ['Persistence score>= ' num2str(hdbscanPersistencyThreshold) '  Probability>= ' num2str(hdbscanProbabilityThreshold)]});
title(app.T2F5,TITLE)

pbaspect(app.T2F5,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
%set(app.T2F5,'color','white');
app.T2F5.Visible=true;
%axis(app.T2F5,'off')
drawnow
end