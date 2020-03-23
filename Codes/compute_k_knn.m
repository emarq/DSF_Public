%Determines the k value for the knn function
%npts is the number of points
%GS contains the min and max values for the nearest neighbors
function num = compute_k_knn(npts,GS)

MIN_NEIGHBOR_NUM=GS.MIN_NEIGHBOR_NUM;
MAX_NEIGHBOR_NUM=GS.MAX_NEIGHBOR_NUM;
num = max(MIN_NEIGHBOR_NUM,round(npts*0.012));
if num > MAX_NEIGHBOR_NUM
    num = MAX_NEIGHBOR_NUM;
end

end