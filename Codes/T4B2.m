%Tab 4, Extract skeletons pushbuttons
function T4B2(app)

cla(app.T4F12,'reset')
cla(app.T4F13,'reset')
cla(app.T4F14,'reset')
app.T4F12.Visible=false;
app.T4F13.Visible=false;
app.T4F14.Visible=false;
app.T4CB1.Value=false;
app.T4L18.Visible=false;

app.T4L1.Text='Start skeleton extraction.';
app.T4Lamp1.Color='y';pause(0.001)
hdb=app.hdb;
PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

Skeleton=cell(size(hdb,2),1);
ForPlot=cell(size(hdb,2),1);
RawData=cell(size(hdb,2),1);

Param=app.T4T1.Data.Var2;

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
    app.Message=[];
    WriteSkeletonMessages(['Doing skeleton analysis on the dense object #' num2str(i) ' (' num2str(round(100*(i-1)/size(hdb,2))) '% progress).'],app)
    Skeleton{i,1}=SkeletonAnalysis(hdb(i).points,hdb(i).color,app,Param,i);%points,color,app,userParameters,SkeletonID
    
    color=Skeleton{i,1}.color;
    SkeletonPointsDN=Skeleton{i, 1}.SkeletonPointsDN;
    ForPlot{i,1}=[SkeletonPointsDN ones(size(SkeletonPointsDN,1),1).*color];
    RawData{i,1}=hdb(i).points;
end
app.Skeleton=Skeleton;
%savefast('Skeleton.mat','Skeleton')
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

savefast([PosFileName,'/3_Skeleton/' PosFileName '_' NameOfElementOfInterest '_Skeleton.mat'],'Skeleton');

FCN={'Skeleton ID';...
    'Min number of neighbors';...
    'Max number of neighbors';...
    'Lplcn const. wt. prfctr1';...
    'Lplcn const. wt. prfctr2';...
    'WH prefacotr';...
    'Laplacian Cnstrnt. scale';...
    'Max Laplacian cnstrnt wt.';...
    'Max position cnstrnt wt.';...
    'Max num. of cntrctn iter.';...
    'Cntrctn. trmntn. cndtn.';...
    'Radius prefactor';...
    'Small-branch lng. thrshld'};
T1=table(FCN);
T2=array2table(repmat([-1;Param],1,size(hdb,2)));
app.T4T2.Data=[T1 T2];
app.T4T2.ColumnEditable=[false true(1,size(hdb,2))];
app.T4T2.RowName = {0;1;2;3;4;5;6;7;8;9;10;11;12};
app.T4T2.ColumnName=cellstr(["Parameter";strcat(repmat("C",size(hdb,2),1), num2str((1:size(hdb,2))'))]);

app.T4L1.Text={'Done with the Skeleton analysis.';...
    'If you think all the skeletons were extracted properly, please click on the "Finalizing the results" button.';...
    'However, if you think the parameters used for extracting the skeletons did not work well for a couple';...
    'of dense objects, you can now tune the parameters for each of these objects separately.';...
    'For instance, if you think the extracted skeletons of objects 10 and 20 are not good,';...
    'you must update Table 2. Each column of Table 2 contains the object ID and the parameters';...
    'used for extracting the skeleton for that object.';
    'Under c1 column, change the Skeleton ID from -1 to 10 and update the other parameters.';...
    'Under c2 column, change the Skeleton ID from -1 to 20 and update the other parameters.';...
    'Leave other columns as they are and click on the "Finalizing the results" button.';
    };
app.T4T2.Visible=true;
app.T4CB1.Value=false;
app.T4L18.Visible=false;
app.T4Lamp1.Color='g';pause(0.001)

end