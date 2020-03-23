function  plot_connectivity(pts, A, sizee,colore,haxes29,P)

A(logical(eye(size(A)))) = 0;
for i=1:(size(A,1)-1)
    for j=(i+1):size(A,2)
        if (A(i,j)>0 )
            idx = [i;j];
            NormalRow1PTS=pts(idx(1,1),1:3);
            NormalRow1PTS=Denormalization(NormalRow1PTS,P.center,P.scaleFactor);
            
            NormalRow2PTS=pts(idx(2,1),1:3);
            NormalRow2PTS=Denormalization(NormalRow2PTS,P.center,P.scaleFactor);
            
            NormalPTS=[NormalRow1PTS;NormalRow2PTS];
            line(haxes29, NormalPTS(:,1),NormalPTS(:,2),NormalPTS(:,3), 'LineWidth', sizee, 'Color', colore);
        end
    end
end
    
end