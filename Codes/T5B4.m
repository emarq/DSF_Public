%Tab 5, Get Skeleton ID pushbutton
function T5B4(app)

app.T5L1.Text={'Creating Kd-tree nearest neighbor searcher model','Please wait'};
app.T5Lamp1.Color='y';pause(0.001)

Skeleton=app.Skeleton;
X=cell(size(Skeleton,1));
for i=1:size(Skeleton,1)
    x=Skeleton{i, 1}.SkeletonPointsDN;
    X{i,1}=[x i.*ones(size(x,1),1)];
end
X=cell2mat(X);
Mdl=KDTreeSearcher(X(:,1:3));
app.T5L1.Text={'Please select a point from the skeleton plot (plot #2)'};
app.T5Lamp1.Color='g';pause(0.001)

h=app.handleT5F2;
h.ButtonDownFcn = {@showZValueFcnT5F2,app,Mdl,X};
            
end