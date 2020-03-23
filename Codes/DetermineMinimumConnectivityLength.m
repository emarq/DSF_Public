function [Length,Points]=DetermineMinimumConnectivityLength(A)
    s=[];t=[];
    DG(1:size(A,1),1:size(A,1))=0;
    for i=1:size(A,1)
        for j=1:size(A,1)
            if i>=j
                s=[s,i];
                t=[t,j];
                dist=pdist2(A(i,:),A(j,:),'euclidean');
                DG(i,j)=dist;
            end
        end
    end
    UG=sparse(DG);
    [ST,~] = graphminspantree(UG,'Method','Prim');
    Length=0;
    Points=[];
    for i=1:size(ST,1)
        for j=1:size(ST,2)
            if ST(i,j)>0
                Points=[Points;A(i,:) A(j,:)];
                Length=Length+ST(i,j);
            end
        end
    end
end