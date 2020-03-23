function out=PointsInsideCylinder(p1,p2,qTotal,r,KDTmodel) %q is n*3 random points in space
                                                            %p1 is the point on one side of the cylinder axis
                                                            %p2 is the point on the other side of the cylinder axis
                                                            %r is the radius of the cylinder                                                        
                                                            %KDTmodel is kd-tree model for qTotal points                                                                                                                                                                                                                                                                                        
    distP1P2=pdist([p1;p2]);
    MaxDist=norm([r,distP1P2]);

    idP1=rangesearch(KDTmodel,p1,MaxDist);
    idP1=cell2mat(idP1);
    q=qTotal(idP1,:);

    qp1=q-p1;
    p2p1=p2-p1;
    p2p1Rep=repmat(p2p1,[size(qp1,1),1]);
    qp2=q-p2;

    dot1=(dot(qp1',p2p1Rep'))';
    dot2=(dot(qp2',p2p1Rep'))';
    dot1dot2=dot1.*dot2;

    dot1dot2INDEX=(dot1dot2(:,1)<=0);
    qRed=q(dot1dot2INDEX,1:3);

    qRedp1=qRed-p1;
    p2p1RepRed=repmat(p2p1,[size(qRedp1,1),1]);

    C=cross(qRedp1',p2p1RepRed');
    dist=(vecnorm(C,2,1))'./norm(p2p1);
    di=(dist(:,1)<=r);

    out=qRed(di,1:3);
end