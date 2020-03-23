%Plots number of cluster vs HDBSCAN persistency threshold
function PlotNumberofClusterVsHDBSCANpersistencyThreshold(pSave,app)

B = sortrows(pSave,-2);
Unique=unique(B(:,2));
Save(1:size(Unique,1),1:2)=0;
for i=1:size(Unique,1)
    [row, ~]=find(B(:,2)>=Unique(i,1));
    Save(i,1:2)=[Unique(i,1) size(row,1)];
end
cla(app.T2F1,'reset')
set(app.T2F1,'color','white');
plot(app.T2F1,Save(:,1),Save(:,2),'k.')
xlabel(app.T2F1,'HDBSCAN persistence score threshold')
ylabel(app.T2F1,'Number of dense objects detected by HDBSCAN')
ylim(app.T2F1,[0 inf])
title(app.T2F1,'Cumulative plot of the number of dense objects with respect to HDBSCAN persistence score threshold')
grid(app.T2F1,'on')
grid(app.T2F1,'minor')
set(app.T2F1,'XMinorTick','on')
app.T2F1.Visible=true;
drawnow
appDesignerFigSaver(app.T2F1,'0_CumulativePlot_NumberOfCLustersVSHDBSCANPersistenceThreshold.tiff',[0.1 0.1 0.8 0.7])


header = {'PersistenceScore','NumberOfDenseObjects'};
output = [header; num2cell(Save)];
writecell(output,'0_CumulativePlot_NumberOfCLustersVSHDBSCANPersistenceThreshold.txt','Delimiter','tab')
end