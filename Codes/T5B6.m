function T5B6(app)

app.T5L1.Text={'Finalizing the results.','Please wait!'};
app.T5Lamp1.Color='y';pause(0.001)

cla(app.T5F3,'reset')
app.T5F3.Visible=false;
cla(app.T5F4,'reset')
app.T5F4.Visible=false;
cla(app.T5F5,'reset')
app.T5F5.Visible=false;
cla(app.T5F6,'reset')
app.T5F6.Visible=false;
cla(app.T5F7,'reset')
app.T5F7.Visible=false;
cla(app.T5F8,'reset')
app.T5F8.Visible=false;
app.T5P4.Visible=false;%composition
app.T5P5.Visible=false;%orientation
app.T5P6.Visible=false;
app.T5P8.Visible=false;
app.T5B7.Visible=false;
cla(app.T5F9,'reset')
app.T5F9.Visible=false;
cla(app.T5F10,'reset')
app.T5F10.Visible=false;
app.T5EFT10.Value='';
app.T5T2.Visible=false;
app.T5T2.Data=array2table([]);
app.T5EFT11.Value='';
app.T5EFT12.Value='';
app.T5RB1Hidden.Value=true;
app.T5EFT14.Value='';
app.T5EFT15.Value='';
app.T5EFT16.Value='';
drawnow

Skeleton=app.Skeleton;

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);
LengthThreshold=str2num(char(app.T5EFT1.Value));

