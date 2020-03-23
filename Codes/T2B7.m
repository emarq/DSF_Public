%Tab 2, Finalize the results of this tab pushbutton
function T2B7(app)

app.T2L1.Text={'Please wait.'};
app.T2Lamp1.Color='y';pause(0.001)

hdbscanSelByPersisAndProb=app.hdbscanSelByPersisAndProb;
input=str2num(char(app.T2EFT4.Value));
if size(input,1)>1 || ((~isempty(app.T2EFT4.Value)) && isempty(input))
    app.T2L1.Text='Please separate dense object ID values with ","';
    app.T2Lamp1.Color='r';pause(0.001)
    return   
end

SIZE=size(hdbscanSelByPersisAndProb,2);
for j=1:size(input,2)
    if input(1,j)>SIZE || input(1,j)<1 || (~(floor(input(1,j))==input(1,j))) 
        app.T2L1.Text={[num2str(input(1,j)) ' cannot be the ID of a dense object']};
        app.T2Lamp1.Color='r';pause(0.001)
        return
    end
end

if size(input,2)>1
    input=unique(input);%To avoid problem if the user repeats an ID
end

counter=0;
Save=cell(size(hdbscanSelByPersisAndProb,2),1);
for j=1:size(hdbscanSelByPersisAndProb,2)
    if ~(ismember(j,input))
        counter=counter+1;
        hdbscanSelByPersisAndProb_Tab2Finalized(counter)=hdbscanSelByPersisAndProb(j);
        color=hdbscanSelByPersisAndProb(j).color;
        x=hdbscanSelByPersisAndProb(j).atomPositions;
        Save{j,1}=[x color.*ones(size(x,1),1)];
    end
end

for j=1:size(hdbscanSelByPersisAndProb_Tab2Finalized,2)
    hdbscanSelByPersisAndProb_Tab2Finalized(j).UpdatedNewLabel=j;
