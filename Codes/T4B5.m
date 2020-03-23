%Tab 4, Get skeleton ID pushbutton
function T4B5(app)

cla_Invisible_Tab4_SkeletonFigures(app)
app.T4F14.Visible=true;
axis(app.T4F14,'off')
app.T4L1.Text={'Creating Kd-tree nearest neighbor searcher model','Please wait'};
app.T4Lamp1.Color='y';pause(0.001)

Skeleton=app.Skeleton;

X=cell(size(Skeleton,1));
for i=1:size(Skeleton,1)
    x=Skeleton{i, 1}.SkeletonPointsDN;
    X{i,1}=[x i.*ones(size(x,1),1)];
end
X=cell2mat(X);
Mdl=KDTreeSearcher(X(:,1:3));
app.T4L1.Text={'Please select a point from the skeleton plot (Plot #12)'};
app.T4Lamp1.Color='g';pause(0.001)
h=app.handleT4F12;
h.ButtonDownFcn = {@showZValueFcnT4F12,app,Mdl,X};

end