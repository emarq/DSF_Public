function T4B6(app)

cla(app.T4F12,'reset')
cla(app.T4F13,'reset')
cla(app.T4F14,'reset')
app.T4F12.Visible=false;
app.T4F13.Visible=false;
app.T4F14.Visible=false;
cla_Invisible_Tab4_SkeletonFigures(app)
app.T4CB1.Value=false;
app.T4L18.Visible=false;

app.T4L1.Text='Start applying the corrections for the skeleton extraction.';
app.T4Lamp1.Color='y';pause(0.001)
Skeleton=app.Skeleton;
hdb=app.hdb;

TableTwoData(1:13,1:size(hdb,2))=-1;
for j=1:size(hdb,2)
    temp=eval(['app.T4T2.Data.Var' num2str(j)]);
    TableTwoData(:,j)=temp;
end
TableTwoData=TableTwoData(:,(TableTwoData(1,:)>0));%removing columns with -1 as the header

CorrectionIDs=TableTwoData(1,:);
if (sum(CorrectionIDs>size(hdb,2))>0) || (sum(~(floor(CorrectionIDs)==CorrectionIDs)))>0
    app.T4L1.Text={['Skeleton ID values must be interger values smaller than ' num2str(size(hdb,2)) '.']};
    app.T4Lamp1.Color='r';pause(0.001)
    return
end
AllParams=TableTwoData(2:13,:);

FinalSkeleton=cell(size(hdb,2),1);
ForPlot=cell(size(hdb,2),1);
RawData=cell(size(hdb,2),1);

for i=1:size(hdb,2)
    if app.T4CB1.Value
	  app.T4L18.Visible=true;
	else
	  app.T4L18.Visible=false;
	end
    waitfor(app.T4CB1,'Value',0)
	if app.T4CB1.Value
	  app.T4L18.Visible=true;
	else
	  app.T4L18.Visible=false;
	end
    if ismember(i,CorrectionIDs)
        app.Message=[];
        WriteSkeletonMessages(['Doing skeleton analysis on the dense object #' num2str(i)],app)
        [~,Index]=find(i==CorrectionIDs);
        Param=AllParams(:,Index);
        FinalSkeleton{i,1}=SkeletonAnalysis(hdb(i).points,hdb(i).color,app,Param,i);%points,color,app,userParameters
        color=FinalSkeleton{i,1}.color;
        SkeletonPointsDN=FinalSkeleton{i,1}.SkeletonPointsDN;
        ForPlot{i,1}=[SkeletonPointsDN ones(size(SkeletonPointsDN,1),1).*color];
        RawData{i,1}=hdb(i).points;
    else
        FinalSkeleton{i,1}=Skeleton{i,1};
        color=FinalSkeleton{i,1}.color;
        SkeletonPointsDN=FinalSkeleton{i, 1}.SkeletonPointsDN;
        ForPlot{i,1}=[SkeletonPointsDN ones(size(SkeletonPointsDN,1),1).*color];
        RawData{i,1}=hdb(i).points;
    end
end

ForPlot=cell2mat(ForPlot);

handleT4F12=scatter3(app.T4F12,ForPlot(:,1),ForPlot(:,2),ForPlot(:,3),5.*ones(size(ForPlot,1),1),ForPlot(:,4:6),'filled');
app.handleT4F12=handleT4F12;

view(app.T4F12,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T4F12,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T4F12,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T4F12,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
xlabel(app.T4F12,'X (nm)')
ylabel(app.T4F12,'Y (nm)')
zlabel(app.T4F12,'Z (nm)')
title(app.T4F12,'Skeleton of the dense objects')
axis(app.T4F12,'off')
axis(app.T4F12,'equal')
%pbaspect(app.T4F12,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T4F12.Visible=true;
drawnow

scatter3(app.T4F13,ForPlot(:,1),ForPlot(:,2),ForPlot(:,3),5.*ones(size(ForPlot,1),1),ForPlot(:,4:6),'filled');
hold(app.T4F13,'on')
RawData=cell2mat(RawData);
plot3(app.T4F13,RawData(:,1),RawData(:,2),RawData(:,3),'k.','MarkerSize',3)
view(app.T4F13,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T4F13,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T4F13,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T4F13,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
xlabel(app.T4F13,'X (nm)')
ylabel(app.T4F13,'Y (nm)')
zlabel(app.T4F13,'Z (nm)')
title(app.T4F13,'Dense objects and their skeletons')
axis(app.T4F13,'off')
%pbaspect(app.T4F13,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
axis(app.T4F13,'equal')
app.T4F13.Visible=true;
drawnow

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);
savefast([PosFileName,'/3_Skeleton/' PosFileName '_' NameOfElementOfInterest '_FinalSkeleton.mat'],'FinalSkeleton');

appDesignerFigSaver(app.T4F11,'1_DenseObjects.tiff',[app.T4F11.Position])
movefile('1_DenseObjects.tiff',[PosFileName,'/3_Skeleton'])

appDesignerFigSaver(app.T4F12,'2_Skeletons.tiff',[app.T4F12.Position])
movefile('2_Skeletons.tiff',[PosFileName,'/3_Skeleton'])

appDesignerFigSaver(app.T4F13,'3_DenseObjectsAndSkeletons.tiff',[app.T4F13.Position])
movefile('3_DenseObjectsAndSkeletons.tiff',[PosFileName,'/3_Skeleton'])

app.T4CB1.Value=false;
app.T4L18.Visible=false;

app.T4L1.Text={'Skeleton analysis results were finalized. The results were saved in the';...
              [PosFileName '/3_Skeleton/' PosFileName '_' NameOfElementOfInterest '_FinalSkeleton.mat' ' file.'];...
              'You can go to the next tab if the results are good; otherwise,';...
              'you can adjust the parameters in the second table again and then ';...
              'click on the "Finalizing the results" button.'};
app.T4Lamp1.Color='g';pause(0.001)

end