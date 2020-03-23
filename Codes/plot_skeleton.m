function  plot_skeleton(pts, A,haxes29,P)

sizep=400; %point size
sizee=2;   %edge size
colorp =  [1,0,0]; %point color 
colore = [0,0,0];  %edge color


ptsNormal=pts(:,1:3);
ptsNormal=Denormalization(ptsNormal,P.center,P.scaleFactor);
scatter3(haxes29,ptsNormal(:,1),ptsNormal(:,2),ptsNormal(:,3),sizep,'.','MarkerEdgeColor', colorp);
%scatter3(haxes29,pts(:,1),pts(:,2),pts(:,3),sizep,'.','MarkerEdgeColor', colorp);  
hold(haxes29,'on');
plot_connectivity(pts, A, sizee, colore,haxes29,P)




end