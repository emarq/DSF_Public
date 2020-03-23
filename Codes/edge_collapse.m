% collapse the adjacency matrix spls_adj until the described graph is 1-dimensional.
% this inherits some ideas from [Li et al. 2001] Decomposing  polygon meshes for interactive
% applications, which remove all triangles of the graph to form a 1-D skeleton.
%
% pts: samples
% spls: downsamples
% corresp: correspondence between pts and spls, array of |pts|*1
% neigh: neighbors of pts, a |pts|*? cell
% spls_adj: connection matrix of downsamples (spls)
%app
% P contains all the information of the point cloud
%
% @author: JJCAO
% Changed from Andrea Tagliasacchi's code
% @data:   2010-5-7
% @version 2.0
function [spls, A, corresp] = edge_collapse(pts, spls, corresp, neigh, spls_adj,app,P)

collapse_order = 1; 

% visual debug conditions
SHOW_COLLAPSE_PROGRESS = true;
SHOW_RESULTS = true;

if SHOW_COLLAPSE_PROGRESS || SHOW_RESULTS
    cla(app.T4F7,'reset')
end

% --- EDGE COLLAPSE 
A = spls_adj;
A(A>0) = 1;

while true
    %DEBUG: display connectivity and vertexes at every iteration
    if SHOW_COLLAPSE_PROGRESS
        if exist('heds')
            delete(heds);
        end
        if exist('hpts')
            delete(hpts);
        end
        
        splsNormal=spls(:,1:3);
        splsNormal=Denormalization(splsNormal,P.center,P.scaleFactor);
        hpts = plot3(app.T4F7, splsNormal(:,1), splsNormal(:,2), splsNormal(:,3), '.r', 'markersize', 12);
        %hpts = plot3(haxes27, spls(:,1), spls(:,2), spls(:,3), '.r', 'markersize', 9);
        hold(app.T4F7,'on');
        heds = [];
        for i=1:size(A,1)
            for j=1:size(A,2)
                if( A(i,j)==1 )
                    idx = [i;j];
                    splsRow1Normal=spls(idx(1,:),1:3);
                    splsRow1Normal=Denormalization(splsRow1Normal,P.center,P.scaleFactor);
                    splsRow2Normal=spls(idx(2,:),1:3);
                    splsRow2Normal=Denormalization(splsRow2Normal,P.center,P.scaleFactor);
                    splsNormal=[splsRow1Normal;splsRow2Normal];
                    heds(end+1) = line(app.T4F7, splsNormal(:,1),splsNormal(:,2),splsNormal(:,3), 'LineWidth', 1, 'Color', [0 0.85 0.85]);
                    %heds(end+1) = line(haxes27, spls(idx,1),spls(idx,2),spls(idx,3), 'LineWidth', 2, 'Color', 'b');
                end
            end
        end
        axis(app.T4F7,'equal');
        axis(app.T4F7,'off');
		title(app.T4F7,{'Converting the contracted mesh'; 'into a 1D graph'})
        app.T4F7.FontSize=11;
        app.T4F7.FontWeight='bold';
        app.T4F7.TitleFontSizeMultiplier = 1.65;
        app.T4F7.Visible=true;
        axis(app.T4F7,'off')
        drawnow update
        pause(0.001);
    end

    %--- RECOVER CONNECTIVITY
    % TODO: iterative update, HUGE SPEEDUP! if you don't reconstruct the
    % triangle count, but rather, update it, it's MUCH MUCH faster
	%
    % recover the set of edges on triangles & count triangles
    degrees = ones(size(spls,1),1);
    for i=1:size(spls,1)
        ns = find(A(i,:)==1);
        degrees(i) = length(ns)-1;
    end
    tricount = 0;
    skeds = zeros(0,4);% idx1, idx2, average degree of two end points, distance
    for i=1:length(spls)
        ns = find(A(i,:)==1);
        ns = ns( ns>i );%touch every triangle only once
        lns = length(ns);
        for j=1:lns
            for k=j+1:lns
                if A(ns(j),ns(k)) == 1
                    tricount = tricount+1;
                    skeds(end+1,1:3) = [i,ns(j), 0.5*(lns+degrees(ns(j))) ];                                                        
                    skeds(end,4) = euclidean_distance(spls(i,:), spls(ns(j),:) ); 
                    skeds(end+1,1:3) = [ns(j),ns(k), 0.5*(degrees(ns(j)) +degrees(ns(k)) )];                                               
                    skeds(end,4) = euclidean_distance( spls(ns(j),:), spls(ns(k),:) );
                    skeds(end+1,1:3) = [i,ns(k), 0.5*(lns+degrees(ns(k))) ]; 
                    skeds(end,4) = euclidean_distance( spls(ns(k),:), spls(i,:) );
                end
            end
        end
    end
    
    %--- STOP CONDITION
    % no more triangles? then the structure is 1D
    if tricount == 0 
        break
    end
    
    %--- DECIMATION STEP + UPDATES
    % collapse the edge with minimum cost, remove the second vertex
    if collapse_order == 1 % cost is degree + distance
        mind = min( skeds(:,3) );
        tmpIdx = find(skeds(:,3)==mind);
        tmpSkeds = skeds(tmpIdx,4);

        [IGN, idx] = min( tmpSkeds );
        edge = skeds(tmpIdx(idx),1:2);
    else % cost is distance
        [IGN, idx] = min( skeds(:,4) );
        edge = skeds(idx,1:2);
    end
     
    % update the location
    spls( edge(2),: ) = mean( spls( edge,: ) );
    spls( edge(1),: ) = NaN;
    % update the A matrix
    for k=1:size(A,1)
        if A(edge(1),k) == 1
            A(edge(2),k)=1; 
            A(k,edge(2))=1; 
        end
    end
    % remove the row
    A(edge(1),:) = 0;
    A(:,edge(1)) = 0;
    % update the correspondents
    corresp(corresp==edge(1) ) = edge(2);   
end
hold(app.T4F7,'off');
drawnow;
end
function dist = euclidean_distance(p1, p2)
v=p1-p2;
dist = sqrt(dot(v,v));
end