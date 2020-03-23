%Tab 6, save the plot push button
function T6B4(app)

app.T6L1.Text={'Checking for any error in the input.';'Please wait.'};
app.T6Lamp1.Color='y';pause(0.001)

input=str2num(char(app.T6EFT0.Value));

if size(input,1)==0
    app.T6L1.Text={'The "Plot #" box is empty or the input is inappropriate.'};
    app.T6Lamp1.Color='r';pause(0.001)
    return
elseif size(input,1)>1
    app.T6L1.Text={'Please separate the plot number values with ",".'};
    app.T6Lamp1.Color='r';pause(0.001)
    return  
elseif sum(input<1)>0 || sum(input>5)>0 || sum(~(floor(input)==input))>0
    app.T6L1.Text='Plot number values must be integers between 1 and 5.';
    app.T6Lamp1.Color='r';pause(0.001)
    return
elseif size(unique(input),2)<size(input,2)
    app.T6L1.Text={'One of the plot number values is repeated more than once.'};
    app.T6Lamp1.Color='r';pause(0.001)
    return    
end

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

for i=1:size(input,2)
    app.T6L1.Text={['Saving plot #' num2str(input(1,i)) '.'];'Please wait.';...
        '';'Please note that for saving figures,'; 'we must set the "Title type" to either  "Intrinsic" or "None".'};
    switch input(1,i)
        case 1
            appDesignerFigSaver(app.T6F1,['Fig1_' PosFileName '_' NameOfElementOfInterest '_OriginalDataset.tiff'],[app.T6F1.Position])
            movefile(['Fig1_' PosFileName '_' NameOfElementOfInterest '_OriginalDataset.tiff'],[PosFileName,'/4_FinalResults_Video'])
        case 2
            appDesignerFigSaver(app.T6F2,['Fig2_' PosFileName '_' NameOfElementOfInterest '_Dislocations.tiff'],[app.T6F2.Position])
            movefile(['Fig2_' PosFileName '_' NameOfElementOfInterest '_Dislocations.tiff'],[PosFileName,'/4_FinalResults_Video'])
        case 3
            appDesignerFigSaver(app.T6F3,['Fig3_' PosFileName '_' NameOfElementOfInterest '_Clusters.tiff'],[app.T6F3.Position])
            movefile(['Fig3_' PosFileName '_' NameOfElementOfInterest '_Clusters.tiff'],[PosFileName,'/4_FinalResults_Video'])
        case 4
            appDesignerFigSaver(app.T6F4,['Fig4_' PosFileName '_' NameOfElementOfInterest '_ThreeColorPlot.tiff'],[app.T6F4.Position])
            movefile(['Fig4_' PosFileName '_' NameOfElementOfInterest '_ThreeColorPlot.tiff'],[PosFileName,'/4_FinalResults_Video'])
        case 5
            appDesignerFigSaver(app.T6F5,['Fig5_' PosFileName '_' NameOfElementOfInterest '_Others.tiff'],[app.T6F5.Position])
            movefile(['Fig5_' PosFileName '_' NameOfElementOfInterest '_Others.tiff'],[PosFileName,'/4_FinalResults_Video'])
    end 
end

app.T6L1.Text={'Done!';'The saved plots are in';[PosFileName,'/4_FinalResults_Video folder.'];...
               '';'Please note that for saving figures,'; 'we must set the "Title type" to either  "Intrinsic" or "None".'};
app.T6Lamp1.Color='g';pause(0.001)
end