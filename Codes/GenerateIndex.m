%Tab 5, generate hkl indices for crystallography analysis
function [Index,Message]=GenerateIndex(app)

Index=[];

H=app.T5EF14.Value;
if H<1 || ~(floor(H)==H)
   Message={'"h_max" value must be a positive integer.';'Please fix the problem.'};
   return
end

K=app.T5EF15.Value;
if K<1 || ~(floor(K)==K)
   Message={'"k_max" value must be a positive integer.';'Please fix the problem.'};
   return
end

L=app.T5EF16.Value;
if L<1 || ~(floor(L)==L)
   Message={'"l_max" value must be a positive integer.';'Please fix the problem.'};
   return
end

Resolution=app.T5EF17.Value;
if Resolution<1 || ~(floor(Resolution)==Resolution) || Resolution>H || Resolution>K || Resolution>L
   Message={'"Step size" value must be a positive integer number,';'smaller than h_max, k_max and l_max values.';'Please fix the problem.'};
   return
end

[X,Y,Z] = meshgrid(-H:Resolution:H,-K:Resolution:K,-L:Resolution:L);
Index = [X(:),Y(:),Z(:)];
[row,~]=find(Index(:,1)==0 & Index(:,2)==0 & Index(:,3)==0);
if ~isempty(row)
    Index(row,:)=[];%removing 0,0,0 
end

Message=[];

end