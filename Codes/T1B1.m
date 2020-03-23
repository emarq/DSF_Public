%Tab 1, Import pos file pushbutton
function T1B1(app)

app.T1L1.Text={'Please wait!'};
app.T1Lamp1.Color='y';pause(0.001)
ClearAllGlobalVariable(app)
cla(app.T1F1,'reset')
app.T1F1.Visible=false;

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

if isempty(PosFileName)
    app.T1L1.Text={'Please write the name of the pos';'and then click the "Import pos file" button again.'};
    app.T1Lamp1.Color='r';pause(0.001)
    return
elseif size(PosFileName,2)>4 && strcmp(PosFileName(1,end-4:end),'.pos')
    app.T1L1.Text='Please do not write .pos at the end of the pos file name.';
    app.T1Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '.pos'],'file')==2)
    app.T1L1.Text={'There is no pos file with the name';[PosFileName '.pos'];'in the current folder.'};
    app.T1Lamp1.Color='r';
    return
elseif sum(isspace(PosFileName))>0
    app.T1L1.Text={'There is a space in the name of the pos file which makes';'problems for us. Please remove the space from the name of the pos file.'};
    app.T1Lamp1.Color='r';
    return
elseif isempty(NameOfElementOfInterest)
    app.T1L1.Text={'Please write the name of the element of interest';'and then click the "Import pos file" button again.'};
    app.T1Lamp1.Color='r';pause(0.001)
    return
elseif sum(isspace(NameOfElementOfInterest))>0
    app.T1L1.Text={'"Element of interest" box is not in the correct format.';'There should not be any space.';...
                   'For instance, instead of "Fe Cr" write it as "FeCr".'};
    app.T1Lamp1.Color='r';pause(0.001)
    return
elseif sum(~isletter(NameOfElementOfInterest))>0   
    app.T1L1.Text={'"Element of interest" box is not in the correct format.';
                   'We can only use letters for this box.'};    
    app.T1Lamp1.Color='r';pause(0.001)
    return
elseif app.T1RB1Hidden.Value
    app.T1L1.Text={'Please answer the following question:';'Was "Reverse Z" checked during the reconstruction?';...
                   '';'The answer of this question is very important for determing the crystallographic'; 'plane of dislocation loops in Tab 5.'};
    app.T1Lamp1.Color='r';pause(0.001)
    return    
end

RangeStr=char(app.T1EFT3.Value);
if isempty(RangeStr)
    app.T1L1.Text={'Please write the mass-to-charge ratio values';'and then click the "Import pos file" button again.'};
    app.T1Lamp1.Color='r';pause(0.001)
    return
end

RangeStrCell =(strsplit(RangeStr,';'))';
Range(1:size(RangeStrCell,1),1:2)=0;
for i=1:size(RangeStrCell,1)
    temp=str2num(RangeStrCell{i,1});
    if ~(size(temp,2)==2)
        app.T1L1.Text={'Please write the mass-to-charge ratio values in pairs';'for instance, 13.9,14.2;14.4,14.6;14.9,15.1';'and then click the "Import pos file" button again.'};
        app.T1Lamp1.Color='r';pause(0.001)
        return
    elseif temp(1,1)>temp(1,2)
        app.T1L1.Text={'In each mass-to-charge ratio pair';'the first value must be equal or smaller than the second value.';'Please check all the pairs';'and then click the "Import pos file" button again.'};
        app.T1Lamp1.Color='r';pause(0.001)
        return
    elseif temp(1,1)<0 || temp(1,2)<0
        app.T1L1.Text={'Mass-to-charge ratio values cannot be negative.';'Please check all the mass-to-charge ratio values';'and then click the "Import pos file" button again.'};
        app.T1Lamp1.Color='r';pause(0.001)
        return
    end
    Range(i,1:2)=temp;
end

