%Tab 5, Initialize this tab pushbutton
function T5B1(app)

app.T5L1.Text='Please wait!';
app.T5Lamp1.Color='y';pause(0.001)
ClearAllGlobalVariable(app)
cla_Invisible_Tab4_AllFigures(app)
cla_Invisible_Tab5_AllFigures(app)

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

if isempty(PosFileName)
    app.T5L1.Text={'Please write the name of the pos file in the first tab';'and then click the "Initialize this tab" button again.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif isempty(NameOfElementOfInterest)
    app.T5L1.Text={'Please write the name of the element of interest in the first tab';'and then click the "Initialize this tab" button again.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets'],'dir')==7) %It is used to make hdbscanCluster in hdbscanPostProcess function
    app.T5L1.Text={'You did not do the "Import pose file" analysis on the first tab';['for the "' PosFileName '.pos" file.'];'Please start the analysis from the first tab.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '.mat'],'file')==2) %It is used to make hdbscanCluster in hdbscanPostProcess function
    app.T5L1.Text={'You did not do the "Import pose file" analysis on the first tab';['for the "' NameOfElementOfInterest '" atoms.'];'Please start the analysis from the first tab.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '_OtherAtoms.mat'],'file')==2)
    app.T5L1.Text={['It looks that there is no atom other than "' NameOfElementOfInterest '" atoms in the pos file.'];
                    'Please start the analysis from the first tab and slightly change the mass-to-charge ratio values';['in way that we have both ' NameOfElementOfInterest ' atoms and other atoms.']};
    app.T5Lamp1.Color='r';
    return
elseif ~(exist([PosFileName '/2_ClusterAnalysis/' PosFileName '_' NameOfElementOfInterest '_hdbFinal_Tab3Finalized.mat'],'file')==2) %It is used to make sure that the third tab is completed before this tab
    app.T5L1.Text={'You did not finalize the results of the third tab.';'Please start the analysis from the third tab.'; '"(2/2) Detecting dense objects (pruning)"'};
    app.T5Lamp1.Color='r';
    return
elseif ~(exist([PosFileName,'/1_Datasets/AxisLimits.txt'],'file')==2)
    app.T5L1.Text={'AxisLimits.txt file is missing.';'Please start the analysis from the first tab.'};
    app.T5Lamp1.Color='r';
    return
elseif ~(exist([PosFileName '/3_Skeleton/' PosFileName '_' NameOfElementOfInterest '_FinalSkeleton.mat'],'file')==2)
    app.T5L1.Text={'You did not finalize the results of the fourth tab.';'Please start the analysis from the fourth tab.'; '"(3) Extracting skeletons"'};
    app.T5Lamp1.Color='r';
    return
end

app.T5L1.Text={'Start loading the skeleton data from the previous tab.'; 'The file name is';[PosFileName '_' NameOfElementOfInterest '_FinalSkeleton.mat'];'in';[PosFileName,'/3_Skeleton' ' folder.']};pause(0.001)
AAA=load([PosFileName '/3_Skeleton/' PosFileName '_' NameOfElementOfInterest '_FinalSkeleton.mat']);
Skeleton=AAA.FinalSkeleton;
app.Skeleton=Skeleton;

app.AxisLimits=importdata([PosFileName,'/1_Datasets/AxisLimits.txt']);

app.T5L1.Text={'Loading atoms of interest data.';'Please wait!'};pause(0.001)
AAA=load([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '.mat']);
Interest=AAA.Interest;
app.Interest=Interest;
MaxNumAtomToPlot=str2double(char(app.T1EFT4.Value));
if size(Interest,1)>MaxNumAtomToPlot   %if we have more than 250,000 atom of interest, we only present
    rng(7,'twister');%To ensure the randperm generates the same number array for plots T1F1 and T2F2
    INDEX=randperm(size(Interest,1),MaxNumAtomToPlot);
    plot3(app.T5F1,Interest(INDEX,1),Interest(INDEX,2),Interest(INDEX,3),'k.','MarkerSize',3)
    title(app.T5F1,{[num2str(size(Interest,1)) ' ' NameOfElementOfInterest ' atoms in the original dataset'],['Only ' num2str(MaxNumAtomToPlot) ' of atoms are randomly shown (~' num2str(round(100*MaxNumAtomToPlot/size(Interest,1)),4) '%)']});
    view(app.T5F1,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
else
    plot3(app.T5F1,Interest(:,1),Interest(:,2),Interest(:,3),'k.','MarkerSize',3)
    title(app.T5F1,[num2str(size(Interest,1)) ' ' NameOfElementOfInterest ' atoms in the original dataset']);
    view(app.T5F1,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
end

xlim(app.T5F1,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T5F1,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T5F1,[app.AxisLimits(3,1) app.AxisLimits(3,2)])

xlabel(app.T5F1,'X (nm)')
ylabel(app.T5F1,'Y (nm)')
zlabel(app.T5F1,'Z (nm)')
axis(app.T5F1,'off')

pbaspect(app.T5F1,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T5F1.Visible=true;
drawnow

app.T5L1.Text={'Loading other atoms data.';'Please wait!'};pause(0.001)
AAA=load([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '_OtherAtoms.mat']);
OtherAtoms=AAA.Others;
app.OtherAtoms=OtherAtoms;

ForPlot=cell(size(Skeleton,1),1);
for j=1:size(Skeleton,1)
    color=Skeleton{j,1}.color;
    SkeletonPointsDN=Skeleton{j, 1}.SkeletonPointsDN;
    ForPlot{j,1}=[SkeletonPointsDN ones(size(SkeletonPointsDN,1),1).*color];
end
ForPlot=cell2mat(ForPlot);

handleT5F2=scatter3(app.T5F2,ForPlot(:,1),ForPlot(:,2),ForPlot(:,3),5.*ones(size(ForPlot,1),1),ForPlot(:,4:6),'filled');
app.handleT5F2=handleT5F2;
view(app.T5F2,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T5F2,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T5F2,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T5F2,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
xlabel(app.T5F2,'X (nm)')
ylabel(app.T5F2,'Y (nm)')
zlabel(app.T5F2,'Z (nm)')
title(app.T5F2,'Skeleton of the dense objects')
axis(app.T5F2,'off')
%axis(app.handleT5F2,'equal')
pbaspect(app.T5F2,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T5F2.Visible=true;
drawnow

app.T5CB1.Value=0;
%I need to initialize crop here

if exist([PosFileName,'/4_FinalResults'],'dir')==7
    rmdir([PosFileName,'/4_FinalResults'],'s')
end
mkdir(PosFileName,'4_FinalResults')
mkdir(PosFileName,'/4_FinalResults/IPFplotData/')
mkdir(PosFileName,'/4_FinalResults/IPFplots/')

app.T5L1.Text={'Saving figures 1 and 2 in ';[PosFileName,'/4_FinalResults folder']};pause(0.001)
appDesignerFigSaver(app.T5F1,['Fig1_' PosFileName '_' NameOfElementOfInterest '_OriginalDataset.tiff'],[app.T5F1.Position])
movefile(['Fig1_' PosFileName '_' NameOfElementOfInterest '_OriginalDataset.tiff'],[PosFileName,'/4_FinalResults'])

appDesignerFigSaver(app.T5F2,['Fig2_' PosFileName '_' NameOfElementOfInterest '_Skeleton.tiff'],[app.T5F2.Position])
movefile(['Fig2_' PosFileName '_' NameOfElementOfInterest '_Skeleton.tiff'],[PosFileName,'/4_FinalResults'])

app.T5S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T5S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));

app.T5S2.Value=0;
app.T5S2previousValue=0;

app.T5L1.Text={'Please set the "skeleton length threshold"';'and then click the "Plot" button.';
    '';
    'If the plot which shows the orginal dataset has too many atoms, please reduce the value of the';
    '"Maximum number of atoms to plot" box in the first tab and then get'; 'back to the current tab and hit the "Initialize this tab" button again.'};
app.T5Lamp1.Color='g';pause(0.001)
            
end