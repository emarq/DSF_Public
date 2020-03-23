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
function [coordinateSelected, minIdx] = showZValueFcnT3F2(hObj, event,app,Mdl,X)

app.T3L1.Text={'Start searching for the dense object','Please wait'};
app.T3Lamp1.Color='y';pause(0.001)

hdb=app.hdb;
Y = event.IntersectionPoint;
[i,~] = knnsearch(Mdl,Y);
id=X(i,4);
 
points=hdb(id).atomPositions;
color=hdb(id).color;

plot3(app.T3F3,points(:,1),points(:,2),points(:,3),'.','MarkerSize',8,'MarkerEdgeColor',color)
view(app.T3F3,str2num(char(app.T1EFT5.Value)),str2num(char(app.T1EFT6.Value)))
xlim(app.T3F3,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T3F3,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T3F3,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
   
xlabel(app.T3F3,'X (nm)')
ylabel(app.T3F3,'Y (nm)')
zlabel(app.T3F3,'Z (nm)')
TITLE=(['Selected dense object ID is ' num2str(id)]);
    
title(app.T3F3,TITLE)
axis(app.T3F3,'off')
pbaspect(app.T3F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);

boxplot(app.T3F4,hdb(id).probabilities, 'orientation', 'horizontal');
app.T3F4.YColor='none';
xlabel(app.T3F4,{'Distribution of probability for each'; ['atom to be a memer of object ' num2str(id)]})
app.T3F4.FontWeight='bold';
app.T3F4.FontSize=12;
app.T3F4.Visible=true;
drawnow

app.T3L1.Text={['The dense object ID is ' num2str(id) '.'],['The persistence score (stability) is ' num2str(hdb(id).persistence) '.'],['The dense object has ' num2str(size(points,1)) ' atoms.']};
app.T3Lamp1.Color='g';pause(0.001)

end 


