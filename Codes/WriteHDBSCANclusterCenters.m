%Writing HDBSCAN cluster centers
function MaxPersis=WriteHDBSCANclusterCenters(hdbscanCluster,app)

if size(hdbscanCluster,2)==0
    app.T2L1.Text='No dense-object was found. Please change the values of MinClusterSizeHDBSCAN and MinSamplesHDBSCAN parameters.';
    app.T2Lamp1.Color='r';
    error('No dense-object was found. Please change the values of MinClusterSizeHDBSCAN and MinSamplesHDBSCAN parameters.')
end

pSave(1:size(hdbscanCluster,2),1:9)=0;
fid1 = fopen('2_HDBSCAN_ClusterCentersNOTconsideringPersistanceThreshold.txt','wt');
fprintf(fid1, '%s\n', '   Label PersistanceScore MinProb    MeanProb     MaxProb XClusCenter YClusCenter ZClusCenter ClusterSize');
for i=1:size(hdbscanCluster,2)
    p1=hdbscanCluster(i).labels;
    p2=hdbscanCluster(i).persistence;
    tempProb=hdbscanCluster(i).probabilities;
    p31=min(tempProb);
    p32=mean(tempProb); 
    p33=max(tempProb);
    tempAtomPos=hdbscanCluster(i).atomPositions;
    p41=mean(tempAtomPos(:,1)); 
    p42=mean(tempAtomPos(:,2)); 
    p43=mean(tempAtomPos(:,3));
    p5=size(tempAtomPos,1);
    
    PRINT=[p1 p2 p31 p32 p33 p41 p42 p43 p5];%label persistancy MinProb MeanProb MaxProb XClusCenter YClusCenter ZClusCenter ClusterSize 
    fprintf(fid1, '%6i\t %10.3f\t %10.2f\t %10.2f\t %10.2f\t %10.5f\t %10.5f\t %10.5f\t %6i\n', PRINT);
    pSave(i,:)=PRINT;  
end
fclose(fid1);
MaxPersis=max(pSave(:,2));
PlotNumberofClusterVsHDBSCANpersistencyThreshold(pSave,app);

end