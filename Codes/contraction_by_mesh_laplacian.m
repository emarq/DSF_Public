% point cloud contraction_by_mesh_laplacian 
% inputs:
%P contains all the information calculated for the point cloud upto now
%GS contains the parameters for skeleton extraction
%app
% notes:
%   compute_point_laplacian() is slow. Not changing weights in iteration
%   and using combinatorial weights both lead to failed to contraction
%   enough.
function [cpts, t, initWL, WC, sl,VolumeReductionMatrix,WarningMessage] = contraction_by_mesh_laplacian(P,GS,app)

% visual debug conditions
RING_SIZE_TYPE = 1;%1:min, 2:mean, 3:max
SHOW_CONTRACTION_PROGRESS = true;
Laplace_type = 'conformal';%conformal%combinatorial%spring%mvc

% setting
tc=GS.CONTRACT_TERMINATION_CONDITION;
iterate_time =GS.MAX_CONTRACT_NUM;

initWL = compute_init_laplacian_constraint_weight(P,Laplace_type,GS);
% set initial attraction weights according to different type of discrete
% Laplacian
if strcmp(Laplace_type,'mvc')
    WC = 10;
elseif strcmp(Laplace_type,'conformal')
    WC = GS.WC;
else
    WC = 1;
end
WH = ones(P.npts, 1)*WC;
sl = GS.LAPLACIAN_CONSTRAINT_SCALE; % scale factor for WL in each iteration! in original paper is 2;
WL = initWL;

% init iteration
t = 1; % current iteration step

% left side of the equation
L = -compute_point_laplacian(P.pts,Laplace_type,P.rings);%conformal;%spring

A = [L.*WL;sparse(1:P.npts,1:P.npts,WH)];
% right side of the equation
b = [zeros(P.npts,3);sparse(1:P.npts,1:P.npts, WH)*P.pts];
cpts = (A'*A)\(A'*b);

sizes = one_ring_size(P.pts, P.rings, RING_SIZE_TYPE);   % min radius of 1-ring
size_new = one_ring_size(cpts, P.rings, RING_SIZE_TYPE);
a(t) = sum(size_new)/sum(sizes);

if SHOW_CONTRACTION_PROGRESS    
    cla(app.T4F4,'reset')
    
    PptsNormal=P.pts(:,1:3);
    PptsNormal=Denormalization(PptsNormal,P.center,P.scaleFactor);
    scatter3(app.T4F4,PptsNormal(:,1),PptsNormal(:,2), PptsNormal(:,3),4,'b','filled');
    hold(app.T4F4,'on');
    
    cptsNormal=cpts(:,1:3);
    cptsNormal=Denormalization(cptsNormal,P.center,P.scaleFactor);
    scatter3(app.T4F4,cptsNormal(:,1),cptsNormal(:,2), cptsNormal(:,3),10,'r','filled');
    hold(app.T4F4,'off');
    legend(app.T4F4,'off')
    axis(app.T4F4,'off');
    axis(app.T4F4,'equal');
    axis(app.T4F4,'off')
	app.Label_T4F4.Visible=true;
    app.Label_T4F4_2.Visible=true;
    drawnow
end

