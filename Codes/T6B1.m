%Tab 6, Initialize this tab button
function T6B1(app)

app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)
ClearAllGlobalVariable(app)
ResetTab6Values(app);
cla_Tab6_AllFigures(app)

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);


if isempty(PosFileName)
    app.T6L1.Text={'Please write the name of the pos file in the first tab';'and then click the "Initialize this tab" button again.'};
    app.T6Lamp1.Color='r';pause(0.001)
    return
elseif isempty(NameOfElementOfInterest)
    app.T6L1.Text={'Please write the name of the element of interest in the first tab';'and then click the "Initialize this tab" button again.'};
    app.T6Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets'],'dir')==7) %It is used to make hdbscanCluster in hdbscanPostProcess function
    app.T6L1.Text={'You did not do the "Import pose file" analysis on the first tab';['for the "' PosFileName '.pos" file.'];'Please start the analysis from the first tab.'};
    app.T6Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '.mat'],'file')==2) %It is used to make hdbscanCluster in hdbscanPostProcess function
    app.T6L1.Text={'You did not do the "Import pose file" analysis on the first tab';['for the "' NameOfElementOfInterest '" atoms.'];'Please start the analysis from the first tab.'};
    app.T6Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '_OtherAtoms.mat'],'file')==2)
    app.T6L1.Text={['It looks that there is no atom other than "' NameOfElementOfInterest '" atoms in the pos file.'];
                    'Please start the analysis from the first tab and slightly change the mass-to-charge ratio values';['in way that we have both ' NameOfElementOfInterest ' atoms and other atoms.']};
    app.T6Lamp1.Color='r';
    return
elseif ~(exist([PosFileName '/2_ClusterAnalysis/' PosFileName '_' NameOfElementOfInterest '_hdbFinal_Tab3Finalized.mat'],'file')==2) %It is used to make sure that the third tab is completed before this tab
    app.T6L1.Text={'You did not finalize the results of the third tab.';'Please start the analysis from the third tab.'; '"(2/2) Detecting dense objects (pruning)"'};
    app.T6Lamp1.Color='r';
    return
elseif ~(exist([PosFileName,'/1_Datasets/AxisLimits.txt'],'file')==2)
    app.T6L1.Text={'AxisLimits.txt file is missing.';'Please start the analysis from the first tab.'};
    app.T6Lamp1.Color='r';
    return
elseif ~(exist([PosFileName '/3_Skeleton/' PosFileName '_' NameOfElementOfInterest '_FinalSkeleton.mat'],'file')==2)
    app.T6L1.Text={'You did not finalize the results of the fourth tab.';'Please start the analysis from the fourth tab.'; '"(3) Extracting skeletons"'};
    app.T6Lamp1.Color='r';
    return
elseif ~(exist([PosFileName '/4_FinalResults/' PosFileName '_' NameOfElementOfInterest '_FinalResults.mat'],'file')==2)
    app.T6L1.Text={'You did not finalize the results of the fifth tab.';'Please start the analysis from the fifth tab.'; '"(4/1) Postprocessing (final corrections)"'};
    app.T6Lamp1.Color='r';
    return    
end     
                                
app.T6L1.Text={'Start loading the skeleton data from the previous tab.'; 'The file name is';[PosFileName '_' NameOfElementOfInterest '_FinalResults.mat'];'in';[PosFileName,'/4_FinalResults' ' folder.']};

AAA=load([PosFileName '/4_FinalResults/' PosFileName '_' NameOfElementOfInterest '_FinalResults.mat']);
app.Clusters=AAA.Clusters;
app.Dislocations=AAA.Dislocations;
app.Others=AAA.Others;

app.AxisLimits=importdata([PosFileName,'/1_Datasets/AxisLimits.txt']);

app.T6L1.Text='Loading atoms of interest data.';
AAA=load([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '.mat']);
Interest=AAA.Interest;
app.Interest=Interest;

app.T6S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T6S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));

app.T6S2.Value=0;
app.T6S2previousValue=0;

app.T6S3.Value=1;

if exist([PosFileName,'/4_FinalResults_Video'],'dir')==7
    rmdir([PosFileName,'/4_FinalResults_Video'],'s')
end
mkdir(PosFileName,'4_FinalResults_Video')

app.T6L1.Text={'Done!';'Please click on the "Plot" button.';
                '';'For saving a figure, please set the "Title type" to "Intrinsic".';
                '';'For capturing a video, set the "Title type" to "Fixed".'};
app.T6Lamp1.Color='g';pause(0.001)
end