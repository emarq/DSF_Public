%Tab 2,Get dense object ID pushbutton
function T2B4(app)

app.T2L1.Text={'Creating Kd-tree nearest neighbor searcher model.','Please wait.'};
app.T2Lamp1.Color='y';pause(0.001)
hdbscanSelByPersisAndProb=app.hdbscanSelByPersisAndProb;
X=cell(size(hdbscanSelByPersisAndProb,2),1);
for i=1:size(hdbscanSelByPersisAndProb,2)
    x=hdbscanSelByPersisAndProb(i).atomPositions;
    labels=hdbscanSelByPersisAndProb(i).Newlabels;
    X{i,1}=[x labels.*ones(size(x,1),1)];
end
X=cell2mat(X);
Mdl=KDTreeSearcher(X(:,1:3));
app.T2L1.Text='Please select a point from the second plot from the RIGHT side.';
app.T2Lamp1.Color='g';pause(0.001)
h=app.handleT2F4;
h.ButtonDownFcn = {@showZValueFcnT2F4,app,Mdl,X};

end