%Tab 4, show help checkbox
function T4CB0(app)

value = app.T4CB0.Value;
if value
    app.T4L12.Value={...
    'To become familiar with the parameters mentioned below it is recommanded to read Ultramicroscopy 2020 ? ';...
    '';...
    'Min number of neighbors:';...
    'Minimum number of neigbors parameter is used to build local one-ring in the compute_k_knn function. The default value for this parameter is 8. It affects plot #4.';...
    '';...
    'Max number of neighbors:';...
    'Maximum number of neigbors parameter is used to build local one-ring in the compute_k_knn function. The default value for this parameter is 30. It affects plot #4.';...
    '';...
    'Lplcn const. wt. prfctr1:';...
    'Laplacian constraint weight prefactor is used in the compute_init_laplacian_constraint_weight function. The default value for this parameter is 1. It affects plot #4.';...
    'Please look at Eq. ? of the DSF paper';...
    '';...
    'Lplcn const. wt. prfctr2:';...
    'Laplacian constraint weight prefactor is used in the compute_init_laplacian_constraint_weight function. The default value for this parameter is 5. It affects plot #4.';...
    'Please look at Eq. ? of the DSF paper';...
    '';...
    'WH prefactor:';...
    'This constant is a prefactor for the WH parameter (?). It is used in the contraction_by_mesh_laplacian function. The default value for this parameter is 1.';...
    'It affects plot #4.';...
    '';...
    'Laplacian Cnstrnt. scale:';...
    'Laplacian constraint scale is a constant used to increase WL in each iteration. It is used in the contraction_by_mesh_laplacian function.';...
    'The default value is 3.It affects plot #4.';...
    '';...
    'Max Laplacian cnstrnt wt.:';...
    'WL values larger than the value of "maximum Laplacian constraint weight" constant are set to this constant.';...
    'This constant is used in the contraction_by_mesh_laplacian function. The default value is 2048. It affects plot #4.';...
    '';...
    'Max position cnstrnt wt.:';...
    'WH values larger than the value of "maximum position constraint weight" constant are set to the value of this constant.';...
    'This constant is used in the contraction_by_mesh_laplacian function. The default value is 10000. It affects plot #4.';...
    '';...
    'Max num. of cntrctn iter.:';...
    'The contraction process terminates if the number of iterations exceeds the maximum number of contraction iterations.';...
    'The default value is 20. It is used in the contraction_by_mesh_laplacian function. It affects plot #5.';...
    '';...
    'Cntrctn. trmntn. cndtn.:';...
    'Contraction termination condition is used to terminate the contraction iterations. The default value is 0.01.';...
    'It is used in the contraction_by_mesh_laplacian function. It affects plot #5.';...
    '';...
    'Radius prefactor:';...
    'This is a prefactor which is used to determine the radius of the ball used for for finding neighbors in the';...
    'farthest_sampling_by_sphere function. It affects plots #6 and #7. The default value is 0.02';...
    '';...
    'Small-branch lng. thrshld:';...
    'Skeleton branches smaller than the value of "Small-Branch length threshold" constant are removed in plot #10.';... 
    'This constant is used in the SmallBranchRemoval function. The default value is 2 nm';...
    };
    app.T4L12.Visible=true;
else
    app.T4L12.Visible=false;
end
            
end