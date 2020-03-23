%Tab2, Find dense objects pushbutton
function T2B1(app)
ClearAllGlobalVariable(app)

MinClusterSizeHDBSCAN=str2double(char(app.T2EFT01.Value));
MinSamplesHDBSCAN=str2double(char(app.T2EFT02.Value));
hdbscanProbabilityThreshold=str2double(char(app.T2EFT03.Value));
if ~(floor(MinClusterSizeHDBSCAN)==MinClusterSizeHDBSCAN && MinClusterSizeHDBSCAN>0) 
    app.T2L1.Text='"MinClusterSize" must be an integer value.';
    app.T2Lamp1.Color='r';pause(0.001)
    return
elseif ~(floor(MinSamplesHDBSCAN)==MinSamplesHDBSCAN && MinSamplesHDBSCAN>0)
    app.T2L1.Text='"MinSamples" must be an integer value.';
    app.T2Lamp1.Color='r';pause(0.001) 
    return
elseif hdbscanProbabilityThreshold<0 || hdbscanProbabilityThreshold>1 || isnan(hdbscanProbabilityThreshold)
    app.T2L1.Text='The "Probability threshold" value must be between 0 and 1. ';
    app.T2Lamp1.Color='r';pause(0.001) 
    return
end

app.T2Lamp1.Color='y';
app.T2L1.Text={'Importing and preparing files!';'Please wait'};pause(0.001)

PosFileName=char(app.T1EFT1.Value);

app.AxisLimits=importdata([PosFileName,'/1_Datasets/AxisLimits.txt']);

NameOfElementOfInterest=char(app.T1EFT2.Value);
strTemp=[PosFileName '_' NameOfElementOfInterest '.mat'];

if exist([PosFileName,'/2_ClusterAnalysis'],'dir')==7
    rmdir([PosFileName,'/2_ClusterAnalysis'],'s')
end
mkdir(PosFileName,'2_ClusterAnalysis')

AAA=load([PosFileName '/1_Datasets/' strTemp]);
Interest=AAA.Interest;
DatasetName=[strTemp(1:end-4) '.txt'];
fid1 = fopen(DatasetName,'wt');
for i=1:size(Interest,1)
    fprintf(fid1, '%10.3f\t %10.3f\t %10.3f\n', Interest(i,:));
end
fclose(fid1);

app.T2L1.Text={'Plotting the original dataset';'Please wait'};
MaxNumAtomToPlot=str2double(char(app.T1EFT4.Value));

if size(Interest,1)>MaxNumAtomToPlot   %if we have more than 250,000 atom of interest, we only present
    rng(7,'twister');%To ensure the randperm generates the same number array for plots T1F1 and T2F2
    INDEX=randperm(size(Interest,1),MaxNumAtomToPlot);
    plot3(app.T2F2,Interest(INDEX,1),Interest(INDEX,2),Interest(INDEX,3),'k.','MarkerSize',3)
    title(app.T2F2,{[num2str(size(Interest,1)) ' ' NameOfElementOfInterest ' atoms in the original dataset'],['Only ' num2str(MaxNumAtomToPlot) ' of atoms are randomly shown (~' num2str(round(100*MaxNumAtomToPlot/size(Interest,1)),4) '%)']});
    view(app.T2F2,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
else
    plot3(app.T2F2,Interest(:,1),Interest(:,2),Interest(:,3),'k.','MarkerSize',3)
    title(app.T2F2,[num2str(size(Interest,1)) ' ' NameOfElementOfInterest ' atoms in the original dataset']);
    view(app.T2F2,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
end

xlabel(app.T2F2,'X (nm)')
ylabel(app.T2F2,'Y (nm)')
zlabel(app.T2F2,'Z (nm)')
axis(app.T2F2,'off')

xlim(app.T2F2,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T2F2,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T2F2,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
pbaspect(app.T2F2,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T2F2.Visible=true;
app.T2L1.Text=['Drawing the ' NameOfElementOfInterest ' ions!'];pause(0.001)
app.T2F2.Visible=true;
drawnow

app.T2L1.Text='Start HDBSCAN analysis for the first time';
app.T2Lamp1.Color='y';pause(0.001)
[~,~,hdbscanSelByPersisAndProb]=HDBSCAN(DatasetName,hdbscanProbabilityThreshold,MinClusterSizeHDBSCAN,MinSamplesHDBSCAN,app,Interest);%output is [hdbscanCluster,hdbscanPersistencyThreshold,hdbscanSelByPersisAndProb]
if isempty(hdbscanSelByPersisAndProb)
    return
end
app.hdbscanSelByPersisAndProb=hdbscanSelByPersisAndProb;

app.T2S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T2S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));

app.T2S2.Value=0;
app.T2S2previousValue=0;

app.T2P2_2.Visible=true;
app.T2L1.Text={'Done with detecting dense objects.';'If you want to get the ID of a dense object, click on "Get dense object ID" and'; 'then click on the object in the second plot from the right side.';...
    'To finalize the results of this tab click on "Finalize the results of this tab".'};
app.T2Lamp1.Color='g';pause(0.001)

end