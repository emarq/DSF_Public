% use balls of size RADIUS to downsample the point cloud in a furthest sample fashion
%
% pts: points to be sampled
% neighs: neigh
% RADIUS: sample radius
% spls: sampled points
% corresp: correspondence between pts and spls, array of |pts|*1
%
% @author: JJCAO
% Changed from Andrea Tagliasacchi's code
% @data:   2010-5-7
% @version 2.0
function [spls, corresp] = farthest_sampling_by_sphere(pts, RADIUS,app,P)

% visual debug conditions
SHOW_SAMPLING_PROGRESS = true;
SHOW_RESULTS = false;

if SHOW_SAMPLING_PROGRESS || SHOW_RESULTS
    cla(app.T4F6,'reset');
    ptsNormal=pts(:,1:3);
    ptsNormal=Denormalization(ptsNormal,P.center,P.scaleFactor);
    plot3(app.T4F6, ptsNormal(:,1), ptsNormal(:,2), ptsNormal(:,3), '.r', 'markersize', 8);
    hold(app.T4F6,'on');   
end

%--- FURTHEST POINT DOWNSAMPLE THE CLOUD
kdtree = KDTreeSearcher(pts);
spls = zeros(0,3);
corresp = zeros(length(pts),1);
mindst = nan(length(pts),1); % mindst(i) is the min distance of pts(i) to the sample piont corresp(i)

for k=1:length(pts)
    if corresp(k)~=0
        continue
    end
    
    %query all the points for distances
    mindst(k) = inf; % make sure picked first
    
    %initialize the priority queue
    while ~all(corresp~=0) %~isempty( find(corresp==0, 1) )
        [maxValue, maxIdx] = max(mindst);
        if mindst(maxIdx) == 0
            break
        end
        
        % query its delta-neighborhood
        [nIdxs, nDsts] = rangesearch(kdtree,pts(maxIdx,:),RADIUS);%original
        nIdxs=cell2mat(nIdxs);
        nDsts=cell2mat(nDsts);
        
        % if maxIdx and all its neighborhood has been marked, skip ahead
        if all(corresp(nIdxs)~=0)
            mindst(maxIdx)=0;
            continue;
        end
        
        % create new node and update (closest) distances
        spls(end+1,:) = pts(maxIdx,:);
        for i=1:length(nIdxs)
            if mindst(nIdxs(i))>nDsts(i) || isnan(mindst(nIdxs(i)))
                mindst(nIdxs(i)) = nDsts(i);
                corresp(nIdxs(i)) = size(spls,1);
            end
        end
        
        if SHOW_SAMPLING_PROGRESS
            ptsNormal=pts(maxIdx,1:3);
            ptsNormal=Denormalization(ptsNormal,P.center,P.scaleFactor);
            plot3(app.T4F6,ptsNormal(:,1),ptsNormal(:,2),ptsNormal(:,3),'p','color',[0 0.8 0],'markersize',12);    
        end
    end
end

hold(app.T4F6,'off');
axis(app.T4F6,'off');
axis(app.T4F6,'equal');
app.T4F6.Visible=true;
axis(app.T4F6,'off')
app.Label_T4F6_1.Visible=true;
app.Label_T4F6_2.Visible=true;
app.Label_T4F6_3.Visible=true;
drawnow;
end
