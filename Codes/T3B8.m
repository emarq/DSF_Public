%Tab 3, Finalizing the results pushbutton
function T3B8(app)

cla(app.T3F4,'reset')
app.T3F4.Visible=false;

app.T3Lamp1.Color='y';
app.T3L1.Text='Start finalizing the analysis!';pause(0.001)

hdb=app.hdb;

%Updating the probability
probStr=char(app.T3EFT6.Value);
ProbCorrectionIDsaver=[];
if ~isempty(probStr)
    probStrCell =(strsplit(probStr,';'))';
    for i=1:size(probStrCell,1)
        temp=str2num(probStrCell{i,1});
        if size(temp,1)==0 || (~(size(temp,2)==2)) 
            app.T3L1.Text={'The blue box is not in the correct format.';...
                           'As an example, if you want to set the probability threshold to 0.93 for objects 1 and 2 and also';...
                           'you want to set the probability threshold to 0.95 for objects 3,4 and 5';...
                           'you must write as follows:'; '1,0.93;2,0.93;3,0.95;4,0.95;5,0.95'};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif temp(1,1)<1 || temp(1,1)>(size(hdb,2)+1) || ~(temp(1,1)==floor(temp(1,1)))
            app.T3L1.Text={'The blue box is not in the correct format.';...
                            [num2str(temp(1,1)) ' cannot be an object ID.'];...
                            'Please click on the "Get the dense object ID" button again and get the correct value.'};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif ismember(temp(1,1),ProbCorrectionIDsaver)
            app.T3L1.Text={['ID #' num2str(temp(1,1)) ' is repeated more than once in the blue box.'];...
                            'Please make sure that all ID values are unique.'};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif temp(1,2)>1 || temp(1,2)<min(hdb(temp(1,1)).probabilities)
            app.T3L1.Text={'The blue box is not in the correct format.';...
                           ['For the object ID ' num2str(temp(1,1)) ', the probability threshold value must be'];...
                           ['set to a value between ' num2str(min(hdb(temp(1,1)).probabilities)) ' and 1.']}; 
            app.T3Lamp1.Color='r';pause(0.001)
            return
        end
         app.T3L1.Text={'Updating the probability for';['the dense object ' num2str(temp(1,1))]};pause(0.001)
         ProbCorrectionIDsaver=[ProbCorrectionIDsaver,temp(1,1)];
         prob=hdb(temp(1,1)).probabilities;
         Index=(prob>=temp(1,2));
         x=hdb(temp(1,1)).atomPositions;
         hdb(temp(1,1)).atomPositions=x(Index,:);
         hdb(temp(1,1)).probabilities=prob(Index,:);
    end
end

objectIDsaver=[];
hdbUpdatedPosCell=cell(10000,1);
counter=0;
%Pruning merged objects
breakStr=char(app.T3EFT8.Value);
TempPruneIDsaver=[];
if ~isempty(breakStr)
    breakStrCell =(strsplit(breakStr,';'))';
    for i=1:size(breakStrCell,1)
        temp=str2num(breakStrCell{i,1});
        if size(temp,1)==0 || (~(size(temp,2)==4))
            app.T3L1.Text={'The green box is not in the correct format.';...
                           'The correct format is ObjectID,MinClusterSize,MinSamples,ProbabilityThreshold';...
                           'Example: 3,25,15,0.9;6,25,15,0.9;1,17,12,0.8';...
                           'Please note that there is no ";" at the end of the above example.'};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif temp(1,1)<1 || temp(1,1)>(size(hdb,2)+1) || ~(floor(temp(1,1))==temp(1,1))
            app.T3L1.Text={'The green box is not in the correct format.';...
                [num2str(temp(1,1)) ' cannot be a correct object ID.']};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif temp(1,2)<2 || ~(floor(temp(1,2))==temp(1,2))
            app.T3L1.Text={'The green box is not in the correct format.';...
                          ['The MinClusterSize value for the object #' num2str(temp(1,1)) ' must be an integer value larger than one.']};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif temp(1,3)<2 || ~(floor(temp(1,3))==temp(1,3))
            app.T3L1.Text={'The green box is not in the correct format.';...
                          ['The MinSamples value for the object #' num2str(temp(1,1)) ' must be an integer value larger than one.']};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif temp(1,4)<0 || temp(1,4)>1
            app.T3L1.Text={'The green box is not in the correct format.';...
                          ['The Probability threshold value for the object #' num2str(temp(1,1)) ' must be a value between 0 and 1.']};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif ismember(temp(1,1),TempPruneIDsaver)
            app.T3L1.Text={'The green box is not in the correct format.';...
                          ['Object #' num2str(temp(1,1)) ' cannot be analyzed more than one time.']};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        end
        TempPruneIDsaver=[TempPruneIDsaver,temp(1,1)];
        app.T3L1.Text=['Pruning the dense object #' num2str(temp(1,1))];pause(0.001)
        objectIDsaver=[objectIDsaver;temp(1,1)];
        
        Points=hdb(temp(1,1)).atomPositions;
        MinClusterSizeHDBSCAN=temp(1,2);
        MinSamplesHDBSCAN=temp(1,3);
        hdbscanProbabilityThreshold=temp(1,4);
        [hdbNew,noise]=hdbscanAnalysis_OnSelected(Points,MinClusterSizeHDBSCAN,MinSamplesHDBSCAN,hdbscanProbabilityThreshold);
        if isempty(hdbNew)
            app.T3L1.Text={['No dense object was found for the object ID #' num2str(temp(1,1)) '.']; 'Please either change the parameters or avoid pruning this object.';...
                'It is better that first you tune the parameters in the try and error panels and'; 'then write them in the "apply corrections" panel.'};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        end
        
        for j=1:size(hdbNew,2)
            counter=counter+1;
            hdbUpdatedPosCell{counter,1}=hdbNew(j).atomPositions;
        end
    end
