%Finding the surface of the point cloud
%X represents the point cloud
%app
function [Vertices,Mesh]=SurfaceFinder(X,app)

shp=alphaShape(X);
rHigh = criticalAlpha(shp,'one-region');%Compute the smallest alpha radius that produces an alpha shape enclosing all of the points and having only one region.

rSel=rHigh+0.4;
shpNew=alphaShape(X,rSel);

[Mesh, Vertices] = boundaryFacets(shpNew);
 
plot(shpNew,'Parent',app.T4F1)

axis(app.T4F1,'equal');
xlim(app.T4F1,[min(X(:,1)) max(X(:,1))])
ylim(app.T4F1,[min(X(:,2)) max(X(:,2))])
zlim(app.T4F1,[min(X(:,3)) max(X(:,3))])

title(app.T4F1,'Meshed point cloud');
xlabel(app.T4F1,'x (nm)');
ylabel(app.T4F1,'y (nm)');
zlabel(app.T4F1,'z (nm)');

app.T4F1.FontSize=11;
app.T4F1.FontWeight='bold';
app.T4F1.TitleFontSizeMultiplier = 1.65;
app.T4F1.LabelFontSizeMultiplier = 1.35;
app.T4F1.Visible=true;
drawnow;
 
end



