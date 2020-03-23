%Calling the functions required for HDBSCAN analysis
function [hdbscanCluster,hdbscanPersistencyThreshold,hdbscanSelByPersisAndProb]=HDBSCAN(DatasetName,hdbscanProbabilityThreshold,MinClusterSizeHDBSCAN,MinSamplesHDBSCAN,app,Interest)
       
hdbscanPersistencyThreshold=0;
app.T2L1.Text={'If it takes for a too long time or the result does not make sense,';'please either change the parameters or use the MAC/LINUX version of the code.'};pause(0.001)

hdbscanCluster=hdbscanAnalysis(DatasetName,MinClusterSizeHDBSCAN,MinSamplesHDBSCAN,Interest);
if size(hdbscanCluster,2)<1 
    app.T2L1.Text={'No dense object was detected.';'Potenital solutions to fix this issue are:';'(1) Reducing MinSampleSize to declare more atoms as noise.';...
                   '(2) Reducing MinClusterSize.';'(3) Switching to Linux if you are using Windows 10.'};
    app.T2Lamp1.Color='r';pause(0.001)
    hdbscanCluster=[];hdbscanPersistencyThreshold=[];hdbscanSelByPersisAndProb=[];
    return
end

app.T2L1.Text='Writing dense-object center file without considering persistence score.';pause(0.001)
MaxPersis=WriteHDBSCANclusterCenters(hdbscanCluster,app);

app.T2CB1.Value=0;
app.T2CB2.Value=0;
app.T2CB2.Visible=false;
app.T2P2.Visible=true;
app.T2CB1.Visible=true;

%Persistence score
app.T2L1.Text={'Please set a persistence score value ';'and check the "Plot(considering persistence score)" box.'};
app.T2Lamp1.Color='g';pause(0.001)

HappyWithPersisValue=false;
FirstTime=true;
FirstVisible=true;
while ~HappyWithPersisValue
    PlotAgain=app.T2CB1.Value;
    if size(PlotAgain,1)==0%maybe it is not necessary in app designer
        PlotAgain=false(1);
    end
    if PlotAgain
        hdbscanPersistencyThreshold=str2double(char(app.T2EFT2.Value));
		while isnan(hdbscanPersistencyThreshold) || hdbscanPersistencyThreshold>MaxPersis || hdbscanPersistencyThreshold<0  
          app.T2EFT2.Value='';  
          app.T2CB1.Value=false;
		  app.T2L1.Text={['The persistence score threshold must be a value between 0 and ' num2str(MaxPersis)  '.'];'Please set the persistence score threshold and check the "Plot (considering persistence score)" box.'};
          app.T2Lamp1.Color='r';pause(0.001)
		  waitfor(app.T2CB1,'Value',1) 
          hdbscanPersistencyThreshold=str2double(char(app.T2EFT2.Value));
		end
        app.T2L1.Text={'Plotting cluster analysis results based on';['persistence score value of ' num2str(hdbscanPersistencyThreshold) '.'];'Please wait.'};
        app.T2Lamp1.Color='y';pause(0.001)
        PlotDetectedClustersbyHDBSCAN1inGUI(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,app);
        PlotDetectedClustersbyHDBSCAN1inGUIsmall(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,app);
        app.T2CB1.Value=0;    
    end
    if FirstTime
        app.T2L1.Text={'Please set the persistence score threshold and';'then check the "Plot (considering persistence score)" box.';
                       '';'If the plot which shows the orginal dataset (or the plot which shows the detected dense objects and'; 'noise) has too many atoms, please reduce the value of the';
                       '"Maximum number of atoms to plot" box in the first tab and then get'; 'back to the current tab and hit the "Initialize this tab" button again.'};
            
        app.T2Lamp1.Color='g';pause(0.001)
        FirstTime=false(1);
    else
        app.T2L1.Text={'Please set the persistence score threshold and check the "Plot (considering persistence score)" box.';'or';'Check "All dense objects are detected" box if all dense objects are detected.';
                                   '';'If the plot which shows the orginal dataset (or the plot which shows the detected dense objects and'; ' noise) has too many atoms, please reduce the value of the';
                       '"Maximum number of atoms to plot" box in the first tab and then get'; 'back to the current tab and hit the "Initialize this tab" button again.'
            };
        app.T2Lamp1.Color='g';pause(0.001)
        if FirstVisible
            FirstVisible=false;
            app.T2CB2.Visible=true;
        end
    end
    waitfor(app.T2CB1,'Value',1)
    HappyWithPersisValue=(app.T2CB2.Value);
    %if size(HappyWithPersisValue,1)==0  %No need in app designer
    %    HappyWithPersisValue=false;
    %end
