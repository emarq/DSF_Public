%P represetns the point cloud information
%app
function [Length,LengthModified]=PlotFinalConnectivity(P,app)

ptsN=Denormalization(P.pts,P.center,P.scaleFactor); 
scatter3(app.T4F9,ptsN(:,1),ptsN(:,2),ptsN(:,3),15,'.','MarkerEdgeColor', 'b');  
hold(app.T4F9,'on');

A=P.spls;
A(any(isnan(A),2),:)=[];
A=Denormalization(A,P.center,P.scaleFactor); 
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
I=[];J=[];W=[];
for i=1:size(ST,1)
    for j=1:size(ST,2)
        if ST(i,j)>0
            Points=[A(i,:);A(j,:)];
            Length=Length+ST(i,j);
            I=[I i];
            J=[J j];
            W=[W full(ST(i,j))];
            plot3(app.T4F9,Points(:,1),Points(:,2),Points(:,3),'k','LineWidth', 2)
            hold(app.T4F9,'on');
        end
    end
end
plot3(app.T4F9,A(:,1),A(:,2),A(:,3),'r.','MarkerSize',20)
hold(app.T4F9,'off');
axis(app.T4F9,'off');
axis(app.T4F9,'equal');
title(app.T4F9,['Total skeleton length is ' num2str(round(Length,1)) ' (nm)'])
app.T4F9.FontSize=11;
app.T4F9.FontWeight='bold';
app.T4F9.TitleFontSizeMultiplier = 1.65;
app.T4F9.Visible=true;
axis(app.T4F9,'off')
drawnow;
fst=full(ST);
fst2=fst+fst';

c = sum(fst2~=0,2);
[TailID,~]=find(c==1);
[TriplePointID,~]=find(c>=3);%Triple points and higher

G = graph(I,J,W);

LengthThreshold=P.SmallBranchLengthThreshold; %Removing small branches
RemovedNodesSave=[];
for i=1:size(TailID,1)
        nodeTail=TailID(i,1);
        RemovedNodes=SmallBranchRemoval(G,nodeTail,TriplePointID,A,LengthThreshold);
        RemovedNodesSave=[RemovedNodesSave;RemovedNodes];
end

LengthModified=0;

for i=1:size(ST,1)
    for j=1:size(ST,2)
        if ST(i,j)>0 && ~ismember(i,RemovedNodesSave) && ~ismember(j,RemovedNodesSave)
            Points=[A(i,:);A(j,:)];
            LengthModified=LengthModified+ST(i,j);
            plot3(app.T4F10,Points(:,1),Points(:,2),Points(:,3),'k','LineWidth', 2)
            hold(app.T4F10,'on');
        end
    end
end

plot3(app.T4F10,A(:,1),A(:,2),A(:,3),'r.','MarkerSize',20)

axis(app.T4F10,'off');
axis(app.T4F10,'equal');

T1=['Skeleton length is ' num2str(round(LengthModified,1)) ' (nm) after'];
T2=['removing branches smaller than ' num2str(LengthThreshold) ' (nm)'];

title(app.T4F10,{T1;T2})

app.T4F10.FontSize=11;
app.T4F10.FontWeight='bold';
app.T4F10.TitleFontSizeMultiplier = 1.65;
app.T4F10.Visible=true;
axis(app.T4F10,'off')
drawnow

end