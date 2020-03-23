%Tab 5, write pos file
function WritePosFileTab5(Dislocations,Clusters,Others,app)

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

A=load([PosFileName,'/4_FinalResults/' PosFileName '_' NameOfElementOfInterest '_FinalResults.mat']);

Dislocations=A.Dislocations;
Clusters=A.Clusters;
Others=A.Others;

Counter=0;
dCounterSaver=[];
if size(Dislocations,1)
    dp=cell(size(Dislocations,1),1);
    dpm=cell(size(Dislocations,1),1);
    for i=1:size(Dislocations,1)
        Counter=Counter+1;
        p=Dislocations{i,1}.OrigPointsDN;
        dp{i,1}=p;
        dpm{i,1}=[p Counter.*ones(size(p,1),1)];
        dCounterSaver=[dCounterSaver;Counter];
    end
    dp=cell2mat(dp);
    dpm=cell2mat(dpm);
    dF=true;
else
    dp=[];
    dpm=[];
    dF=false;
end

cCounterSaver=[];
if size(Clusters,1)
    cp=cell(size(Clusters,1),1);
    cpm=cell(size(Clusters,1),1);
    for i=1:size(Clusters,1)
        Counter=Counter+1;
        p=Clusters{i,1}.OrigPointsDN;
        cp{i,1}=p;
        cpm{i,1}=[p Counter.*ones(size(p,1),1)];
        cCounterSaver=[cCounterSaver;Counter];
    end
    cp=cell2mat(cp);
    cpm=cell2mat(cpm);
    cF=true;
else
    cp=[];
    cpm=[];
    cF=false;
end

oCounterSaver=[];
if size(Others,1)
    op=cell(size(Others,1),1);
    opm=cell(size(Others,1),1);
    for i=1:size(Others,1)
        Counter=Counter+1;
        p=Others{i,1}.OrigPointsDN;
        op{i,1}=p;
        opm{i,1}=[p Counter.*ones(size(p,1),1)];
        oCounterSaver=[oCounterSaver;Counter];
    end
    op=cell2mat(op);
    opm=cell2mat(opm);
    oF=true;
else
    op=[];
    opm=[];
    oF=false;
end

Interest=load([PosFileName,'/1_Datasets/' PosFileName '_' NameOfElementOfInterest '.mat']);
Interest=Interest.Interest;

if dF
    if cF
        if oF
            index=~(ismember(Interest,dp,'rows') | ismember(Interest,cp,'rows') | ismember(Interest,op,'rows'));
        else
            index=~(ismember(Interest,dp,'rows') | ismember(Interest,cp,'rows'));
        end   
    else
        if oF
            index=~(ismember(Interest,dp,'rows') | ismember(Interest,op,'rows'));
        else
            index=~(ismember(Interest,dp,'rows'));
        end
    end
else
    if cF
        if oF
            index=~(ismember(Interest,cp,'rows') | ismember(Interest,op,'rows'));
        else
            index=~(ismember(Interest,cp,'rows'));
        end   
    else
        if oF
            index=~(ismember(Interest,op,'rows'));
        end
    end    
end

Noise=Interest(index,1:3);
if ~isempty(Noise)
    Noise(:,4)=0.25;
end

HelpFileName=[PosFileName '_' NameOfElementOfInterest '_FinalResults_PosFileMassToChargeRatioHelp.txt'];
fid1 = fopen(HelpFileName,'wt');
if app.T5CB3.Value
    fprintf(fid1, '%s\n', 'Mass-to-charge ratio value of 0.25 represents Other atoms.');
end
if ~isempty(Noise)
    fprintf(fid1, '%s\n', 'Mass-to-charge ratio value of 0.5 represents Atoms Of Interest which were considered as noise.');
end
if ~isempty(dCounterSaver)
    fprintf(fid1, '%s\n', ['Mass-to-charge ratio values from ' num2str(min(dCounterSaver)) ' to ' num2str(max(dCounterSaver)) ' represent "dislocation" objects.']); 
end
if ~isempty(cCounterSaver)
    fprintf(fid1, '%s\n', ['Mass-to-charge ratio values from ' num2str(min(cCounterSaver)) ' to ' num2str(max(cCounterSaver)) ' represent "cluster" objects.']); 
end
if ~isempty(oCounterSaver)
    fprintf(fid1, '%s\n', ['Mass-to-charge ratio values from ' num2str(min(oCounterSaver)) ' to ' num2str(max(oCounterSaver)) ' represent "other" objects.']); 
end

fclose(fid1);
movefile(HelpFileName,[PosFileName,'/4_FinalResults/'])

data=[Noise;dpm;cpm;opm];
if app.T5CB3.Value
    Noise=[];dpm=[];cpm=[];opm=[];A=[];Dislocations=[];Clusters=[];Others=[];Interest=[];p=[];dp=[];cp=[];op=[];index=[];%To save memory
    Others=load([PosFileName,'/1_Datasets/' PosFileName '_' NameOfElementOfInterest '_OtherAtoms.mat']);
    Others=Others.Others;
    Others(:,4)=0.25;
    data=[data;Others];
end

savepos(data(:,1),data(:,2),data(:,3),data(:,4),[PosFileName '_' NameOfElementOfInterest '_FinalResults.pos'])
movefile([PosFileName '_' NameOfElementOfInterest '_FinalResults.pos'],[PosFileName,'/4_FinalResults/'])

end