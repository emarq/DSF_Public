function output=PersisColormaker(x,SelectedColor)

Colors=ones(size(x,1),1).*SelectedColor;
X=([x(:,1) x(:,2) x(:,3) Colors]);
A=mat2cell(X,ones(size(X,1),1),[1 1 1 3]);
rowHeadings = {'X', 'Y', 'Z', 'Col'};
output=cell2struct(A,rowHeadings,2);




end