end

app.T2CB1.Value=0;
app.T2CB1.Visible=false;

%The next for line is for the case that the user check all the dense
%objects are detected without plotting them.
hdbscanPersistencyThreshold=str2double(char(app.T2EFT2.Value));
app.T2L1.Text={'Plotting cluster analysis results based on';['persistence score value of ' num2str(hdbscanPersistencyThreshold) '.'];'Please wait.'};
app.T2Lamp1.Color='y';pause(0.001)
PlotDetectedClustersbyHDBSCAN1inGUI(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,app);

app.T2L1.Text={['Plotting dense objects with persistence score value >= ' num2str(hdbscanPersistencyThreshold) ];'Please wait.'};
app.T2Lamp1.Color='y';pause(0.001)
PlotDetectedClustersbyHDBSCAN1inGUIsmall(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,app)
PlotDetectedClustersbyHDBSCAN1inGUIsmall_PersisColor(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,app)

%for saving time, for now I skip the following now.
%PlotDetectedClustersbyHDBSCAN1(DatasetName,hdbscanCluster,hdbscanPersistencyThreshold,hdbscanProbabilityThreshold,AxisLimits,FigHandles);
app.T2L1.Text={'';['Persistence score value is finally set to ' num2str(hdbscanPersistencyThreshold) '.']};pause(0.001)

fid0 = fopen('2_HDBSCAN_ClusterCentersConsideringPersistanceThreshold.txt','wt');
fprintf(fid0, '%s\n', '   Label PersistanceScore MinProb     MeanProb    MaxProb XClusCenter YClusCenter ZClusCenter ClusterSize');
for i=1:size(hdbscanCluster,2)
    p1=hdbscanCluster(i).labels;
    p2=hdbscanCluster(i).persistence;
    tempProb=hdbscanCluster(i).probabilities;
    p31=min(tempProb) ;
    if p2>=hdbscanPersistencyThreshold
        p32=mean(tempProb);
        p33=max(tempProb);
        tempAtomPos=hdbscanCluster(i).atomPositions;
        p41=mean(tempAtomPos(:,1));
        p42=mean(tempAtomPos(:,2));
        p43=mean(tempAtomPos(:,3));
        p5=size(tempAtomPos,1);
        
        PRINT=[p1 p2 p31 p32 p33 p41 p42 p43 p5];%label persistancy MinProb MeanProb MaxProb XClusCenter YClusCenter ZClusCenter ClusterSize
        fprintf(fid0, '%6i\t %10.3f\t %10.2f\t %10.2f\t %10.2f\t %10.5f\t %10.5f\t %10.5f\t %6i\n', PRINT);
    end
end
fclose(fid0);

j=0;
for i=1:size(hdbscanCluster,2)
    if hdbscanCluster(i).persistence>=hdbscanPersistencyThreshold
        j=j+1;
        hdbscanSelByPersisAndProb(j).persistence=hdbscanCluster(i).persistence;
        hdbscanSelByPersisAndProb(j).labels=hdbscanCluster(i).labels;%This is the label that we get from HDBSCAN
        hdbscanSelByPersisAndProb(j).Newlabels=j;%To make the analysis easier, we relable the dense objects from 1 to n again
        hdbscanSelByPersisAndProb(j).color=hdbscanCluster(i).color;
        
        Xtemp=hdbscanCluster(i).atomPositions;
        Probability=hdbscanCluster(i).probabilities;
        [row, ~]=find(Probability(:,1)>=hdbscanProbabilityThreshold);
        
        hdbscanSelByPersisAndProb(j).atomPositions=Xtemp(row,1:3);
        hdbscanSelByPersisAndProb(j).probabilities=Probability(row,1);
    end
end
    
end