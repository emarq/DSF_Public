%Tab 5, Plot pushbutton in the "Ploting solute variation from a dislocation skeleton or a cluster center" panel
function T5B7(app)

cla(app.T5F9,'reset')
app.T5F9.Visible=false;
cla(app.T5F10,'reset')
app.T5F10.Visible=false;
cla(app.T5F6,'reset')
app.T5F6.Visible=false;
drawnow

app.T5L1.Text={'Checking for the errors in the input paramters','Please wait'};
app.T5Lamp1.Color='y';pause(0.001)

Rmin=str2num(char(app.T5EFT6.Value));
if ~(size(Rmin,1)==1) || ~(size(Rmin,2)==1) || Rmin<=0 
    app.T5L1.Text={'Please fill the "Min. distance" box with a value larger than zero.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

Resolution=str2num(char(app.T5EFT8.Value));
if ~(size(Resolution,1)==1) || ~(size(Resolution,2)==1) || Resolution<=0 
    app.T5L1.Text={'Please fill the "Step size" box with a value larger than zero.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

Rmax=str2num(char(app.T5EFT7.Value));
if ~(size(Rmax,1)==1) || ~(size(Rmax,2)==1) || Rmax<=0 
    app.T5L1.Text={'Please fill the "Max. distance" box with a value larger than zero.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

if Rmin>=Rmax
    app.T5L1.Text={'The "Min. distance" value must be smaller than the "Max. distance" value.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif Resolution>=Rmax
    app.T5L1.Text={'The "step size" value must be smaller than the "Max. distance" value.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end



PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

fid = fopen([PosFileName '/4_FinalResults/' PosFileName '_' NameOfElementOfInterest '_FinalCorrectionList.txt']);
out=fgetl(fid); %Line 1
LengthThreshold=str2num(fgetl(fid)); %Line 2
out=fgetl(fid); %Line 3
dID=str2num(fgetl(fid)); %Line 4
out=fgetl(fid); %Line 5
cID=str2num(fgetl(fid)); %Line 6
out=fgetl(fid); %Line 7
oID=str2num(fgetl(fid)); %Line 8
fclose(fid);

Skeleton=app.Skeleton;
if strcmp(char(app.T5EFT10.Value),'allDislocations')
    RDFlist=dID;
    for i=1:size(Skeleton,1)
        if (Skeleton{i,1}.LengthModified)>=LengthThreshold
            RDFlist=[RDFlist,i];
        end
    end
    disLogic=true;
    clusLogic=false;
    otherLogic=false;
elseif strcmp(char(app.T5EFT10.Value),'allClusters')
    RDFlist=cID;
    for i=1:size(Skeleton,1)
        if (Skeleton{i,1}.LengthModified)<LengthThreshold
            RDFlist=[RDFlist,i];
        end
    end
    disLogic=false;
    clusLogic=true;
    otherLogic=false;
else
    [FlagRDFlist,MessageRDFList]=CheckRDFlistError(app);
    if FlagRDFlist
        app.T5L1.Text=MessageRDFList;
        app.T5Lamp1.Color='r';pause(0.001)
        return
    end  
    RDFlist=str2num(char(app.T5EFT10.Value));
    if size(RDFlist,2)==0
        app.T5L1.Text={'Either you did not write any skeleton ID for the analysis';'or';'you did not write allDsilocations or allClusters correctly.'};
        app.T5Lamp1.Color='r';pause(0.001)
        return
    end
    disLogic=false;
    clusLogic=false;
    otherLogic=false;
    for i=1:size(RDFlist,2)
        id=RDFlist(1,i);
        if ismember(id,dID)
            disLogic=true;
        elseif ismember(id,cID)
            clusLogic=true;
        elseif ismember(id,oID)
            otherLogic=true;
        elseif (Skeleton{id,1}.LengthModified)>=LengthThreshold
            disLogic=true;
        else
            clusLogic=true;
        end
    end
end

if otherLogic
    app.T5L1.Text={'We cannot do the analysis for the objects considered as "others".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif disLogic && clusLogic
    app.T5L1.Text={'All the selected objects must be either dislocations or clusters.';'We cannot do the analysis for the mixed condition.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

hold(app.T5F6,'on')
OrigPoints=cell(size(RDFlist,2),1);
for j=1:size(RDFlist,2)
    id=RDFlist(1,j);
    points=Skeleton{id, 1}.SkeletonPointsDN;
    color=Skeleton{id,1}.color;
    plot3(app.T5F6,points(:,1),points(:,2),points(:,3),'.','MarkerSize',8,'MarkerEdgeColor',color)
    OrigPoints{j,1}=Skeleton{id,1}.OrigPointsDN;
end
OrigPoints=cell2mat(OrigPoints);

plot3(app.T5F6,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',3,'MarkerEdgeColor',[0 0 0])
hold(app.T5F6,'off')
view(app.T5F6,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))

xlim(app.T5F6,[min(OrigPoints(:,1))-2.5 max(OrigPoints(:,1))+2.5])
ylim(app.T5F6,[min(OrigPoints(:,2))-2.5 max(OrigPoints(:,2))+2.5])
zlim(app.T5F6,[min(OrigPoints(:,3))-2.5 max(OrigPoints(:,3))+2.5])

if disLogic
    if size(RDFlist,2)>1
        title(app.T5F6,{'The composition analysis'; 'was done for the plotted dislocations'})
    else
        title(app.T5F6,{'The composition analysis'; 'was done for the plotted dislocation'})
    end
elseif clusLogic
    if size(RDFlist,2)>1
        title(app.T5F6,{'The composition analysis'; 'was done for the plotted clusters'})
    else
        title(app.T5F6,{'The composition analysis'; 'was done for the plotted cluster'})
    end    
end
app.T5F6.Visible=true;
pbaspect(app.T5F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
axis(app.T5F6,'off')

oA=app.OtherAtoms;
iA=app.Interest;

if disLogic
    MinDistSave=[];
    for j=1:size(RDFlist,2)
        ID=RDFlist(1,j);
        pOri=Skeleton{ID,1}.OrigPointsDN;
        pSkel=Skeleton{ID,1}.SkeletonPointsDN;
        MinDist=(min(pdist2(pOri,pSkel)))';
        MinDistSave=[MinDistSave;MinDist];
    end
    boxplot(app.T5F9,MinDistSave, 'orientation', 'horizontal');
    app.T5F9.YColor='none';
    xlabel(app.T5F9,{'Distribution of the shortest distance'; 'between atoms and their skeleton (nm)'})
    app.T5F9.FontWeight='bold';
    app.T5F9.FontSize=11;
    app.T5F9.Visible=true;
    
    pSkelTemp=cell(size(RDFlist,2),1);
    for j=1:size(RDFlist,2)
        ID=RDFlist(1,j);
        pSkelTemp{j,1}=Skeleton{ID,1}.SkeletonPointsDN;
    end
    [~,LineSkel]=cellfun(@(P) DetermineMinimumConnectivityLength(P),pSkelTemp,'UniformOutput', false);
    Counter=0;
    if size(RDFlist,2)>1
        app.T5L1.Text={'Start doing the composition analysis for the selected dislocations.';'Please wait.'};pause(0.001)
    else
        app.T5L1.Text={'Start doing the composition analysis for the selected dislocation.';'Please wait.'};pause(0.001)
    end
    for r=Rmin:Resolution:Rmax
        outoA=cell(size(LineSkel,1),1);
        outiA=cell(size(LineSkel,1),1);
        parfor i=1:size(LineSkel,1)
            temp=LineSkel{i,1};
            oARed=Minimizer(oA,temp,r);
            KDToARed=KDTreeSearcher(oARed);
            po=num2cell(temp(:,1:3),2);
            pf=num2cell(temp(:,4:6),2);
            outoA{i,1}=cellfun(@(P1,P2) PointsInsideCylinder(P1,P2,oARed,r,KDToARed),po,pf,'UniformOutput', false);
            
            iARed=Minimizer(iA,temp,r);
            KDTiARed=KDTreeSearcher(iARed);
            outiA{i,1}=cellfun(@(P1,P2) PointsInsideCylinder(P1,P2,iARed,r,KDTiARed),po,pf,'UniformOutput', false);
        end
        outoA=cell2mat(cellfun(@(x) cell2mat(x),outoA,'un',0));
        outoA=unique(outoA,'rows');
        SIZEoutoA=size(outoA,1);
        
        outiA=cell2mat(cellfun(@(x) cell2mat(x),outiA,'un',0));
        outiA=unique(outiA,'rows');
        SIZEoutiA=size(outiA,1);
        
        Counter=Counter+1;
        Concentration(Counter,1:4)=[r 100*(SIZEoutiA/(SIZEoutiA+SIZEoutoA)) SIZEoutiA SIZEoutoA];%DislocationCoreRadius Concentration NumberOfAtomsOfInterest NumberOfOtherAtoms
        
        if size(RDFlist,2)>1
           T='Composition analysis for the selected dislocations is in progress.';
        else
           T='Composition analysis for the selected dislocation is in progress.'; 
        end
        app.T5L1.Text={['Done with r=' num2str(r) ' (nm)'];T;'Please wait.'};pause(0.001)
    end
    
    plot(app.T5F10,Concentration(:,1),Concentration(:,2),'k--',Concentration(:,1),Concentration(:,2),'b.','MarkerSize',19,'LineWidth',1.3)
    ylim(app.T5F10,[0 1+floor(max(Concentration(:,2)))])
    xlim(app.T5F10,[(min(Concentration(:,1)))-0.1 (max(Concentration(:,1)))+0.1])
    app.T5F10.XTick=[Rmin:Resolution:Rmax];
    
    ylabel(app.T5F10,'Concentration (at%)','fontweight','bold','fontsize',11)
    xlabel(app.T5F10,'Distance from the dislocation skeleton (nm)','fontweight','bold','fontsize',11)
    app.T5F10.FontWeight='bold';
    app.T5F10.Visible=true;
    
    fid1 = fopen(['Fig7&8_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForDislocations.txt'],'wt');
    fprintf(fid1, '%s\n', 'ID of skeletons to consider for the composition analysis:');
    for i=1:size(RDFlist,2)
        if i<size(RDFlist,2)
            fprintf(fid1, '%i\t', RDFlist(1,i));
        else
            fprintf(fid1, '%i\n', RDFlist(1,i));
        end
    end
    fprintf(fid1, '%s\n', 'DislocationCoreRadius(nm) Concentration(%) NumberOfAtomsOfInterest NumberOfOtherAtoms');
    for i=1:size(Concentration,1)
        fprintf(fid1, '%17.5f\t %15.5f\t %15i\t %17i\n', Concentration(i,1:4));
    end
    %{
    fprintf(fid1, '%s\n', 'Distribution of the shortest distance between atoms and their skeleton (nm):');
    fprintf(fid1, '%s\n', '   Min         25%         50%         75%         Max');
    MinDistSave
    yy = quantile(MinDistSave,[0 0.25 0.50 0.75 1]);
    fprintf(fid1, '%7.2f\t %10.2f\t %10.2f\t %10.2f\t %10.2f\n', yy);
    %}
    fclose(fid1);
    movefile(['Fig7&8_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForDislocations.txt'],[PosFileName '/4_FinalResults/'])
    
    appDesignerFigSaver(app.T5F9,['Fig7_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForDislocations_DistanceFromSkeletonBoxplot.tiff'],[app.T5F9.Position])
    movefile(['Fig7_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForDislocations_DistanceFromSkeletonBoxplot.tiff'],[PosFileName,'/4_FinalResults'])
    
    appDesignerFigSaver(app.T5F10,['Fig8_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForDislocations_CompositionGradient.tiff'],[app.T5F9.Position])
    movefile(['Fig8_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForDislocations_CompositionGradient.tiff'],[PosFileName,'/4_FinalResults'])
    
    if size(RDFlist,2)>1
        T='Done with the chemical analysis of the selected dislocations.';
    else
        T='Done with the chemical analysis of the selected dislocation.';
    end
    app.T5L1.Text={T;'The results are in the';[PosFileName,'/4_FinalResults' ' folder.']};
    app.T5Lamp1.Color='g';pause(0.001)
end

if clusLogic
    RDFlistAll=cID;
    for i=1:size(Skeleton,1)
        if (Skeleton{i,1}.LengthModified)<LengthThreshold
            RDFlistAll=[RDFlistAll,i];
        end
    end
    
    AllClusCen=[];
    for i=1:size(RDFlistAll,2)
        ID=RDFlistAll(1,i);
        if ~ismember(ID,RDFlist)
            AllClusCen=[AllClusCen;mean(Skeleton{ID,1}.OrigPointsDN)];
        end
    end
    
    ClusterCenters(1:size(RDFlist,2),1:3)=0;
    app.T5L1.Text={'Finding the cluster centers.';'Please wait.'};pause(0.001)
    for j=1:size(RDFlist,2)
        ID=RDFlist(1,j);
        ClusterCenters(j,:)=mean(Skeleton{ID,1}.OrigPointsDN);
    end
    DSaveExist=false;
    if size(AllClusCen,1)>0%In the case of allClusters, it is does not make sense to do distance calculations
        MdlAllcc=KDTreeSearcher(AllClusCen);
        DSave=[];DSaveExist=true;
        for i=1:size(ClusterCenters,1)
            [~,D] = knnsearch(MdlAllcc,ClusterCenters(i,:));
            DSave=[DSave;D];
        end
        
        nbins=[(floor(min(DSave))):(ceil(max(DSave)))];
        histogram(DSave,nbins,'Parent',app.T5F9)
        if size(DSave,1)>1
            xlabel(app.T5F9,{'Distribution of the shortest distance between the center'; 'of the selected clusters and the other clusters (nm)'})
        else
            xlabel(app.T5F9,{'Distribution of the shortest distance between the center'; 'of the selected cluster and the other clusters (nm)'})
        end
        ylabel(app.T5F9,'Number of clusters')
        app.T5F9.FontWeight='bold';
        app.T5F9.FontSize=11;
        app.T5F9.Visible=true;
    end
    
    app.T5L1.Text={'Constructing the Kd-tree objects.';'Please wait.'};pause(0.001)
    Mdli=KDTreeSearcher(iA);
    Mdlo=KDTreeSearcher(oA);
    app.T5L1.Text={'Done with constructing the Kd-tree objects.';'Please wait.'};pause(0.001)
    Concentration=[];
    
    for r=Rmin:Resolution:Rmax
        NumInterest=0;
        NumOthers=0;
        for i=1:size(ClusterCenters,1)
            Idtemp=rangesearch(Mdli,ClusterCenters(i,:),r);
            NumInterest=NumInterest+(size(Idtemp{1},2));
            Idtemp=rangesearch(Mdlo,ClusterCenters(i,:),r);
            NumOthers=NumOthers+(size(Idtemp{1},2));
        end
        Concentration=[Concentration;r 100*NumInterest/(NumInterest+NumOthers) NumInterest NumOthers];%DistanceFromClusterCenter(nm) Concentration NumberOfAtomsOfInterest NumberOfOtherAtoms
        if size(ClusterCenters,1)>1
            T='Chemical analysis is in progress for the selected clusters.';
        else
            T='Chemical analysis is in progress for the selected cluster.';
        end
        app.T5L1.Text={['Done with r=' num2str(r) ' (nm)'];T;'Please wait.'};pause(0.001)
    end
    
    plot(app.T5F10,Concentration(:,1),Concentration(:,2),'k--',Concentration(:,1),Concentration(:,2),'b.','MarkerSize',19,'LineWidth',1.3)
    ylim(app.T5F10,[0 1+floor(max(Concentration(:,2)))])
    xlim(app.T5F10,[(min(Concentration(:,1)))-0.1 (max(Concentration(:,1)))+0.1])
    app.T5F10.XTick=[Rmin:Resolution:Rmax];
    
    ylabel(app.T5F10,'Concentration (at%)','fontweight','bold','fontsize',11)
    xlabel(app.T5F10,'Distance from the cluster center (nm)','fontweight','bold','fontsize',11)
    app.T5F10.FontWeight='bold';
    app.T5F10.Visible=true;
    
    fid1 = fopen(['Fig7&8_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForClusters.txt'],'wt');
    fprintf(fid1, '%s\n', 'ID of skeletons to consider for the composition analysis:');
    for i=1:size(RDFlist,2)
        if i<size(RDFlist,2)
            fprintf(fid1, '%i\t', RDFlist(1,i));
        else
            fprintf(fid1, '%i\n', RDFlist(1,i));
        end
    end
    fprintf(fid1, '%s\n', 'DistanceFromClusterCenter(nm) Concentration(%) NumberOfAtomsOfInterest NumberOfOtherAtoms');
    for i=1:size(Concentration,1)
        fprintf(fid1, '%17.5f\t %19.5f\t %13i\t %19i\n', Concentration(i,1:4));
    end
    if DSaveExist
        fprintf(fid1, '%s\n', 'Distances to the nearest cluster center for the selected cluster centers are (not in order with the skeleton IDs.):');
        fprintf(fid1, '%s\n', 'To avoid the effect of the other clusters on the cluster interest, the minimum value of the below line must be larger than the maximum distance selected for the analysis');
        for i=1:size(DSave,1)
            fprintf(fid1, '%10.5f\t',DSave(i,1));
        end
    end
    fclose(fid1);
    movefile(['Fig7&8_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForClusters.txt'],[PosFileName '/4_FinalResults/'])
    
    appDesignerFigSaver(app.T5F9,['Fig7_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForClusters_DistanceBetweenClusterCentersHistogram.tiff'],[app.T5F9.Position])
    movefile(['Fig7_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForClusters_DistanceBetweenClusterCentersHistogram.tiff'],[PosFileName,'/4_FinalResults'])
    
    appDesignerFigSaver(app.T5F10,['Fig8_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForClusters_CompositionGradient.tiff'],[app.T5F9.Position])
    movefile(['Fig8_' PosFileName '_' NameOfElementOfInterest '_Concentration_ForClusters_CompositionGradient.tiff'],[PosFileName,'/4_FinalResults'])
   
    if DSaveExist
        if min(DSave)>Rmax
            if size(ClusterCenters,1)>1
                app.T5L1.Text={'Done with the composition analysis for the selected clusters.';'The results are in the ';[PosFileName,'/4_FinalResults' ' folder']};
                app.T5Lamp1.Color='g';pause(0.001)
            else
                app.T5L1.Text={'Done with the composition analysis for the selected cluster.';'The results are in the ';[PosFileName,'/4_FinalResults' ' folder']};
                app.T5Lamp1.Color='g';pause(0.001)
            end
        else
            app.T5L1.Text={'Done!';'However, it maybe good to repeat the analysis by setting the maximum distance';'smaller than the minimum value you see in the histogram plot.';'The results are in the ';[PosFileName,'/4_FinalResults' ' folder']};
            app.T5Lamp1.Color=[1,0.549,0];pause(0.001)
        end
    else
        if size(ClusterCenters,1)>1
            app.T5L1.Text={'Done with the composition analysis for the selected clusters.';'The results are in the ';[PosFileName,'/4_FinalResults' ' folder']};
            app.T5Lamp1.Color='g';pause(0.001)
        else
            app.T5L1.Text={'Done with the composition analysis for the selected cluster.';'The results are in the ';[PosFileName,'/4_FinalResults' ' folder']};
            app.T5Lamp1.Color='g';pause(0.001)
        end
    end
end
drawnow
clc 
end