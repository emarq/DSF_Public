%  FIND NEAREST (X,Y,Z) COORDINATE TO MOUSE CLICK
% Inputs:
%  hObj (unused) the axes
%  event: info about mouse click
%app
%Mdl is the kd-tree model
%X represents the points
% OUTPUT
%  coordinateSelected: the (x,y,z) coordinate you selected
%  minIDx: The index of your inputs that match coordinateSelected. 
function [coordinateSelected, minIdx] = showZValueFcnT2F4(hObj, event,app,Mdl,X)

app.T2L1.Text={'Start searching for the dense object','Please wait'};
app.T2Lamp1.Color='y';pause(0.001)

hdbscanSelByPersisAndProb=app.hdbscanSelByPersisAndProb;
Y = event.IntersectionPoint;
[i,~] = knnsearch(Mdl,Y);
id=X(i,4);
 
points=hdbscanSelByPersisAndProb(id).atomPositions;
color=hdbscanSelByPersisAndProb(id).color;

plot3(app.T2F6,points(:,1),points(:,2),points(:,3),'.','MarkerSize',8,'MarkerEdgeColor',color)
view(app.T2F6,str2num(char(app.T1EFT5.Value)),str2num(char(app.T1EFT6.Value)))
xlim(app.T2F6,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T2F6,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T2F6,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
   
xlabel(app.T2F6,'X (nm)')
ylabel(app.T2F6,'Y (nm)')
zlabel(app.T2F6,'Z (nm)')
TITLE=(['Selected dense object ID is ' num2str(id)]);
    
title(app.T2F6,TITLE)
axis(app.T2F6,'off')
pbaspect(app.T2F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
drawnow

app.T2L1.Text={['The dense object ID is ' num2str(id) '.'],['The persistence score (stability) is ' num2str(hdbscanSelByPersisAndProb(id).persistence) '.'],['The dense object has ' num2str(size(points,1)) ' atoms.']};
app.T2Lamp1.Color='g';pause(0.001)

end 