while t<iterate_time
    L = -compute_point_laplacian(cpts,Laplace_type, P.rings);%conformal
    
    WL = sl*WL;
    if WL>GS.MAX_LAPLACIAN_CONSTRAINT_WEIGHT
        WL=GS.MAX_LAPLACIAN_CONSTRAINT_WEIGHT;
    end
    
    if strcmp(Laplace_type,'mvc')
        WH = WC.*(sizes./size_new)*10;
    else
        WH = WC.*(sizes./size_new);
    end
    
    WH(WH>GS.MAX_POSITION_CONSTRAINT_WEIGHT) = GS.MAX_POSITION_CONSTRAINT_WEIGHT;% from Oscar08's implementation, 10000
    
    A = real([WL*L;sparse(1:P.npts,1:P.npts, WH)]);
    
    % update right side of the equation
    b(P.npts+1:end, :) = sparse(1:P.npts,1:P.npts, WH)*cpts;
    tmp = (A'*A)\(A'*b);
    
    size_new = one_ring_size(tmp, P.rings, RING_SIZE_TYPE);
    a(end+1) = sum(size_new)/sum(sizes);
    
    if SHOW_CONTRACTION_PROGRESS
        cla(app.T4F4,'reset')
        set(app.T4F4,'color','white');
        
        PptsNormal=P.pts(:,1:3);
        PptsNormal=Denormalization(PptsNormal,P.center,P.scaleFactor);
        scatter3(app.T4F4,PptsNormal(:,1),PptsNormal(:,2), PptsNormal(:,3),4,'b','filled');
        hold(app.T4F4,'on');
        
        tmpNormal=tmp(:,1:3);
        tmpNormal=Denormalization(tmpNormal,P.center,P.scaleFactor);
        scatter3(app.T4F4,tmpNormal(:,1),tmpNormal(:,2), tmpNormal(:,3),10,'r','filled');
        hold(app.T4F4,'off');
        axis(app.T4F4,'off');
        legend(app.T4F4,'off')
        axis(app.T4F4,'equal');
        axis(app.T4F4,'vis3d');
        app.T4F4.Visible=true;
        axis(app.T4F4,'off')
        drawnow;     
    end
    
    tmpbox = compute_bbox(tmp);
    if sum( (tmpbox(4:6)-tmpbox(1:3))> ((P.bbox(4:6)-P.bbox(1:3))*1.2) ) > 0
        WriteSkeletonMessages({' ';'Skeleton is out of box.'},app)
        break;
    end
    
    if a(t)-a(end)<tc || isnan(a(end))
        break;
    else
        cpts = tmp;
    end
    
    t = t+1;
end

if SHOW_CONTRACTION_PROGRESS
    if t<iterate_time
        if a(end) < tc
            WriteSkeletonMessages('Exit iteration because termination condition meets!',app)
            T1='exist iteration because termination condition meets!';
            WarningMessage=false(1);
        elseif a(end-1)-a(end)<tc
            WriteSkeletonMessages(['Termination reason: Volume reduction in the last two iterations is less than the threshold which is ' num2str(tc) '.'],app)
            T1=['Volume reduction in the last two iterations is less than the threshold which is ' num2str(tc) '.'];
            WarningMessage=false(1);
        else
            WriteSkeletonMessages('Warning: exit iteration unnormally! Probably contraction procedure was not done properly!',app)
            T1='exist iteration unnormally!';
            WarningMessage=true(1);
        end
    end
    
    %  axis(app.T4F5,'off');
    %  axis(app.T4F5,'equal');
    plot(app.T4F5,1:size(a,2),a,'k--');
    hold(app.T4F5,'on');
    
    plot(app.T4F5,1:size(a,2),a,'.','MarkerSize',25,'MarkerEdgeColor','b','MarkerFaceColor',[0,0,1]);
    
    ylim(app.T4F5,[0 1])
    xlim(app.T4F5,[1 size(a,2)])
    
    app.T4F5.XTick=1:size(a,2);
    xlabel(app.T4F5,'Iteration number')
    ylabel(app.T4F5,'Ratio')
    
    title(app.T4F5,{'Ratio between volume in each contraction iteration and the original volume.';'Termination reason:'; T1})
    hold(app.T4F5,'off');
    app.T4F5.FontSize=11;
    app.T4F5.FontWeight='bold';
    app.T4F5.TitleFontSizeMultiplier = 1.15;%1.65;
    app.T4F5.LabelFontSizeMultiplier = 1.2;%1.35;
    app.T4F5.Visible=true;
    drawnow
end
VolumeReductionMatrix=a';

end

