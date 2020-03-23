%Removing small branches
%G is the constructed graph
%nodeTail
%TriplePointID 
%A is P.spls
%LengthThreshold
function RemovedNodes=SmallBranchRemoval(G,nodeTail,TriplePointID,A,LengthThreshold);

LengthSaver(1:size(TriplePointID,1),1)=0;
for i=1:size(TriplePointID,1)
    nodeTriple=TriplePointID(i,1);
    [~,GF] = maxflow(G,nodeTail,nodeTriple);
    GFedges = table2array(GF.Edges);
    NewLength=0;
    for j=1:size(GFedges,1)
        dist=pdist2(A(GFedges(j,1),:),A(GFedges(j,2),:),'euclidean');
        NewLength=NewLength+dist;
    end
    LengthSaver(i,1)=NewLength;
end

[row,~]=find(LengthSaver==min(LengthSaver));

if LengthSaver(row,1)<LengthThreshold
    nodeTriple=TriplePointID(row,1);
    [~,GF] = maxflow(G,nodeTail,nodeTriple);
    GFedges = table2array(GF.Edges);
    Uniq=unique(GFedges(:,1:2));
    RemovedNodes = Uniq(Uniq~=nodeTriple);
else
    RemovedNodes=[];
end

end