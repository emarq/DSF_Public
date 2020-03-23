function wl = compute_init_laplacian_constraint_weight(PS,type,GS)
Lplc_cons_w_pOne=GS.Lplc_cons_w_pOne;
Lplc_cons_w_pTwo=GS.Lplc_cons_w_pTwo;
    switch lower(type)
        case 'distance'
            warning('not implemented!'); 
        case 'spring'
            warning('not implemented!');                  
        case {'conformal','dcp'} % conformal laplacian  
            ms = one_ring_size(PS.pts,PS.rings,2);
            wl = Lplc_cons_w_pOne/(Lplc_cons_w_pTwo*mean(ms));
        otherwise % combinatorial or mvc
            ms = one_ring_size(PS.pts,PS.rings,2);
            wl = Lplc_cons_w_pOne/(Lplc_cons_w_pTwo*mean(ms));
    end
end

