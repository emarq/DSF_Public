function ms = one_ring_size(pts,rings,type)
    n = size(pts,1);
    ms = zeros(n,1);
    switch type
        case 1
            parfor i = 1:n
                ring = rings{i};    
                tmp = repmat(pts(i,:), length(ring),1) - pts(ring,:);
                ms(i) = min( sum(tmp.^2,2).^0.5);
            end
        case 2
            parfor i = 1:n
                ring = rings{i};    
                tmp = repmat(pts(i,:), length(ring),1) - pts(ring,:);
                ms(i) = mean( sum(tmp.^2,2).^0.5);
            end                    
        case 3
            parfor i = 1:n
                ring = rings{i};    
                tmp = repmat(pts(i,:), length(ring),1) - pts(ring,:);
                ms(i) = max( sum(tmp.^2,2).^0.5);
            end                    
    end
end