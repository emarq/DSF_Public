%Tab 3, Prunning pushbutton
function T3B7(app)

cla(app.T3F4,'reset')
app.T3F4.Visible=false;

app.T3Lamp1.Color='y';
app.T3L1.Text='Start doing the analysis!';pause(0.001)

hdb=app.hdb;

id=str2num(char(app.T3EFN3.Value));
if ~(size(id,1)==1 && size(id,2)==1)
    app.T3L1.Text=['Please fill the "Object ID" box with only one integer value smaller than ' num2str(size(hdb,2)+1) '.'];
    app.T3Lamp1.Color='r';pause(0.001)
    return
elseif id<1 || id>size(hdb,2) || ~(floor(id)==id)
    app.T3L1.Text=[num2str(id) ' is not a correct object ID.'];
    app.T3Lamp1.Color='r';pause(0.001)
    return
end

MinClusterSizeHDBSCAN=str2num(char(app.T3EFN4.Value));
if ~(size(MinClusterSizeHDBSCAN,1)==1 && size(MinClusterSizeHDBSCAN,2)==1)
    app.T3L1.Text='Please fill the "MinClusterSize" box with only one integer value.';
    app.T3Lamp1.Color='r';pause(0.001)
    return
elseif MinClusterSizeHDBSCAN<1 || ~(floor(MinClusterSizeHDBSCAN)==MinClusterSizeHDBSCAN)
    app.T3L1.Text='Please fill the "MinClusterSize" box with an integer value.';
    app.T3Lamp1.Color='r';pause(0.001)
    return
end

MinSamplesHDBSCAN=str2num(char(app.T3EFN5.Value));
if ~(size(MinSamplesHDBSCAN,1)==1 && size(MinSamplesHDBSCAN,2)==1)
    app.T3L1.Text='Please fill the "MinSampleSize" box with only one integer value.';
    app.T3Lamp1.Color='r';pause(0.001)
    return
elseif MinSamplesHDBSCAN<1 || ~(floor(MinSamplesHDBSCAN)==MinSamplesHDBSCAN)
    app.T3L1.Text='Please fill the "MinSampleSize" box with an integer value.';
    app.T3Lamp1.Color='r';pause(0.001)
    return
end

hdbscanProbabilityThreshold=str2num(char(app.T3EFT5.Value));
if ~(size(hdbscanProbabilityThreshold,1)==1 && size(hdbscanProbabilityThreshold,2)==1) || hdbscanProbabilityThreshold<0 || hdbscanProbabilityThreshold>1
    app.T3L1.Text='Please fill the "Probability threshold" box with only one value between 0 and 1.';
    app.T3Lamp1.Color='r';pause(0.001)
    return
end

Points=hdb(id).atomPositions;
[hdbNew,noise]=hdbscanAnalysis_OnSelected(Points,MinClusterSizeHDBSCAN,MinSamplesHDBSCAN,hdbscanProbabilityThreshold);
if isempty(hdbNew)
    app.T3L1.Text={'No dense object was found.'; 'Please either change the parameters or avoid pruning this object.'};
    app.T3Lamp1.Color='r';pause(0.001)
   return 
end

Save=cell(size(hdbNew,2),1);
for j=1:size(hdbNew,2)
    x=hdbNew(j).atomPositions;
    Save{j,1}=[x j.*ones(size(x,1),1)];
end

colors=distinguishable_colors(size(hdbNew,2));
Save=cell2mat(Save);
Save(:,4:6)=colors(Save(:,4),1:3);

scatter3(app.T3F3,Save(:,1),Save(:,2),Save(:,3),5.*ones(size(Save,1),1),Save(:,4:6),'filled');

if size(noise,1)>0
    hold(app.T3F3,'on')
    plot3(app.T3F3,noise(:,1),noise(:,2),noise(:,3),'.','color','k','MarkerSize',2)
    hold(app.T3F3,'off')
end

view(app.T3F3,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T3F3,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T3F3,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T3F3,[app.AxisLimits(3,1) app.AxisLimits(3,2)])

xlabel(app.T3F3,'X (nm)')
ylabel(app.T3F3,'Y (nm)')
zlabel(app.T3F3,'Z (nm)')

if size(hdbNew,2)==1
    TITLE=['Dense object ' num2str(id) ' was not pruned'];
else
    TITLE={['Dense object ' num2str(id) ' was pruned']; ['to ' num2words(size(hdbNew,2)) ' dense objects']};
end

title(app.T3F3,TITLE)

pbaspect(app.T3F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T3F3.Visible=true;
%axis(app.T3F3,'off')
drawnow

app.T3L1.Text=TITLE;
app.T3Lamp1.Color='g';pause(0.001)

end