for i=1:size(Range,1)
   for j=1:size(Range,1)
       if ~(i==j)
           interval1=fixed.Interval(Range(i,1),Range(i,2));
           interval2=fixed.Interval(Range(j,1),Range(j,2));
           if overlaps(interval1, interval2)
               app.T1L1.Text={'There is an overlap between the following mass-to-charge ratio intervals:';['[' num2str(Range(i,1)) ',' num2str(Range(i,2)) '] and [' num2str(Range(j,1)) ',' num2str(Range(j,2)) ']'];...
                              'Please fix the problem and then click the "Import pos file" button again.'};
               app.T1Lamp1.Color='r';pause(0.001)
               return 
           end
       end
   end
end

PosFileNameWithExtension=[PosFileName '.pos'];
if ~(isfile(PosFileNameWithExtension))
    app.T1Lamp1.Color='r';
    app.T1L1.Text={[PosFileNameWithExtension ' file is missing!!'];'Pleas put the pos file in the current folder.'};pause(0.001)
    return
end

if exist(PosFileName,'dir')==7
    rmdir(PosFileName,'s')
end
mkdir(PosFileName,'1_Datasets')

app.T1L1.Text={'Start loading the pos file.';'Please wait!'};
app.T1Lamp1.Color='y';pause(0.001)
A=open_pos(PosFileNameWithExtension);
app.T1L1.Text={'Loading the pos file is completed!';'Please wait'};pause(0.001)

fid1 = fopen('1_Reconstruction_Reverse_Z_status.txt','wt');
fprintf(fid1, '%s\n', 'Was "Reverse Z" checked during the reconstruction?');
A(:,3)=-A(:,3);%This is related to reverse Z check box. I will complete it later. I think I need to generate a file which mentions the condition set by the user, then if the user only opens tab 5, no problem will happen
if app.T1RB1Yes.Value
    fprintf(fid1, '%s', 'Yes');
elseif app.T1RB1No.Value
    fprintf(fid1, '%s', 'No');
end
fclose(fid1);
movefile('1_Reconstruction_Reverse_Z_status.txt',[PosFileName,'/1_Datasets'])

temp1=[PosFileName '_' NameOfElementOfInterest '.mat'];
temp2=[PosFileName '_' NameOfElementOfInterest '_OtherAtoms' '.mat'];

B(1:size(A,1),1:size(Range,1))=false;
for i=1:size(Range,1)
    B(:,i)=((A(:,4)>=Range(i,1)) & (A(:,4)<=Range(i,2)));
end

Interest=[];
C=any(B,2);
Interest=A(C,1:3);
if size(Interest,1)==0
        app.T1L1.Text={'There is no "atoms of interest" in the pos file.';'Please check the mass-to-charge ratio values';'and then click the "Import pos file" button again.'};
        app.T1Lamp1.Color='r';pause(0.001)
        return
end
app.T1L1.Text={['Writing ' temp1 ' file.'],'Please wait!'};pause(0.001)
savefast(temp1,'Interest')

Others=[];
Others=A(~C,1:3);
if size(Others,1)==0
        app.T1L1.Text={'There is no "Others" atoms in the pos file.';'Please set the mass-to-charge ratio value in a way';'that at least one atom is not considered as atoms of interest';'and then click the "Import pos file" button again.'};
        app.T1Lamp1.Color='r';pause(0.001)
        return
end
app.T1L1.Text={['Writing ' temp2 ' file.'],'Please wait!'};pause(0.001)
savefast(temp2,'Others')

fclose('all');


app.T1L1.Text={'Moving the generated files to /1_Dataset folder';'Please wait'};pause(0.001)
movefile(temp1, [PosFileName,'/1_Datasets'])
movefile(temp2, [PosFileName,'/1_Datasets'])
movefile(PosFileNameWithExtension, [PosFileName,'/1_Datasets'])

fid1 = fopen('0_ParamtersUsedForConvertingPosFileToTwoMatFiles.txt','wt');
fprintf(fid1, '%s\t', 'Pos-file name:');
fprintf(fid1, '%s\n', PosFileName);

fprintf(fid1, '%s\t', 'Element of interest:');
fprintf(fid1, '%s\n', NameOfElementOfInterest);

fprintf(fid1, '%s\n', 'Mass-to-charge ratio range:');
for j=1:size(Range,1)
    fprintf(fid1, '%f\t %f\n', Range(j,1:2));
end
fprintf(fid1, '%s\n', '---------------------');

