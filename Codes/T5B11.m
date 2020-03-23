%Tab 5, calculate the angles between two dislocation loops
function T5B11(app)

app.T5L1.Text={'Please wait'};
app.T5Lamp1.Color='y';pause(0.001)


dID=str2num(char(app.T5EFT14.Value));
if isempty(dID) && ~(isempty(app.T5EFT14.Value))
    app.T5L1.Text={'"Dislocation loop ID values" box is not in the correct format.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif isempty(dID)
    app.T5L1.Text={'"Dislocation loop ID values" box is not filled.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif ~(size(dID,1)==1) || ~(size(dID,2)==2)
    app.T5L1.Text={'"Dislocation loop ID values" box is not in the correct format.';'There must be only only two dislocation loop values separated by ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end



PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);
DisData=load([PosFileName,'/4_FinalResults/' PosFileName '_' NameOfElementOfInterest '_FinalResults.mat']);
DisData=DisData.Dislocations;
if isempty(DisData)
    app.T5L1.Text={'We cannot do the analysis because there is no dislocation in this atom probe dataset.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
else
    IDsvaer(1:size(DisData,1),1)=0;
    for i=1:size(DisData,1)
        IDsvaer(i,1)=DisData{i,1}.SkeletonID;
    end
end


if ~ismember(dID(1,1),IDsvaer)
    app.T5L1.Text={['There is no dislocation with the ID value of ' num2str(dID(1,1)) '.'];'Please use "Get skeleton ID" button to get the correct ID value and';...
                    'then fix the problem of "Dislocation loop ID values" box.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return      
elseif ~ismember(dID(1,2),IDsvaer)
    app.T5L1.Text={['There is no dislocation with the ID value of ' num2str(dID(1,2)) '.'];'Please use "Get skeleton ID" button to get the correct ID value and';...
        'then fix the problem of "Dislocation loop ID values" box.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end


for i=1:size(DisData,1)
    if dID(1,1)==DisData{i,1}.SkeletonID
        pointsOne=DisData{i,1}.OrigPointsDN;%I need to make sure whether I need to change z coordinate to -z or not
        ColorOne=DisData{i,1}.color;
        SkelPointOne=DisData{i,1}.SkeletonPointsDN;
        ptCloudOne=pointCloud([pointsOne(:,1),pointsOne(:,2),pointsOne(:,3)]); 
        PnormalOne=mean(pcnormals(ptCloudOne,size(pointsOne,1)));
        if PnormalOne(1,3)<0 %It means the normal direction to the point cloud is not oriented toward the north. I do not know for now how it affects the north/south pole figure (addition of 180 degree)
            PnormalOne=-PnormalOne;
        end
        break
    end
end

cla(app.T5F6,'reset')
plot3(app.T5F6,SkelPointOne(:,1),SkelPointOne(:,2),SkelPointOne(:,3),'.','MarkerSize',8,'MarkerEdgeColor',ColorOne)
hold(app.T5F6,'on')
plot3(app.T5F6,pointsOne(:,1),pointsOne(:,2),pointsOne(:,3),'.','MarkerSize',3,'MarkerEdgeColor',[0 0 0])
hold(app.T5F6,'on')
for i=1:size(DisData,1)
    if dID(1,2)==DisData{i,1}.SkeletonID
        pointsTwo=DisData{i,1}.OrigPointsDN;%I need to make sure whether I need to change z coordinate to -z or not
        ColorTwo=DisData{i,1}.color;
        SkelPointTwo=DisData{i,1}.SkeletonPointsDN;
        ptCloudTwo=pointCloud([pointsTwo(:,1),pointsTwo(:,2),pointsTwo(:,3)]); 
        PnormalTwo=mean(pcnormals(ptCloudTwo,size(pointsTwo,1)));
        if PnormalTwo(1,3)<0 %It means the normal direction to the point cloud is not oriented toward the north. I do not know for now how it affects the north/south pole figure (addition of 180 degree)
            PnormalTwo=-PnormalTwo;
        end
        break
    end
end
plot3(app.T5F6,SkelPointTwo(:,1),SkelPointTwo(:,2),SkelPointTwo(:,3),'.','MarkerSize',8,'MarkerEdgeColor',ColorTwo)
hold(app.T5F6,'on')
plot3(app.T5F6,pointsTwo(:,1),pointsTwo(:,2),pointsTwo(:,3),'.','MarkerSize',3,'MarkerEdgeColor',[0 0 0])

hold(app.T5F6,'off')
view(app.T5F6,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))


xlim(app.T5F6,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T5F6,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T5F6,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
   
xlabel(app.T5F6,'X (nm)')
ylabel(app.T5F6,'Y (nm)')
zlabel(app.T5F6,'Z (nm)')
    
title(app.T5F6,['Selected Skeleton IDs are ' num2str(dID(1,1)) ' and ' num2str(dID(1,2))])
axis(app.T5F6,'off')
pbaspect(app.T5F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
drawnow

ThetaInDegrees1 = atan2d(norm(cross(PnormalOne,PnormalTwo)),dot(PnormalOne,PnormalTwo));
ThetaInDegrees2 = atan2d(norm(cross(-PnormalOne,PnormalTwo)),dot(-PnormalOne,PnormalTwo));

app.T5L1.Text={'Done!';'';['If we assume the normal direction to both planes are "up", the angle between the two dislocations is ' num2str(ThetaInDegrees1) ' (' char(176) ').'];'';...
                         ['If we assume the normal direction to the plane of dislocation #' num2str(dID(1,1)) ' is "down" and'];...
                         ['the normal direction to the plane of dislocation #' num2str(dID(1,2)) ' is "up",'];...
                         ['the angle between the planes of the two dislocations is ' num2str(ThetaInDegrees2) ' (' char(176) ').']};
app.T5Lamp1.Color='g';pause(0.001)

end