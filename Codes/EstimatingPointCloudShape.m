%Estimating the point cloud shape
%p represents points in the point cloud
%app
function EstimatedShape=EstimatingPointCloudShape(p,app)

[~,~,~,~,explained,~] = pca(p);

DT = delaunayTriangulation(p);

[k1,v1]=boundary(DT.Points,1);

trisurf(k1,p(:,1),p(:,2),p(:,3),'Parent',app.T4F2,'Facecolor','cyan','FaceAlpha',0.3)
axis(app.T4F2,'off');
axis(app.T4F2,'equal');

%axis(app.T4F2,'vis3d')
title(app.T4F2,['Smallest volume is ' num2str(round(v1,1)) ' (nm^3)'])
app.T4F2.FontSize=11;
app.T4F2.FontWeight='bold';
app.T4F2.TitleFontSizeMultiplier = 1.65;
app.T4F2.Visible=true;
axis(app.T4F2,'off')
drawnow;
%app.T4F2.BackgroundColor='w';

[k0,v0]=boundary(DT.Points,0);

trisurf(k0,p(:,1),p(:,2),p(:,3),'Parent',app.T4F3,'Facecolor','cyan','FaceAlpha',0.3)
axis(app.T4F3,'off');
axis(app.T4F3,'equal')
%set(app.T4F3,'color','white');
%axis(app.T4F3,'vis3d')
title(app.T4F3,['Largest volume is ' num2str(round(v0,1)) ' (nm^3)'])
app.T4F3.FontSize=11;
app.T4F3.FontWeight='bold';
app.T4F3.TitleFontSizeMultiplier = 1.65;
app.T4F3.Visible=true;
axis(app.T4F3,'off')
drawnow;
CompactIndex=v1/v0;

WriteSkeletonMessages({'   ';['The total variance explained by the three principal components are ' num2str(round(explained(1,1))) ', ' num2str(round(explained(2,1))) ' and ' num2str(round(explained(3,1))) ' (%) and the ratio between the']},app)
WriteSkeletonMessages(['volumes of the tightest single-region boundary around the points and the convex hull of the points is ' num2str(CompactIndex) '.'],app)

if explained(2,1)<20 && explained(3,1)<7 %I need to make these two as user variables
    T1='==> The geometry of the dense object is "dislocation line".';
    EstimatedShape='Line';
else
    if explained(3,1)>7 && CompactIndex>0.4
        T1='==> The geometry of the dense object is "Bulk".';
        EstimatedShape='Aggregate';
        
    elseif explained(3,1)>7 && CompactIndex<0.4
        T1='==> The geometry of the dense object is "3D shell".';
        EstimatedShape='3Dshell';
    elseif explained(3,1)<7 && CompactIndex>0.3%0.4
        T1='==> The geometry of the dense object is "disk".';%Maybe I need to think more about disk case later
        EstimatedShape='Disk';
    else
        T1='==> The geometry of the dense object is "ring".';
        EstimatedShape='Ring';
    end
end

WriteSkeletonMessages({T1;'   '},app)
end