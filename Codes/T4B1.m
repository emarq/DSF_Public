%Tab 4, Initialize this tab pushbutton
function T4B1(app)

app.T4L1.Text='Please wait';
app.T4Lamp1.Color='y';pause(0.001)

ClearAllGlobalVariable(app)
cla_Invisible_Tab3_AllFigures(app)
cla_Invisible_Tab4_AllFigures(app)

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

if isempty(PosFileName)
    app.T4L1.Text={'Please write the name of the pos file in the first tab';'and then click the "Initialize this tab" button again.'};
    app.T4Lamp1.Color='r';pause(0.001)
    return
elseif isempty(NameOfElementOfInterest)
    app.T4L1.Text={'Please write the name of the element of interest in the first tab';'and then click the "Initialize this tab" button again.'};
    app.T4Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets'],'dir')==7) %It is used to make hdbscanCluster in hdbscanPostProcess function
    app.T4L1.Text={'You did not do the "Import pose file" analysis on the first tab';['for the "' PosFileName '.pos" file.'];'Please start the analysis from the first tab.'};
    app.T4Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '.mat'],'file')==2) %It is used to make hdbscanCluster in hdbscanPostProcess function
    app.T4L1.Text={'You did not do the "Import pose file" analysis on the first tab';['for the "' NameOfElementOfInterest '" atoms.'];'Please start the analysis from the first tab.'};
    app.T4Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/2_ClusterAnalysis/' PosFileName '_' NameOfElementOfInterest '_hdbFinal_Tab3Finalized.mat'],'file')==2) %It is used to make sure that the third tab is completed before this tab
    app.T4L1.Text={'You did not finalize the results of the third tab.';'Please start the analysis from the third tab.'; '"(2/2) Detecting dense objects (pruning)"'};
    app.T4Lamp1.Color='r';
    return
elseif ~(exist([PosFileName,'/1_Datasets/AxisLimits.txt'],'file')==2)
    app.T4L1.Text={'AxisLimits.txt file is missing.';'Please start the analysis from the first tab.'};
    app.T4Lamp1.Color='r';
    return
end
    
app.T4L1.Text={'Start loading the dense object data from the previous tab.'; 'The file name is';[PosFileName '_' NameOfElementOfInterest '_hdbFinal_Tab3Finalized.mat'];'in';[PosFileName,'/2_ClusterAnalysis' ' folder']};pause(0.001)
AAA=load([PosFileName '/2_ClusterAnalysis/' PosFileName '_' NameOfElementOfInterest '_hdbFinal_Tab3Finalized.mat']);
hdb=AAA.hdbFinal;
app.hdb=hdb;

app.AxisLimits=importdata([PosFileName,'/1_Datasets/AxisLimits.txt']);
    
app.T4CB1.Value=0;
app.T4L18.Visible=false;

if exist([PosFileName,'/3_Skeleton'],'dir')==7
    rmdir([PosFileName,'/3_Skeleton'],'s')
end
mkdir(PosFileName,'3_Skeleton')

hdbt=cell(size(hdb,2),1);
for j=1:size(hdb,2)
    x=hdb(j).points;
    color=hdb(j).color;
    hdbt{j,1}=[x ones(size(x,1),1).*color];
end
hdbT=cell2mat(hdbt);

scatter3(app.T4F11,hdbT(:,1),hdbT(:,2),hdbT(:,3),5.*ones(size(hdbT,1),1),hdbT(:,4:6),'filled');

% A=load('C:/Users/marquislab/Desktop/Users/Iman/DSF4/r/1_Datasets/r_Si.mat');
% A=A.Interest;
% hold(app.T4F11,'on')
% plot3(app.T4F11,A(:,1),A(:,2),A(:,3),'k.','MarkerSize',3)

view(app.T4F11,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T4F11,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T4F11,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T4F11,[app.AxisLimits(3,1) app.AxisLimits(3,2)])

xlabel(app.T4F11,'X (nm)')
ylabel(app.T4F11,'Y (nm)')
zlabel(app.T4F11,'Z (nm)')

title(app.T4F11,[num2str(size(hdbt,1)) ' dense objects'])
axis(app.T4F11,'off')
axis(app.T4F11,'equal')
app.T4F11.Visible=true;
% pbaspect(app.T4F11,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
drawnow

app.T4S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T4S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));


MIN_NEIGHBOR_NUM=8; %Step 1: build local 1-ring      used in compute_k_knn function for figure 4
MAX_NEIGHBOR_NUM=30; %Step 1: build local 1-ring     used in compute_k_knn function for figure 4

Lplc_cons_w_pOne=1;%used in compute_init_laplacian_constraint_weight function for figure 4
Lplc_cons_w_pTwo=5;%used in compute_init_laplacian_constraint_weight function for figure 4

WC=1;%prefactor for WH     used in contraction_by_mesh_laplacian function for figure 4

LAPLACIAN_CONSTRAINT_SCALE=3; % scalar for increasing WL in each iteration. scale factor for WL in each iteration  used in contraction_by_mesh_laplacian function for figure 4

MAX_LAPLACIAN_CONSTRAINT_WEIGHT=2048;%WL values larger than this value are set to this value used in contraction_by_mesh_laplacian function for figure 4

MAX_POSITION_CONSTRAINT_WEIGHT=10000;%WH values larger than this value are set to this value used in contraction_by_mesh_laplacian function for figure 4

MAX_CONTRACT_NUM=20; % max contract iterations 20    used in contraction_by_mesh_laplacian function for figure 5
CONTRACT_TERMINATION_CONDITION=0.01;%used in contraction_by_mesh_laplacian function for figure 5

RadiusPrefactor=0.02; %prefactor used to find the radius of the ball used for finding neighber in the farthest_sampling_by_sphere function. Affects figure 6 & 7

SmallBranchLengthThreshold=2; %Removes branches smaller than this value used in SmallBranchRemoval function for figure 10


FCN={'Min number of neighbors';...
    'Max number of neighbors';...
    'Lplcn const. wt. prfctr1';...
    'Lplcn const. wt. prfctr2';...
    'WH prefactor';...
    'Laplacian Cnstrnt. scale';...
    'Max Laplacian cnstrnt wt.';...
    'Max position cnstrnt wt.';...
    'Max num. of cntrctn iter.';...
    'Cntrctn. trmntn. cndtn.';...
    'Radius prefactor';...
    'Small-branch lng. thrshld'};
T1=table(FCN);
T2=array2table([8 8;30 30;1 1;5 5;1 1;3 3;2048 2048;10000 10000;20 20;0.01 0.01;0.02 0.02;2 2]);
app.T4T1.Data=[T1 T2];
app.T4T1.ColumnEditable=[false false true];
app.T4T1.RowName = 'numbered';
app.T4T1.ColumnName={'Parameter';'Default';'Current'};

app.T4T2.Visible=false;

app.T4S2.Value=0;
app.T4S2previousValue=0;

drawnow
app.T4L1.Text={'Starting parallel pool (parpool) using the "local" profile.';'Please wait!'};pause(0.001)
parfor i=1:50
end

app.T4L1.Text={'Done with loading the data.';'You can now click on the "Extract skeletons" button.';'Please note that there are 12 paramters which affect the extraction';...
               'of the skeleton of a dense object (as presented in the first table).';'You can change these parameters under the "Current" column.'};
app.T4Lamp1.Color='g';pause(0.001)
end