end

%Stitching objects
stitchStr=char(app.T3EFT7.Value);
tempIDstitchSaver=[];
if ~isempty(stitchStr)
    app.T3L1.Text='Start stitching the dense objects!';pause(0.001)
    stitchStrCell =(strsplit(stitchStr,';'))';
    
    for i=1:size(stitchStrCell,1)
        temp=str2num(stitchStrCell{i,1});
        if ~(size(temp,1)==1)
            app.T3L1.Text={'The brown box is not in the correct format.';...
                           'As an example, if you want to stitch objects with ID values of 1, 2 and 3 together';...
                           'and also you want to stitch objects 8 and 9 together, you must write them as follows:';...
                           '1,2,3;8,9'}; 
            app.T3Lamp1.Color='r';pause(0.001)
            return 
        elseif (sum(temp<1)>0) || (sum(temp<1)>(size(hdb,2)+1)) || (sum(~(floor(temp)==temp))>0)
            app.T3L1.Text={'The brown box is not in the correct format.';...
                ['Object ID values must be integers smaller than ' num2str((size(hdb,2)+1)) '.']};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif size(unique(temp),2)<size(temp,2)
            app.T3L1.Text={'The brown box is not in the correct format.';...
                           'An object cannot be stitched with itself.'};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        elseif size(temp,2)==1
            app.T3L1.Text={['There is no object to be stitched with object #' num2str(temp(1,1)) '.'];...
                           'Please correct the brown box.'};            
            app.T3Lamp1.Color='r';pause(0.001)
            return            
        elseif (sum(ismember(temp,tempIDstitchSaver))>0)
            app.T3L1.Text={'The brown box is not in the correct format.';...
                           'An object cannot be stitched with two different groups.'};
            app.T3Lamp1.Color='r';pause(0.001)
            return
        end
        tempIDstitchSaver=[tempIDstitchSaver temp];
        objectIDsaver=[objectIDsaver;temp'];
        tempPosCell=cell(size(temp,2),1);
        for j=1:size(temp,2)
            tempPosCell{j,1}=hdb(temp(1,j)).atomPositions;
        end
        counter=counter+1;
        hdbUpdatedPosCell{counter,1}=cell2mat(tempPosCell);
    end
end

if size(TempPruneIDsaver,2)>0 && size(tempIDstitchSaver,2)>0
    if sum(ismember(TempPruneIDsaver,tempIDstitchSaver))>0
        app.T3L1.Text={'An object ID is the same in the brown and green boxes.';...
            'An object cannot be stitched and pruned at the same time.'};
        app.T3Lamp1.Color='r';pause(0.001)
        return
    end
end

for i=1:size(hdb,2)
    if ~ismember(i,objectIDsaver)
        counter=counter+1;
        hdbUpdatedPosCell{counter,1}=hdb(i).atomPositions;
    end
end

hdbUpdatedPosCell= hdbUpdatedPosCell(~cellfun('isempty',hdbUpdatedPosCell));

colors=distinguishable_colors(size(hdbUpdatedPosCell,1));
for i=1:size(hdbUpdatedPosCell,1)
    hdbFinal(i).points=hdbUpdatedPosCell{i,1};
    hdbFinal(i).color=colors(i,1:3);
    hdbUpdatedPosCell{i,1}=[hdbUpdatedPosCell{i,1} ones(size(hdbUpdatedPosCell{i,1},1),3).*colors(i,1:3)];
end

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

app.T3L1.Text={'Start writing the finalized file with the name';[PosFileName '_' NameOfElementOfInterest '_hdbFinal_Tab3Finalized.mat'];['in ' PosFileName,'/2_ClusterAnalysis' ' folder']};pause(0.001)
savefast([PosFileName,'/2_ClusterAnalysis/' PosFileName '_' NameOfElementOfInterest '_hdbFinal_Tab3Finalized.mat'],'hdbFinal')

app.T3L1.Text={'Start writing the pos file with the name';[PosFileName '_' NameOfElementOfInterest 'DenseObjects_Tab3Finalized.pos'];['in ' PosFileName,'/2_ClusterAnalysis' ' folder']};pause(0.001)
WritePosFileTab3(app)

hdbFinalT=cell2mat(hdbUpdatedPosCell);
cla(app.T3F3,'reset')
scatter3(app.T3F3,hdbFinalT(:,1),hdbFinalT(:,2),hdbFinalT(:,3),5.*ones(size(hdbFinalT,1),1),hdbFinalT(:,4:6),'filled');

view(app.T3F3,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T3F3,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T3F3,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T3F3,[app.AxisLimits(3,1) app.AxisLimits(3,2)])

xlabel(app.T3F3,'X (nm)')
ylabel(app.T3F3,'Y (nm)')
zlabel(app.T3F3,'Z (nm)')

title(app.T3F3,[num2str(size(hdbUpdatedPosCell,1)) ' dense objects'])
%axis(app.T3F3,'off')
pbaspect(app.T3F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T3F3.Visible=true;
drawnow


appDesignerFigSaver(app.T3F3,'6_FinalizedDetectedDenseObjects_Tab3.tiff',app.T3F3.Position)
movefile('6_FinalizedDetectedDenseObjects_Tab3.tiff',[PosFileName,'/2_ClusterAnalysis'])

app.T3L1.Text={'Done with finalizing the results.';[num2str(size(hdbUpdatedPosCell,1)) ' dense objects were detected.'];'If needed, you can finalize the results again; otherwise,';'you can now go to the fourth tab.'};
app.T3Lamp1.Color='g';pause(0.001)


end