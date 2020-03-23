%Tab 5, Save figure pushbutton
function T5B5(app)

app.T5L1.Text={'Checking for any error in the input.';'Please wait.'};
app.T5Lamp1.Color='y';pause(0.001)

input=str2num(char(app.T5EFT0.Value));

if size(input,1)==0
    app.T5L1.Text={'The "Plot #" box is empty or the input is inappropriate.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif size(input,1)>1
    app.T5L1.Text={'Please separate the plot number values with ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return  
elseif sum(input<1)>0 || sum(input>6)>0 || sum(~(floor(input)==input))>0
    app.T5L1.Text={'Plot number values must be integers between 1 and 6.';'Other plots are saved as soon as they are generated.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif size(unique(input),2)<size(input,2)
    app.T5L1.Text={'One of the plot number values is repeated more than once.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
end

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

for i=1:size(input,2)
    app.T5L1.Text={['Saving plot #' num2str(input(1,i)) '.'];'Please wait.'};
    switch input(1,i)
        case 1
            appDesignerFigSaver(app.T5F1,['Fig1_' PosFileName '_' NameOfElementOfInterest '_OriginalDataset_ManuallySaved.tiff'],[app.T5F1.Position])
            movefile(['Fig1_' PosFileName '_' NameOfElementOfInterest '_OriginalDataset_ManuallySaved.tiff'],[PosFileName,'/4_FinalResults'])
        case 2
            appDesignerFigSaver(app.T5F2,['Fig2_' PosFileName '_' NameOfElementOfInterest '_Skeleton_ManuallySaved.tiff'],[app.T5F2.Position])
            movefile(['Fig2_' PosFileName '_' NameOfElementOfInterest '_Skeleton_ManuallySaved.tiff'],[PosFileName,'/4_FinalResults'])
        case 3
            appDesignerFigSaver(app.T5F3,['Fig3_' PosFileName '_' NameOfElementOfInterest '_Dislocations_ManuallySaved.tiff'],[app.T5F3.Position])
            movefile(['Fig3_' PosFileName '_' NameOfElementOfInterest '_Dislocations_ManuallySaved.tiff'],[PosFileName,'/4_FinalResults'])
            
            appDesignerFigSaver(app.T5F7,['Fig3_' PosFileName '_' NameOfElementOfInterest '_DislocationLengthHistogram_ManuallySaved.tiff'],[app.T5F7.Position])
            movefile(['Fig3_' PosFileName '_' NameOfElementOfInterest '_DislocationLengthHistogram_ManuallySaved.tiff'],[PosFileName,'/4_FinalResults'])
        case 4
            appDesignerFigSaver(app.T5F4,['Fig4_' PosFileName '_' NameOfElementOfInterest '_Clusters_ManuallySaved.tiff'],[app.T5F4.Position])
            movefile(['Fig4_' PosFileName '_' NameOfElementOfInterest '_Clusters_ManuallySaved.tiff'],[PosFileName,'/4_FinalResults'])
            
            appDesignerFigSaver(app.T5F8,['Fig4_' PosFileName '_' NameOfElementOfInterest '_ClusterSizeHistogram_ManuallySaved.tiff'],[app.T5F8.Position])
            movefile(['Fig4_' PosFileName '_' NameOfElementOfInterest '_ClusterSizeHistogram_ManuallySaved.tiff'],[PosFileName,'/4_FinalResults'])
        case 5
            appDesignerFigSaver(app.T5F5,['Fig5_' PosFileName '_' NameOfElementOfInterest '_ThreeColorPlot_ManuallySaved.tiff'],[app.T5F5.Position])
            movefile(['Fig5_' PosFileName '_' NameOfElementOfInterest '_ThreeColorPlot_ManuallySaved.tiff'],[PosFileName,'/4_FinalResults'])
        case 6
            appDesignerFigSaver(app.T5F6,['Fig6_' PosFileName '_' NameOfElementOfInterest '_Others_ManuallySaved.tiff'],[app.T5F6.Position])
            movefile(['Fig6_' PosFileName '_' NameOfElementOfInterest '_Others_ManuallySaved.tiff'],[PosFileName,'/4_FinalResults'])
    end
    
end

app.T5L1.Text={'Done!';'The save plots are in';[PosFileName,'/4_FinalResults folder.']};
app.T5Lamp1.Color='g';pause(0.001)
clc

end