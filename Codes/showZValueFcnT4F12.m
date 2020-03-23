%  FIND NEAREST (X,Y,Z) COORDINATE TO MOUSE CLICK
% Inputs:
%  hObj (unused) the axes
%  event: info about mouse click
% OUTPUT
%  coordinateSelected: the (x,y,z) coordinate you selected
%  minIDx: The index of your inputs that match coordinateSelected. 
function [coordinateSelected, minIdx] = showZValueFcnT4F12(hObj, event,app,Mdl,X)

app.T4L1.Text={'Start searching for the skeleton','Please wait'};
app.T4Lamp1.Color='y';pause(0.001)

Y = event.IntersectionPoint;
[i,~] = knnsearch(Mdl,Y);
id=X(i,4);

Skeleton=app.Skeleton; 
points=Skeleton{id,1}.SkeletonPointsDN;
color=Skeleton{id,1}.color;

%cla(app.T4F14,'reset')
plot3(app.T4F14,points(:,1),points(:,2),points(:,3),'.','MarkerSize',8,'MarkerEdgeColor',color)
hold(app.T4F14,'on')

hdb=app.hdb;
OrigPoints=hdb(id).points;
plot3(app.T4F14,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',3,'MarkerEdgeColor',[0 0 0])
hold(app.T4F14,'off')
view(app.T4F14,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))

xlim(app.T4F14,[min(OrigPoints(:,1))-2.5 max(OrigPoints(:,1))+2.5])
ylim(app.T4F14,[min(OrigPoints(:,2))-2.5 max(OrigPoints(:,2))+2.5])
zlim(app.T4F14,[min(OrigPoints(:,3))-2.5 max(OrigPoints(:,3))+2.5])

%xlim(app.T4F14,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
%ylim(app.T4F14,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
%zlim(app.T4F14,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
   
%xlabel(app.T4F14,'X (nm)')
%ylabel(app.T4F14,'Y (nm)')
%zlabel(app.T4F14,'Z (nm)')
TITLE=(['Selected Skeleton ID is ' num2str(id)]);
    
title(app.T4F14,TITLE)
axis(app.T4F14,'off')
%pbaspect(app.T3F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
drawnow

app.T4L1.Text={['The skeleton ID is ' num2str(id) '.'];...
               ['Initially calculated skeleton length is ' num2str(round(Skeleton{id,1}.Length,1)) ' (nm).'];...
               ['Final skeleton length after removing small branches is ' num2str(round(Skeleton{id,1}.LengthModified,1)) ' (nm).'];...
               ['The dense object contains ' num2str(Skeleton{id,1}.npts) ' atoms.']};
                
app.T4Lamp1.Color='g';pause(0.001)

end 





