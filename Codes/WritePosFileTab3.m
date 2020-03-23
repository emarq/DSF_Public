%Tab 3, write pos file
function WritePosFileTab3(app)

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

hdbFinal=load([PosFileName,'/2_ClusterAnalysis/' PosFileName '_' NameOfElementOfInterest '_hdbFinal_Tab3Finalized.mat']);
hdbFinal=hdbFinal.hdbFinal;

cp=cell(size(hdbFinal,2),1);%cluster points
cpm=cell(size(hdbFinal,2),1);%cluster points with m/n

for j=1:size(hdbFinal,2)
    p=hdbFinal(j).points;
    cp{j,1}=p;
    cpm{j,1}=[p j.*ones(size(p,1),1)];
end
cp=cell2mat(cp);

Interest=load([PosFileName,'/1_Datasets/' PosFileName '_' NameOfElementOfInterest '.mat']);
Interest=Interest.Interest;
index=~(ismember(Interest,cp,'rows'));

Noise=[Interest(index,1:3) 0.5.*ones(sum(index),1)];
cpm=cell2mat(cpm);

data=[Noise;cpm];
Noise=[];cpm=[];cp=[];Interest=[];index=[];p=[];hdbFinal=[];%For saving memory
if app.T3CB2.Value
    Others=load([PosFileName,'/1_Datasets/' PosFileName '_' NameOfElementOfInterest '_OtherAtoms.mat']);
    Others=Others.Others;
    Others(:,4)=0.25;
    
    data=[Others;data];
    Others=[];%For saving memory
end
savepos(data(:,1),data(:,2),data(:,3),data(:,4),[PosFileName '_' NameOfElementOfInterest 'DenseObjectsAndNoiseAndOtherAtoms_Tab3Finalized.pos'])
movefile([PosFileName '_' NameOfElementOfInterest 'DenseObjectsAndNoiseAndOtherAtoms_Tab3Finalized.pos'],[PosFileName,'/2_ClusterAnalysis/'])


HelpFileName=[PosFileName '_' NameOfElementOfInterest 'DenseObjectsAndNoiseAndOtherAtoms_Tab3Finalized_Help.txt'];
fid1 = fopen(HelpFileName,'wt');
if app.T3CB2.Value
    fprintf(fid1, '%s\n', 'Mass-to-charge ratio value of 0.25 represents Other atoms.');
end
fprintf(fid1, '%s\n', 'Mass-to-charge ratio value of 0.5 represents Atoms Of Interest which were considered as noise.');
fprintf(fid1, '%s\n', 'Mass-to-charge ratio values which are integers represent dense objects.');

fclose(fid1);
movefile(HelpFileName,[PosFileName,'/2_ClusterAnalysis'])

end