fprintf(fid1, '%s\t', 'Azimuth view angle:');
fprintf(fid1, '%s\n', [char(app.T1EFT5.Value) ' (degree)']);

fprintf(fid1, '%s\t', 'Elevation view angle:');
fprintf(fid1, '%s\n', [char(app.T1EFT6.Value) ' (degree)']);

fprintf(fid1, '%s\n', '---------------------');
fprintf(fid1, '%s\n', 'Some statistics about the generated files.');

fprintf(fid1, '%s', 'NumberOfAtomsOfInterest=');
fprintf(fid1, '%s\n', num2str(size(Interest,1)));

fprintf(fid1, '%s', 'NumberOfOtherAtoms=');
fprintf(fid1, '%s', num2str(size(Others,1)));

fclose(fid1);

movefile('0_ParamtersUsedForConvertingPosFileToTwoMatFiles.txt',[PosFileName,'/1_Datasets'])

app.AxisLimits=[floor(min(Interest(:,1))) ceil(max(Interest(:,1)));...
    floor(min(Interest(:,2))) ceil(max(Interest(:,2)));...
    floor(min(Interest(:,3))) ceil(max(Interest(:,3)))];
writematrix(app.AxisLimits,'AxisLimits.txt','Delimiter','tab')%In a cas that the user wants to do the second tab without doing the first Tab, we need to load the data
movefile('AxisLimits.txt',[PosFileName,'/1_Datasets'])


app.T1L1.Text='Plotting atoms of interest';pause(0.001)
cla(app.T1F1,'reset')
MaxNumAtomToPlot=str2num(char(app.T1EFT4.Value));
if isempty(MaxNumAtomToPlot) || ~isnumeric(MaxNumAtomToPlot) || ~(size(MaxNumAtomToPlot,1)==1) || ~(size(MaxNumAtomToPlot,2)==1) || MaxNumAtomToPlot<5000 || ~(floor(MaxNumAtomToPlot)==MaxNumAtomToPlot)
        app.T1L1.Text={'Please fill the';'"Maximum number of atoms to plot" box';'with an integer value larger than 5000';'and then click the "Import pos file" button again.'};
        app.T1Lamp1.Color='r';pause(0.001)
        return
end

if size(Interest,1)>MaxNumAtomToPlot   %if we have more than 250,000 atom of interest, we only present
    rng(7,'twister');%To ensure the randperm generates the same number array for plots T1F1 and T2F2
    INDEX=randperm(size(Interest,1),MaxNumAtomToPlot);
    plot3(app.T1F1,Interest(INDEX,1),Interest(INDEX,2),Interest(INDEX,3),'k.','MarkerSize',3)
    title(app.T1F1,{[num2str(size(Interest,1)) ' ' NameOfElementOfInterest ' atoms in the original dataset'],['Only ' num2str(MaxNumAtomToPlot) ' of atoms are randomly shown (~' num2str(round(100*MaxNumAtomToPlot/size(Interest,1)),4) '%)']});
else
    plot3(app.T1F1,Interest(:,1),Interest(:,2),Interest(:,3),'k.','MarkerSize',3)
    title(app.T1F1,[num2str(size(Interest,1)) ' ' NameOfElementOfInterest ' atoms in the original dataset']);
end

xlabel(app.T1F1,'X (nm)')
ylabel(app.T1F1,'Y (nm)')
zlabel(app.T1F1,'Z (nm)')

xlim(app.T1F1,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T1F1,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T1F1,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
pbaspect(app.T1F1,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
view(app.T1F1,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
app.T1F1.Visible=true;
app.T1L1.Text=['Drawing the ' NameOfElementOfInterest ' ions!'];pause(0.001)
drawnow

app.T1S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T1S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));

app.T1S2previousValue=0;
app.T1S2.Value=0;

app.T1RB1Hidden.Value=true;%To avoid any problem if the user wants to repeat the calculations 

app.T1Lamp1.Color='g';
app.T1L1.Text={'Done!';'The generated files are in';[PosFileName '/1_Datasets' ' folder.'];'We can now go to the second tab and start finding the dense objects';'formed by the atoms of interest.'};pause(0.001)
end