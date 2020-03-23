%Denormalizing the point cloud
%A is the normalized points
%c is the center of the box
%s is the scale factor
function  A=Denormalization(A,c,s)

A=A./s;
A=A+repmat(c, size(A,1), 1);

end