%Main skeleton function
%The inputs are
%P represetns the point cloud information
%app
%Param represents parameters used to extract skeletons
function P=Main_Skeleton(P,app,Param)

GS.MIN_NEIGHBOR_NUM = Param(1,1);
GS.MAX_NEIGHBOR_NUM = Param(2,1);

GS.LAPLACIAN_CONSTRAINT_SCALE=Param(6,1); % scalar for increasing WL in each iteration
GS.MAX_LAPLACIAN_CONSTRAINT_WEIGHT=Param(7,1);%WL values larger than this value are set to this value
GS.MAX_CONTRACT_NUM=Param(9,1); % max contract iterations 20
GS.MAX_POSITION_CONSTRAINT_WEIGHT=Param(8,1);
GS.CONTRACT_TERMINATION_CONDITION=Param(10,1);

GS.Lplc_cons_w_pOne=Param(3,1);%used in compute_init_laplacian_constraint_weight function for figure 4
GS.Lplc_cons_w_pTwo=Param(4,1);%used in compute_init_laplacian_constraint_weight function for figure 4

GS.WC=Param(5,1);%prefactor for WH     used in contraction_by_mesh_laplacian function for figure 4

GS.RadiusPrefactor=Param(11,1); %prefactor used to find the radius of the ball used for finding neighber in the farthest_sampling_by_sphere function. Affects figure 6 & 7
%-----------------------
P.sphere=false; %Condensed skeleton has only ONE point

P.npts = size(P.pts,1);
[P.pts,P.center,P.scaleFactor] = normalize(P.pts);
[P.bbox, P.diameter] =compute_bbox(P.pts);

% Step 1: build local 1-ring
P.k_knn = compute_k_knn(P.npts,GS);
P.rings = compute_point_point_ring(P.pts, P.k_knn);

[P.cpts, t, initWL, WC, sl,P.VolumeReduction,P.Warning] = contraction_by_mesh_laplacian(P, GS,app);

% step 2: Point to curve C by cluster ROSA2.0
P.sample_radius = P.diameter*(GS.RadiusPrefactor);
P = rosa_lineextract(P,P.sample_radius,0,app);% bUpdateConnectivity: 0 for RECOVER CONNECTIVITY after each edge collapse, which is slow, but the 
                                           % result sampling is more uniform.
                                           % bUpdateConnectivity: 1 for update CONNECTIVITY after each edge collapse, which is faster, and the
                                           % result sampling is almost as same as that of the original method (bUpdateConnectivity=0).

% show results
if ~P.sphere
   
    PptsNormal=P.pts(:,1:3);
    PptsNormal=Denormalization(PptsNormal,P.center,P.scaleFactor);
    scatter3(app.T4F8,PptsNormal(:,1),PptsNormal(:,2),PptsNormal(:,3),15,'.','MarkerEdgeColor', 'b'); 
      
    hold(app.T4F8,'on');
    plot_skeleton(P.spls,P.spls_adj,app.T4F8,P);
    hold(app.T4F8,'off');
    axis(app.T4F8,'off');
    axis(app.T4F8,'equal');
    title(app.T4F8,'Original point cloud and its skeleton')
    app.T4F8.FontSize=11;
    app.T4F8.FontWeight='bold';
    app.T4F8.TitleFontSizeMultiplier = 1.65;
    app.T4F8.Visible=true;
    axis(app.T4F8,'off')
    drawnow;
    [P.Length,P.LengthModified]=PlotFinalConnectivity(P,app);
    
else
    Length=0;
    P.Length=0;
    P.LengthModified=0;
end

OrigPoints=Denormalization(P.pts,P.center,P.scaleFactor);
P.OrigPointsDN=OrigPoints;

AAAA=P.spls;
AAAA(any(isnan(AAAA),2),:)=[];
SkeletonPoints=Denormalization(AAAA,P.center,P.scaleFactor);
P.SkeletonPointsDN=SkeletonPoints;

AAAA=P.spls;
SkeletonPoints=Denormalization(AAAA,P.center,P.scaleFactor);
P.SkeletonPointsDNwithNaN=SkeletonPoints;

WriteSkeletonMessages({'   ';['Total skeleton length is ' num2str(round(P.Length,1)) ' (nm).']},app)
WriteSkeletonMessages(['Total skeleton length after removing branches smaller than ' num2str(P.SmallBranchLengthThreshold) ' (nm) is ' num2str(round(P.LengthModified,1)) ' (nm).'],app)
 
end