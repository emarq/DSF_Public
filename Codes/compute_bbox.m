%Defining a box surrounding the point cloud
%pts represents points
function [bbox, diameter] = compute_bbox(pts)
bbox = [min(pts(:,1)), min(pts(:,2)), min(pts(:,3)), max(pts(:,1)), max(pts(:,2)), max(pts(:,3))];
rs = bbox(4:6)-bbox(1:3);
diameter = sqrt(dot(rs,rs));
end