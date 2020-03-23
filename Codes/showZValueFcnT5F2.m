%FIND NEAREST (X,Y,Z) COORDINATE TO MOUSE CLICK
%Inputs:
% hObj (unused) the axes
% event: info about mouse click
%app
%kd-tree model
%X represents the point information
% OUTPUT
%  coordinateSelected: the (x,y,z) coordinate you selected
%  minIDx: The index of your inputs that match coordinateSelected. 
function [coordinateSelected, minIdx] = showZValueFcnT5F2(hObj, event,app,Mdl,X)

app.T5L1.Text={'Start searching for the skeleton','Please wait'};
app.T5Lamp1.Color='y';pause(0.001)

Y = event.IntersectionPoint;
[i,~] = knnsearch(Mdl,Y);
id=X(i,4);

Skeleton=app.Skeleton; 
points=Skeleton{id, 1}.SkeletonPointsDN;
color=Skeleton{id,1}.color;

plot3(app.T5F6,points(:,1),points(:,2),points(:,3),'.','MarkerSize',8,'MarkerEdgeColor',color)
hold(app.T5F6,'on')

OrigPoints=Skeleton{id,1}.OrigPointsDN;
plot3(app.T5F6,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',3,'MarkerEdgeColor',[0 0 0])
hold(app.T5F6,'off')
view(app.T5F6,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))

xlim(app.T5F6,[min(OrigPoints(:,1))-2.5 max(OrigPoints(:,1))+2.5])
ylim(app.T5F6,[min(OrigPoints(:,2))-2.5 max(OrigPoints(:,2))+2.5])
zlim(app.T5F6,[min(OrigPoints(:,3))-2.5 max(OrigPoints(:,3))+2.5])
   
xlabel(app.T5F6,'X (nm)')
ylabel(app.T5F6,'Y (nm)')
zlabel(app.T5F6,'Z (nm)')
    
title(app.T5F6,['Selected Skeleton ID is ' num2str(id)])
axis(app.T5F6,'off')
pbaspect(app.T5F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
drawnow

app.T5L1.Text={['Skeleton ID is ' num2str(id) '.'];...
                ['The initial skeleton length is ' num2str(round(Skeleton{id,1}.Length,1)) ' (nm).'];...
                ['The final skeleton length is ' num2str(round(Skeleton{id,1}.LengthModified,1)) ' (nm).'];...
                ['The object contains ' num2str(Skeleton{id,1}.npts) ' atoms.'];...
				['The estimated object shape is ' Skeleton{id,1}.EstimatedShape '.']};
app.T5Lamp1.Color='g';pause(0.001)

end 


