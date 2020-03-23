%Tab 5, Plot pushbutton
function T5B2(app)

cla(app.T5F3,'reset')
app.T5F3.Visible=false;
cla(app.T5F4,'reset')
app.T5F4.Visible=false;
cla(app.T5F7,'reset')
app.T5F7.Visible=false;
cla(app.T5F8,'reset')
app.T5F8.Visible=false;
drawnow

app.T5L1.Text={'Start plotting dislocations and clusters'};
app.T5Lamp1.Color='y';pause(0.001)
Skeleton=app.Skeleton;
LengthThreshold=[];
LengthThreshold=str2num(char(app.T5EFT1.Value));

if isempty(LengthThreshold) || ~(size(LengthThreshold,1)==1) || ~(size(LengthThreshold,2)==1) || LengthThreshold<=0
    app.T5L1.Text={'Please write an acceptable value in the "Skeleton length threshold" box.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

Dislocations=cell(size(Skeleton,1),1);
DislocationsPoints=cell(size(Skeleton,1),1);
dCounter=0;
dLength=[];
Clusters=cell(size(Skeleton,1),1);
ClustersPoints=cell(size(Skeleton,1),1);
cCounter=0;
cSize=[];%number of atoms
for i=1:size(Skeleton,1)
    color=Skeleton{i,1}.color;
    SkeletonPointsDN=Skeleton{i, 1}.SkeletonPointsDN;
    if (Skeleton{i,1}.LengthModified)>=LengthThreshold
        dCounter=dCounter+1;
        Dislocations{i,1}=[SkeletonPointsDN ones(size(SkeletonPointsDN,1),1).*color];
        DislocationsPoints{i,1}=Skeleton{i, 1}.OrigPointsDN;
        dLength=[dLength;Skeleton{i,1}.LengthModified];
    else
        cCounter=cCounter+1;
        Clusters{i,1}=[SkeletonPointsDN ones(size(SkeletonPointsDN,1),1).*color];
        ClustersPoints{i,1}=Skeleton{i, 1}.OrigPointsDN;
        cSize=[cSize;Skeleton{i, 1}.npts];
    end
end

if dCounter>0
    Dislocations=cell2mat(Dislocations);
    DislocationsPoints=cell2mat(DislocationsPoints);
    
    scatter3(app.T5F3,Dislocations(:,1),Dislocations(:,2),Dislocations(:,3),7.*ones(size(Dislocations,1),1),Dislocations(:,4:6),'filled');
    hold(app.T5F3,'on')
    plot3(app.T5F3,DislocationsPoints(:,1),DislocationsPoints(:,2),DislocationsPoints(:,3),'k.','MarkerSize',3)
    hold(app.T5F3,'off')
    view(app.T5F3,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
    xlim(app.T5F3,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T5F3,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T5F3,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    xlabel(app.T5F3,'X (nm)')
    ylabel(app.T5F3,'Y (nm)')
    zlabel(app.T5F3,'Z (nm)')
    title(app.T5F3,[num2str(dCounter) ' dislocations'])
    axis(app.T5F3,'off')
    pbaspect(app.T5F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
    app.T5F3.Visible=true;
    
    edgeForHist=[min(dLength):10:max(dLength)];
    if size(edgeForHist,2)==1
        edgeForHist(1,2)=edgeForHist(1,1)+0.1;
    elseif edgeForHist(1,end)==edgeForHist(1,end-1)
        edgeForHist(1,end)=[];
    end
    histogram(dLength,edgeForHist,'Parent',app.T5F7)
    xlabel(app.T5F7,'Dislocation length (nm)')
    ylabel(app.T5F7,{'Number of'; 'dislocations'})
    app.T5F7.FontSize=12;
    app.T5F7.FontWeight='bold';
    app.T5F7.Visible=true;
    drawnow
else
    title(app.T5F3,'No dislocation')
    app.T5F3.Visible=true;
    axis(app.T5F3,'off')
end

if cCounter>0
    Clusters=cell2mat(Clusters);
    ClustersPoints=cell2mat(ClustersPoints);
    
    scatter3(app.T5F4,Clusters(:,1),Clusters(:,2),Clusters(:,3),7.*ones(size(Clusters,1),1),Clusters(:,4:6),'filled');
    hold(app.T5F4,'on')
    plot3(app.T5F4,ClustersPoints(:,1),ClustersPoints(:,2),ClustersPoints(:,3),'k.','MarkerSize',3)
    hold(app.T5F4,'off')
    view(app.T5F4,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
    xlim(app.T5F4,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T5F4,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T5F4,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    xlabel(app.T5F4,'X (nm)')
    ylabel(app.T5F4,'Y (nm)')
    zlabel(app.T5F4,'Z (nm)')
    title(app.T5F4,[num2str(cCounter) ' clusters'])
    axis(app.T5F4,'off')
    pbaspect(app.T5F4,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
    app.T5F4.Visible=true;
    
    if size(cSize,1)>1
        [optN, ~, ~] = sshist(cSize);
    else
        optN=[];
    end
    if isempty(optN)
        histogram(cSize,'Parent',app.T5F8)
    else
        histogram(cSize,optN,'Parent',app.T5F8)
    end
    
    xlabel(app.T5F8,'Cluster size (atoms)')
    ylabel(app.T5F8,{'Number of'; 'clusters'})
    app.T5F8.FontSize=12;
    app.T5F8.FontWeight='bold';
    app.T5F8.Visible=true;
    drawnow
else
    title(app.T5F4,'No cluster')
    app.T5F4.Visible=true;
    axis(app.T5F4,'off')
end

ID=[];
for i=1:size(Skeleton,1)
    if strcmp(Skeleton{i,1}.EstimatedShape,'Disk')
        ID=[ID;i];
    end
end

app.T5T1.Visible=false;
app.T5T1.Data=array2table([]);

if size(ID,1)>0
    app.T5T1.Data=array2table(ID);
    app.T5T1.ColumnEditable=false;
    app.T5T1.RowName ='numbered' ;
    app.T5T1.ColumnName={'Disk-shape skeleton ID'};
    app.T5T1.Visible=true;
end

app.T5P2.Visible=true;%Applying corrections
app.T5B3.Visible=true;%plot selected skeletons pushbutton
app.T5EFT2.Visible=true;%SkeletonIDs box
app.T5EFT2Label.Visible=true;
app.T5EFT5.Visible=true;%Skeleton as others box
%app.T5EFT5Label.Visible=true;

app.T5L1.Text={'If the classification of dense objects is good, please click on the "Finalizing the results" button;';...
               'otherwise, fill the boxes in the "Applying corrections" panel.';...
               'You can use "Get skeleton ID" button to get the skeleton ID values from plot #2.';...
               'The ID of skeletons, which may be considered as clusters or others, is mentioned in Table 1. ';...
               };
app.T5Lamp1.Color='g';pause(0.001)

end