end
app.T2L1.Text={'Plotting the finalized results.';'Please wait.'};
Save=cell2mat(Save);
cla(app.T2F6,'reset')
if size(Save,1)>0
    scatter3(app.T2F6,Save(:,1),Save(:,2),Save(:,3),5.*ones(size(Save,1),1),Save(:,4:6),'filled')
    
    view(app.T2F6,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
    xlim(app.T2F6,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T2F6,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T2F6,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    
    xlabel(app.T2F6,'X (nm)')
    ylabel(app.T2F6,'Y (nm)')
    zlabel(app.T2F6,'Z (nm)')
    
    hdbscanPersistencyThreshold=str2double(char(app.T2EFT2.Value));
    hdbscanProbabilityThreshold=str2double(char(app.T2EFT03.Value));
    
    title(app.T2F6,{['Number of finalized dense objects is ' num2str(size(hdbscanSelByPersisAndProb_Tab2Finalized,2))];['Persistence score>= ' num2str(hdbscanPersistencyThreshold) '  Probability>= ' num2str(hdbscanProbabilityThreshold)]})
    %axis(app.T2F6,'off')
    pbaspect(app.T2F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
else
    title(app.T2F6,'Nothing to plot')
end
drawnow

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);
app.T2L1.Text={'Transferring the generated files to the'; [PosFileName,'/2_ClusterAnalysis folder.'];'Please wait!'};
savefast('hdbscanSelByPersisAndProb_Tab2Finalized.mat','hdbscanSelByPersisAndProb_Tab2Finalized')
movefile('hdbscanSelByPersisAndProb_Tab2Finalized.mat',[PosFileName,'/2_ClusterAnalysis'])

if (exist('HDBSCANoutputsFirst','dir')==7)
    movefile('HDBSCANoutputsFirst',[PosFileName,'/2_ClusterAnalysis'])
end

if (exist([PosFileName '_' NameOfElementOfInterest '.txt'],'file')==2)
    movefile([PosFileName '_' NameOfElementOfInterest '.txt'],[PosFileName,'/2_ClusterAnalysis/HDBSCANoutputsFirst'])
end

if exist('HDBSCANoutputsTemp','dir')==7
    movefile('HDBSCANoutputsTemp','HDBSCANoutputsSecond')
    movefile('HDBSCANoutputsSecond',[PosFileName,'/2_ClusterAnalysis'])
end

if (exist('0_CumulativePlot_NumberOfCLustersVSHDBSCANPersistenceThreshold.tiff','file')==2)
    movefile('0_CumulativePlot_NumberOfCLustersVSHDBSCANPersistenceThreshold.tiff',[PosFileName,'/2_ClusterAnalysis'])
end

if (exist('0_CumulativePlot_NumberOfCLustersVSHDBSCANPersistenceThreshold.txt','file')==2)
    movefile('0_CumulativePlot_NumberOfCLustersVSHDBSCANPersistenceThreshold.txt',[PosFileName,'/2_ClusterAnalysis'])
end
if (exist('2_HDBSCAN_ClusterCentersConsideringPersistanceThreshold.txt','file')==2)
    movefile('2_HDBSCAN_ClusterCentersConsideringPersistanceThreshold.txt',[PosFileName,'/2_ClusterAnalysis'])
end

if (exist('2_HDBSCAN_ClusterCentersNOTconsideringPersistanceThreshold.txt','file')==2)
    movefile('2_HDBSCAN_ClusterCentersNOTconsideringPersistanceThreshold.txt',[PosFileName,'/2_ClusterAnalysis'])
end

fid1 = fopen('00_ParamtersUsedForClusterAnalyses_Tab2.txt','wt');
fprintf(fid1, '%s', '              Pos-file name:');
fprintf(fid1, '%s\n', PosFileName);

fprintf(fid1, '%s', '        Element of interest:');
fprintf(fid1, '%s\n',NameOfElementOfInterest);

MinClusterSizeHDBSCAN=app.T2EFT01.Value;
fprintf(fid1, '%s', '             MinClusterSize=');
fprintf(fid1, '%s\n', MinClusterSizeHDBSCAN);

MinSamplesHDBSCAN=app.T2EFT02.Value;
fprintf(fid1, '%s', '                 MinSamples=');
fprintf(fid1, '%s\n', MinSamplesHDBSCAN);

hdbscanPersistencyThreshold=app.T2EFT2.Value;
fprintf(fid1, '%s', ' Persistenc score threshold=');
fprintf(fid1, '%s\n', hdbscanPersistencyThreshold);
hdbscanProbabilityThreshold=app.T2EFT03.Value;
fprintf(fid1, '%s', '      Probability Threshold=');
fprintf(fid1, '%s\n', hdbscanProbabilityThreshold);

fprintf(fid1, '%s\n', '----------------------------');
if size(input,1)==0
    fprintf(fid1, '%s', 'No object was removed in Tab 2 (by "Finalizing the results" pushbutton).');
else
    fprintf(fid1, '%s\n', 'The removed object IDs in Tab 2 (by "Finalizing the results" pushbutton) are:'); 
    for j=1:size(input,2)
        fprintf(fid1, '%i\t', input(1,j));
    end
end

fclose(fid1);
movefile('00_ParamtersUsedForClusterAnalyses_Tab2.txt',[PosFileName,'/2_ClusterAnalysis'])

app.T2DD1.Value='x-axis';
app.T2DD2.Value='z-axis';
app.T2DD3.Value='Azimuth';
app.T2S2.Value=0;
app.T2S2previousValue=0;
app.T2S3.Value=1;
Reset_Figs(app.T2F2,app);drawnow
Reset_Figs(app.T2F3,app);drawnow
Reset_Figs(app.T2F4,app);drawnow
Reset_Figs(app.T2F5,app);drawnow
Reset_Figs(app.T2F6,app);drawnow

appDesignerFigSaver(app.T2F2,'1_OriginalPointCloud.tiff',app.T2F2.Position)
movefile('1_OriginalPointCloud.tiff',[PosFileName,'/2_ClusterAnalysis'])

appDesignerFigSaver(app.T2F3,'2_DetctedDenseObjectsWithNoise.tiff',app.T2F3.Position)
movefile('2_DetctedDenseObjectsWithNoise.tiff',[PosFileName,'/2_ClusterAnalysis'])

appDesignerFigSaver(app.T2F4,'3_DetctedDenseObjectsWithOUTnoise.tiff',app.T2F4.Position)
movefile('3_DetctedDenseObjectsWithOUTnoise.tiff',[PosFileName,'/2_ClusterAnalysis'])

appDesignerFigSaver(app.T2F5,'4_DetctedDenseObjectsColoredBasedOnPersistenceScore.tiff',app.T2F5.Position)
movefile('4_DetctedDenseObjectsColoredBasedOnPersistenceScore.tiff',[PosFileName,'/2_ClusterAnalysis'])

appDesignerFigSaver(app.T2F6,'5_FinalizedDetectedDenseObjects_Tab2.tiff',app.T2F6.Position)
movefile('5_FinalizedDetectedDenseObjects_Tab2.tiff',[PosFileName,'/2_ClusterAnalysis'])

app.T2L1.Text={'Done!';'If needed, we can finalize the results again; otherwise,';'we can go to the next tab.'};
app.T2Lamp1.Color='g';pause(0.001)
end