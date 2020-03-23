%This function contains all actions for extracting the skeletons
%The inputs are:
%points: point cloud
%color
%app
%Param: 12 parameters used for extracting the skeletons
%Skeleton ID
function output=SkeletonAnalysis(points,color,app,Param,SkeletonID)
cla_Invisible_Tab4_SkeletonFigures(app)
P.color=color;
P.SkeletonID=SkeletonID;

[P.pts,P.faces]=SurfaceFinder(points,app);
P.EstimatedShape=EstimatingPointCloudShape(points,app);
P.SmallBranchLengthThreshold=Param(12,1);
output=Main_Skeleton(P,app,Param);
 
WriteSkeletonMessages('Done with this iteration!',app)

end