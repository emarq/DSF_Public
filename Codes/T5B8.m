%Tab 5, Determining the crystallographic plane of a dislocation loop
function T5B8(app)

app.T5L1.Text={'Please wait'};
app.T5Lamp1.Color='y';pause(0.001)

EulerAngles=str2num(char(app.T5EFT11.Value));
if isempty(EulerAngles) && ~(isempty(app.T5EFT11.Value))
    app.T5L1.Text={'"EBSD Euler angles" box is not in the correct format.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif isempty(EulerAngles)
    app.T5L1.Text={'"EBSD Euler angles" box is not filled.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif ~(size(EulerAngles,1)==1) || ~(size(EulerAngles,2)==3)
    app.T5L1.Text={'"EBSD Euler angles" box is not in the correct format.';'There must be only three values separated by ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif EulerAngles(1,1)<0 || EulerAngles(1,1)>360
    app.T5L1.Text={'"EBSD Euler angles" box is not in the correct format.';'The first value must be between 0 and 360.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif EulerAngles(1,2)<0 || EulerAngles(1,2)>180
    app.T5L1.Text={'"EBSD Euler angles" box is not in the correct format.';'The second value must be between 0 and 180.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif EulerAngles(1,3)<0 || EulerAngles(1,3)>360
    app.T5L1.Text={'"EBSD Euler angles" box is not in the correct format.';'The third value must be between 0 and 360.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);
DisData=load([PosFileName,'/4_FinalResults/' PosFileName '_' NameOfElementOfInterest '_FinalResults.mat']);
DisData=DisData.Dislocations;
if isempty(DisData)
    app.T5L1.Text={'We cannot do the analysis because there is no dislocation in this atom probe dataset.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
else
    IDsvaer(1:size(DisData,1),1)=0;
    for i=1:size(DisData,1)
        IDsvaer(i,1)=DisData{i,1}.SkeletonID;
    end
end

dID=str2num(char(app.T5EFT12.Value));
if isempty(dID) && ~(isempty(app.T5EFT12.Value))
    app.T5L1.Text={'"Dislocation ID" box is not in the correct format.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif isempty(dID)
    app.T5L1.Text={'"Dislocation ID" box is not filled.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return   
elseif ~(size(dID,1)==1) || ~(size(dID,2)==1) 
    app.T5L1.Text={'There must be only one integer value in the "Dislocation ID" box.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return   
elseif ~ismember(dID,IDsvaer)
    app.T5L1.Text={['There is no dislocation with the ID value of ' num2str(dID) '.'];'Please use "Get skeleton ID" button to get the correct ID value and';...
                    'then fix the "Dislocation ID" box.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return      
end

LeapEbsdRot=str2num(char(app.T5EFT13.Value));
if isempty(LeapEbsdRot) && ~(isempty(app.T5EFT13.Value))
    app.T5L1.Text={'"LEAP-EBSD rotation angle" box is not in the correct format.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
elseif isempty(LeapEbsdRot)
    app.T5L1.Text={'Please fill the "LEAP-EBSD rotation angle" box.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif ~(size(LeapEbsdRot,1)==1) || ~(size(LeapEbsdRot,2)==1)
    app.T5L1.Text={'There must be only one number in the "LEAP-EBSD rotation angle" box.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
end

if ~(app.MTEXisLoaded)  
    app.T5L1.Text={'Start loading MTEX-5.1.1';'Please wait'};pause(0.001)
    run mtex-5.1.1/startup.m
    clc
    app.MTEXisLoaded=true;
end

ss=specimenSymmetry('-1');

if app.T5RB1Hidden.Value
    app.T5L1.Text={'Please choose the point group.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif app.T5RB1cubic.Value
    cs=crystalSymmetry('m-3m');
elseif app.T5RB1hcp.Value
    cs=crystalSymmetry('6/mmm');%I need to customize the code for hcp and define sample frame
end

PosFileName=char(app.T1EFT1.Value);
ReverseZChecked=importdata([PosFileName,'/1_Datasets/1_Reconstruction_Reverse_Z_status.txt']);
if strcmp(ReverseZChecked{2},'Yes')
    ReverseZChecked=true;%Instead of this line, I need to make sure whether I need to change z coordinate to -z or not
elseif strcmp(ReverseZChecked{2},'No')
    ReverseZChecked=false;%Instead of this line, I need to make sure whether I need to change z coordinate to -z or not
else
    app.T5L1.Text={'There is no "1_Reconstruction_Reverse_Z_status.txt" file in';'"1_Datasets" folder. Please start the analysis from the first tab.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return     
end

for i=1:size(DisData,1)
    if dID==DisData{i,1}.SkeletonID
        points=DisData{i,1}.OrigPointsDN;%I need to make sure whether I need to change z coordinate to -z or not
        Color=DisData{i,1}.color;
        ptCloud=pointCloud([points(:,1),points(:,2),points(:,3)]); 
        Pnormal=mean(pcnormals(ptCloud,size(points,1)));
        if Pnormal(1,3)<0 %It means the normal direction to the point cloud is not oriented toward the north. I do not know for now how it affects the north/south pole figure (addition of 180 degree)
            Pnormal=-Pnormal;
        end
        break
    end
end

Ori=orientation('Euler',(EulerAngles(1,1)+LeapEbsdRot)*degree,EulerAngles(1,2)*degree,EulerAngles(1,3)*degree,cs,ss);%Probably I need to add 180 to phi1 to go to the south pole. Also I need to add LEAP-EBSD rotation here.

[Index,Message]=GenerateIndex(app);%This function only works for cubic. I need to extend it for hcp 
if ~isempty(Message)
    app.T5L1.Text=Message;
    app.T5Lamp1.Color='r';pause(0.001)
    return  
end

SolNum=app.T5EF18.Value;%Solution number
if SolNum<1 || ~(floor(SolNum)==SolNum) 
    app.T5L1.Text={'Please fill the "IPF plot for solution #" box with an integer value.','This value is the row number for the table located below the "Crystallographic plane" button.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return  
elseif SolNum>size(Index,1)
    app.T5L1.Text={'Please fill the "IPF plot for solution #" box with an integer value',['smaller than ' num2str(size(Index,1)+1) '.'],'This value is the row number for the table located below the "Crystallographic plane" button.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return      
end

MTEXoutput=MTEXcalculations(Index(:,1),Index(:,2),Index(:,3),cs,Ori,Pnormal,app,SolNum,Color);

app.T5T2.Data=array2table(MTEXoutput);
app.T5T2.ColumnName={'h';'k';'l';'Deviation (degree)'};
app.T5T2.RowName = 'numbered';
app.T5T2.ColumnWidth = {37,37,37,93};
app.T5T2.Visible=true;
app.T5F11.Visible=true;
axis(app.T5F11,'off')


app.T5L1.Text={'Done!';...
              ['This plot shows the crystallographic plane of dislocation #' num2str(dID) '.'];...
              ['A high quality figure of this plot is saved in ' PosFileName,'/4_FinalResults folder.'];...
              'If you think the crystallographic plane presented in the first row of the table is not the best,';...
              'you can write another row number of the table in the "IPF plot for solution #" box and repeat the analysis.';...
              '';
              'If you want to combine different IPF plots, you must first do the analysis for all of the';...
              'dislocations of interest one-by-one and then use the "Plotting combined IPF" panel to combine them.';... 
              };

app.T5Lamp1.Color='g';pause(0.001)

end