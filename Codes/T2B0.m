%Tab2, Initialize this tab pushbutton
function T2B0(app)

app.T2P2.Visible=false;
app.T2P2_2.Visible=false;


PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);
if isempty(PosFileName)
    app.T2L1.Text={'Please write the name of the pos file in the first tab';'and then click the "Initialize this tab" button again.'};
    app.T2Lamp1.Color='r';pause(0.001)
    return
elseif isempty(NameOfElementOfInterest)
    app.T2L1.Text={'Please write the name of the element of interest in the first tab';'and then click the "Initialize this tab" button again.'};
    app.T2Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets'],'dir')==7) %It is used to make hdbscanCluster in hdbscanPostProcess function
    app.T2L1.Text={'You did not do the "Import pose file" analysis on the first tab';['for the "' PosFileName '.pos" file.'];'Please start the analysis from the first tab.'};
    app.T2Lamp1.Color='r';pause(0.001)
    return
elseif ~(exist([PosFileName '/1_Datasets/' PosFileName '_' NameOfElementOfInterest '.mat'],'file')==2) %It is used to make hdbscanCluster in hdbscanPostProcess function
    app.T2L1.Text={'You did not do the "Import pose file" analysis on the first tab';['for the "' NameOfElementOfInterest '" atoms.'];'Please start the analysis from the first tab.'};
    app.T2Lamp1.Color='r';pause(0.001)
    return
else
    if exist([PosFileName,'/2_ClusterAnalysis'],'dir')==7
        rmdir([PosFileName,'/2_ClusterAnalysis'],'s')
    end
    
    cla_Invisible_Tab1_AllFigures(app)
    cla_Invisible_Tab2_AllFigures(app)
    ClearAllGlobalVariable(app)
    
    app.T2P2.Visible=false;
    app.T2CB1.Value=0;
    app.T2CB2.Value=0;
    
    app.T2DD1.Value='x-axis';
    app.T2DD2.Value='z-axis';
    app.T2DD3.Value='Azimuth';
    app.T2S2.Value=0;
    app.T2S2previousValue=0;
    app.T2S3.Value=1;
    
    app.T2L1.Text={'Please click on the "Find dense objects" button.';
	    '';...
		'"MinClusterSize" is an estimated value for the minimum dense object size.';...
        '"MinSamples" is the number of nearest neighbors used for the mutual reachability calculations.';...
        'Atoms having a probability value (to be a member of a dense object) smaller than'; 'the "Probability threshold" are considered as noise.';...
         '"MinSamples" parameter is usually set a value between 7 to 25. More atoms are ';'considered as noise if this parameter is set to a small value.';...
        'It is recommanded to choose a large value for the "Probability threshold" paramter.'};
    app.T2Lamp1.Color='g';pause(0.001)
    drawnow
end

end