dID=str2num(char(app.T5EFT3.Value));%dislocation ID
if isempty(dID) && ~isempty(app.T5EFT3.Value)
    app.T5L1.Text={'"ID of skeletons to consider as dislocations" box is not in the correct format.';'Please separate Skeleton ID values with ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif size(dID,1)>1
    app.T5L1.Text={'"ID of skeletons to consider as dislocations" box is not in the correct format.';'Please separate Skeleton IDs with ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif (sum(~(floor(dID)==dID)))>0 || (sum(dID<1)>0) || (sum(dID>(size(Skeleton,1)+1))>0)
    app.T5L1.Text={'"ID of skeletons to consider as dislocations" box is not in the correct format.';['Skeleton IDs must be integer values smaller than ' num2str(size(Skeleton,1)+1) '.']};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif size(unique(dID),2)<size(dID,2)
    app.T5L1.Text={'"ID of skeletons to consider as dislocations" box is not in the correct format.';'One of the skeleton ID values is repeated more than once.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

cID=str2num(char(app.T5EFT4.Value));%cluster ID
if isempty(cID) && ~isempty(app.T5EFT4.Value)
    app.T5L1.Text={'"ID of skeletons to consider as clusters" box is not in the correct format.';'Please separate Skeleton ID valuess with ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
elseif size(cID,1)>1
    app.T5L1.Text={'"ID of skeletons to consider as clusters" box is not in the correct format.';'Please separate Skeleton IDs with ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif (sum(~(floor(cID)==cID)))>0 || (sum(cID<1)>0) || (sum(cID>(size(Skeleton,1)+1))>0)
    app.T5L1.Text={'"ID of skeletons to consider as clusters" box is not in the correct format.';['Skeleton IDs must be integer values smaller than ' num2str(size(Skeleton,1)+1) '.']};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif size(unique(cID),2)<size(cID,2)
    app.T5L1.Text={'"ID of skeletons to consider as clusters" box is not in the correct format.';'One of the skeleton ID values is repeated more than once.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
end

oID=str2num(char(app.T5EFT5.Value));%other ID
if isempty(oID) && ~isempty(app.T5EFT5.Value)
    app.T5L1.Text={'"ID of skeletons to consider as others" box is not in the correct format.';'Please separate Skeleton ID values with ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif size(oID,1)>1
    app.T5L1.Text={'"ID of skeletons to consider as others" box is not in the correct format.';'Please separate Skeleton IDs with ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif (sum(~(floor(oID)==oID)))>0 || (sum(oID<1)>0) || (sum(oID>(size(Skeleton,1)+1))>0)
    app.T5L1.Text={'"ID of skeletons to consider as others" box is not in the correct format.';['Skeleton IDs must be integer values smaller than ' num2str(size(Skeleton,1)+1) '.']};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif size(unique(oID),2)<size(oID,2)
    app.T5L1.Text={'"ID of skeletons to consider as others" box is not in the correct format.';'One of the skeleton ID values is repeated more than once.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

if sum(ismember(dID,cID))>0 || sum(ismember(cID,dID))>0
    app.T5L1.Text={'The same skeleton ID cannot be assigned to the following two boxes:';'"ID of skeletons to consider as dislocations"';'and';'"ID of skeletons to consider as clusters"'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif sum(ismember(dID,oID))>0 || sum(ismember(oID,dID))>0
    app.T5L1.Text={'The same skeleton ID cannot be assigned to the following two boxes:';'"ID of skeletons to consider as dislocations"';'and';'"ID of skeletons to consider as others"'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif sum(ismember(cID,oID))>0 || sum(ismember(oID,cID))>0
    app.T5L1.Text={'The same skeleton ID cannot be assigned to the following two boxes:';'"ID of skeletons to consider as clusters"';'and';'"ID of skeletons to consider as others"'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

for i=1:size(dID,2)
    if (Skeleton{dID(1,i),1}.LengthModified)>=LengthThreshold
        app.T5L1.Text={'"ID of skeletons to consider as dislocations" box is not in the correct format.';['Please remove skeleton ID ' num2str(dID(1,i)) ' from the box.']};
        app.T5Lamp1.Color='r';pause(0.001)
        return
    end
end

for i=1:size(cID,2)
    if (Skeleton{cID(1,i),1}.LengthModified)<LengthThreshold
        app.T5L1.Text={'"ID of skeletons to consider as clusters" box is not in the correct format.';['Please remove skeleton ID ' num2str(cID(1,i)) ' from the box.']};
        app.T5Lamp1.Color='r';pause(0.001)
        return
    end
end

fid1 = fopen([PosFileName '_' NameOfElementOfInterest '_FinalCorrectionList.txt'],'wt');
fprintf(fid1, '%s\n', 'Skeleton Length threshold (nm):');
fprintf(fid1, '%10.3f\n', LengthThreshold);
fprintf(fid1, '%s\n', 'ID of skeletons to consider as Dislocations:');
for i=1:size(dID,2)
    if i<size(dID,2)
        fprintf(fid1, '%i\t', dID(1,i));
    else
        fprintf(fid1, '%i\n', dID(1,i));
    end
end
if size(dID,2)==0
    fprintf(fid1, '\n', []);
end

fprintf(fid1, '%s\n', 'ID of skeletons to consider as Clusters:');
for i=1:size(cID,2)
    if i<size(cID,2)
        fprintf(fid1, '%i\t', cID(1,i));
    else
        fprintf(fid1, '%i\n', cID(1,i));
    end
end
if size(cID,2)==0
    fprintf(fid1, '\n', []);
end

fprintf(fid1, '%s\n', 'ID of skeletons to consider as Others:');
for i=1:size(oID,2)
    if i<size(oID,2)
        fprintf(fid1, '%i\t', oID(1,i));
    else
        fprintf(fid1, '%i\n', oID(1,i));
    end
end
if size(oID,2)==0
    fprintf(fid1, '\n', []);
end
fclose(fid1);
movefile([PosFileName '_' NameOfElementOfInterest '_FinalCorrectionList.txt'],[PosFileName '/4_FinalResults/'])

Dislocations=cell(size(Skeleton,1),1);
Clusters=cell(size(Skeleton,1),1);
Others=cell(size(Skeleton,1),1);
for i=1:size(Skeleton,1)
    if ismember(i,dID)
        Dislocations{i,1}=Skeleton{i,1};
    elseif ismember(i,cID)
        Clusters{i,1}=Skeleton{i,1};
    elseif ismember(i,oID)
        Others{i,1}=Skeleton{i,1};
    elseif (Skeleton{i,1}.LengthModified)>=LengthThreshold
        Dislocations{i,1}=Skeleton{i,1};
    else
        Clusters{i,1}=Skeleton{i,1};
    end
end
Dislocations=Dislocations(~cellfun('isempty',Dislocations));
Clusters=Clusters(~cellfun('isempty',Clusters));
Others=Others(~cellfun('isempty',Others));

savefast([PosFileName,'/4_FinalResults/' PosFileName '_' NameOfElementOfInterest '_FinalResults.mat'],'Dislocations','Clusters','Others');

if app.T5CB2.Value
    app.T5L1.Text={'Start writing the pos file.','Please wait!'};
    WritePosFileTab5(Dislocations,Clusters,Others,app)
end

dLength=[];%SkeletonID length
if size(Dislocations,1)>0
    d=cell(size(Dislocations,1),1);
    dp=cell(size(Dislocations,1),1);
    for i=1:size(Dislocations,1)
        x=Dislocations{i,1}.SkeletonPointsDN;
        color=Dislocations{i,1}.color;
        d{i,1}=[x ones(size(x,1),1).*color];
        dp{i,1}=Dislocations{i,1}.OrigPointsDN;
        dLength=[dLength;Dislocations{i,1}.SkeletonID Dislocations{i,1}.LengthModified];
    end
    d=cell2mat(d);
    dp=cell2mat(dp);
    
    scatter3(app.T5F3,d(:,1),d(:,2),d(:,3),7.*ones(size(d,1),1),d(:,4:6),'filled');
    hold(app.T5F3,'on')
    plot3(app.T5F3,dp(:,1),dp(:,2),dp(:,3),'k.','MarkerSize',3)
    hold(app.T5F3,'off')
    view(app.T5F3,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
    xlim(app.T5F3,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T5F3,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T5F3,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    xlabel(app.T5F3,'X (nm)')
    ylabel(app.T5F3,'Y (nm)')
    zlabel(app.T5F3,'Z (nm)')
    if size(Dislocations,1)==1
        title(app.T5F3,[num2str(size(Dislocations,1)) ' dislocation'])
    else
        title(app.T5F3,[num2str(size(Dislocations,1)) ' dislocations'])
    end
    pbaspect(app.T5F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
    app.T5F3.Visible=true;
    
    dTempLength=dLength(:,2);
    edgeForHist=[min(dTempLength):10:max(dTempLength)];
    if size(edgeForHist,2)==1
        edgeForHist(1,2)=edgeForHist(1,1)+0.1;
    elseif edgeForHist(1,end)==edgeForHist(1,end-1)
        edgeForHist(1,end)=[];
    end
    histogram(dLength(:,2),edgeForHist,'Parent',app.T5F7)
    xlabel(app.T5F7,'Dislocation length (nm)')
    ylabel(app.T5F7,{'Number of'; 'dislocations'})
    app.T5F7.FontSize=12;
    app.T5F7.FontWeight='bold';
    app.T5F7.Visible=true;
    
    plot3(app.T5F5,dp(:,1),dp(:,2),dp(:,3),'r.','MarkerSize',3)
    hold(app.T5F5,'on')
    drawnow
    
    [N,edges]=histcounts(dLength(:,2));
    fid1 = fopen(['Fig3_' PosFileName '_' NameOfElementOfInterest '_DislocationLengthDistribution.txt'],'wt');
    fprintf(fid1, '%s\n', 'Histogram plot values:');
    fprintf(fid1, '%s\n', 'LengthRangeInitial(nm) LengthRangeFinal(nm) NumberOfObservations');
    for i=1:size(N,2)
        fprintf(fid1, '%14.2f\t %20.2f\t %14i\n', [edges(1,i) edges(1,i+1) N(1,i)]);
    end
    fprintf(fid1, '%s\n', 'Lenght of dislocations (nm):');
    fprintf(fid1, '%s\n', 'SkeletonID Lenght(nm)');
    for i=1:size(dLength,1)
        fprintf(fid1, '%5i\t %9.2f\n', dLength(i,1:2));
    end
    fclose(fid1);
    disPlotFlag=true;    
else
    disPlotFlag=false;
    title(app.T5F3,'No dislocations')
    app.T5F3.Visible=true;
    axis(app.T5F3,'off')
end

cSize=[];%SkeletonID, number of atoms
if size(Clusters,1)>0
    c=cell(size(Clusters,1),1);
    cp=cell(size(Clusters,1),1);
    for i=1:size(Clusters,1)
        x=Clusters{i,1}.SkeletonPointsDN;
        color=Clusters{i,1}.color;
        c{i,1}=[x ones(size(x,1),1).*color];
        cp{i,1}=Clusters{i,1}.OrigPointsDN;
        cSize=[cSize;Clusters{i, 1}.SkeletonID Clusters{i, 1}.npts];
    end
    c=cell2mat(c);
    cp=cell2mat(cp);
    
    scatter3(app.T5F4,c(:,1),c(:,2),c(:,3),7.*ones(size(c,1),1),c(:,4:6),'filled');
    hold(app.T5F4,'on')
    plot3(app.T5F4,cp(:,1),cp(:,2),cp(:,3),'k.','MarkerSize',3)
    hold(app.T5F4,'off')
    view(app.T5F4,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
    xlim(app.T5F4,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T5F4,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T5F4,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    xlabel(app.T5F4,'X (nm)')
    ylabel(app.T5F4,'Y (nm)')
    zlabel(app.T5F4,'Z (nm)')
    if size(Clusters,1)==1
        title(app.T5F4,[num2str(size(Clusters,1)) ' cluster'])
    else
        title(app.T5F4,[num2str(size(Clusters,1)) ' clusters'])
    end
    pbaspect(app.T5F4,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
    app.T5F4.Visible=true;
    
    if size(cSize(:,2),1)>1
        [optN, ~, ~] = sshist(cSize(:,2));
        if isempty(optN)
            optN=1;
        end
    else
        optN=1;
    end
    histogram(cSize(:,2),optN,'Parent',app.T5F8)
    xlabel(app.T5F8,'Cluster size (atoms)')
    ylabel(app.T5F8,{'Number of'; 'clusters'})
    app.T5F8.FontSize=12;
    app.T5F8.FontWeight='bold';
    app.T5F8.Visible=true;
    
    plot3(app.T5F5,cp(:,1),cp(:,2),cp(:,3),'b.','MarkerSize',3)
    hold(app.T5F5,'on')
    drawnow
    
    [N,edges]=histcounts(cSize(:,2));
    fid1 = fopen(['Fig4_' PosFileName '_' NameOfElementOfInterest '_ClusterSizeDistribution.txt'],'wt');
    fprintf(fid1, '%s\n', 'Histogram plot values:');
    fprintf(fid1, '%s\n', 'SizeRangeInitial(NumberOfAtoms) SizeRangeFinal(NumberOfAtoms) NumberOfObservations');
    for i=1:size(N,2)
        fprintf(fid1, '%14.2f\t %31.2f\t %20i\n', [edges(1,i) edges(1,i+1) N(1,i)]);
    end
    fprintf(fid1, '%s\n', 'Size of clusters (number of atoms):');
    fprintf(fid1, '%s\n', 'SkeletonID Size(numberOfAtoms)');
    for i=1:size(cSize,1)
        fprintf(fid1, '%5i\t %15i\n', cSize(i,1:2));
    end
    fclose(fid1);
    disClusFlag=true;     
else
    disClusFlag=false;
    title(app.T5F4,'No cluster')
    app.T5F4.Visible=true;
    axis(app.T5F4,'off')
end

if size(Others,1)>0
    o=cell(size(Others,1),1);
    op=cell(size(Others,1),1);
    for i=1:size(Others,1)
        x=Others{i,1}.SkeletonPointsDN;
        color=Others{i,1}.color;
        o{i,1}=[x ones(size(x,1),1).*color];
        op{i,1}=Others{i,1}.OrigPointsDN;
    end
    o=cell2mat(o);
    op=cell2mat(op);
    
    scatter3(app.T5F6,o(:,1),o(:,2),o(:,3),7.*ones(size(o,1),1),o(:,4:6),'filled');
    hold(app.T5F6,'on')
    plot3(app.T5F6,op(:,1),op(:,2),op(:,3),'k.','MarkerSize',3)
    hold(app.T5F6,'off')
    view(app.T5F6,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
    xlim(app.T5F6,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T5F6,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T5F6,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    xlabel(app.T5F6,'X (nm)')
    ylabel(app.T5F6,'Y (nm)')
    zlabel(app.T5F6,'Z (nm)')
    if size(Others,1)==1
        title(app.T5F6,[num2str(size(Others,1)) ' other object'])
    else
        title(app.T5F6,[num2str(size(Others,1)) ' other objects'])
    end
    pbaspect(app.T5F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
    app.T5F6.Visible=true;
    disOtherFlag=true;
    appDesignerFigSaver(app.T5F6,['Fig6_' PosFileName '_' NameOfElementOfInterest '_Others.tiff'],[app.T5F6.Position])
    movefile(['Fig6_' PosFileName '_' NameOfElementOfInterest '_Others.tiff'],[PosFileName,'/4_FinalResults'])
    
    plot3(app.T5F5,op(:,1),op(:,2),op(:,3),'g.','MarkerSize',3)
else
    disOtherFlag=false;
end
hold(app.T5F5,'off')
view(app.T5F5,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T5F5,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T5F5,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T5F5,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
xlabel(app.T5F5,'X (nm)')
ylabel(app.T5F5,'Y (nm)')
zlabel(app.T5F5,'Z (nm)')
title(app.T5F5,['  {\color{red}Dislocations\color{black}, \color{blue}Clusters \color{black}&} \color{green}Other objects'],'interpreter','tex')
pbaspect(app.T5F5,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T5F5.Visible=true;

app.T5L1.Text={'Saving figures in'; [PosFileName,'/4_FinalResults folder.']};pause(0.001)

appDesignerFigSaver(app.T5F5,['Fig5_' PosFileName '_' NameOfElementOfInterest '_ThreeColorPlot.tiff'],[app.T5F5.Position])
movefile(['Fig5_' PosFileName '_' NameOfElementOfInterest '_ThreeColorPlot.tiff'],[PosFileName,'/4_FinalResults'])

if disPlotFlag
    movefile(['Fig3_' PosFileName '_' NameOfElementOfInterest '_DislocationLengthDistribution.txt'],[PosFileName '/4_FinalResults/'])
    
    appDesignerFigSaver(app.T5F3,['Fig3_' PosFileName '_' NameOfElementOfInterest '_Dislocations.tiff'],[app.T5F3.Position])
    movefile(['Fig3_' PosFileName '_' NameOfElementOfInterest '_Dislocations.tiff'],[PosFileName,'/4_FinalResults'])
    
    appDesignerFigSaver(app.T5F7,['Fig3_' PosFileName '_' NameOfElementOfInterest '_DislocationLengthHistogram.tiff'],[app.T5F7.Position])
    movefile(['Fig3_' PosFileName '_' NameOfElementOfInterest '_DislocationLengthHistogram.tiff'],[PosFileName,'/4_FinalResults'])
end

if disClusFlag
    movefile(['Fig4_' PosFileName '_' NameOfElementOfInterest '_ClusterSizeDistribution.txt'],[PosFileName '/4_FinalResults/'])
    
    appDesignerFigSaver(app.T5F4,['Fig4_' PosFileName '_' NameOfElementOfInterest '_Clusters.tiff'],[app.T5F4.Position])
    movefile(['Fig4_' PosFileName '_' NameOfElementOfInterest '_Clusters.tiff'],[PosFileName,'/4_FinalResults'])
    
    appDesignerFigSaver(app.T5F8,['Fig4_' PosFileName '_' NameOfElementOfInterest '_ClusterSizeHistogram.tiff'],[app.T5F8.Position])
    movefile(['Fig4_' PosFileName '_' NameOfElementOfInterest '_ClusterSizeHistogram.tiff'],[PosFileName,'/4_FinalResults'])
end

if disOtherFlag
    appDesignerFigSaver(app.T5F6,['Fig6_' PosFileName '_' NameOfElementOfInterest '_Others.tiff'],[app.T5F6.Position])
    movefile(['Fig6_' PosFileName '_' NameOfElementOfInterest '_Others.tiff'],[PosFileName,'/4_FinalResults'])
end


app.T5P4.Visible=true;%composition
app.T5P5.Visible=true;%orientation
app.T5P6.Visible=true;%Angle between dislocation loops
app.T5B7.Visible=true;
app.T5P8.Visible=true;%plot combined IPF plot
clc
drawnow

app.T5L1.Text={'Done! If needed you can finalize the results again.';...
               '';...
               'You can now do the following post-processing analysis:';...
               '(1) Plotting the variation of solute concentration with respect to the distance';...
               'from the skeleton of dislocations or the center of clusters';...
               '(2) Determining the crystallographic plane of dislocation loops';...
               '(3) Measuring the angle between the normal directions of two dislocation loop planes';...
               '(4) Plotting the combined IPF plot (after doing postprocess analysis #2)';...
               '';...
               'To make a movie please go to the next tab "(4/2) Postprocessing (make a movie)".'};
app.T5Lamp1.Color='g';pause(0.001)

end