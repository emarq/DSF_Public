%Before running the code, this function applies some changes to the interface
function StartUpFunction(app)

clc

cla_Invisible_Tab2_AllFigures(app)
cla_Invisible_Tab3_AllFigures(app)
cla_Invisible_Tab4_AllFigures(app)
cla_Invisible_Tab5_AllFigures(app)
cla_Tab6_AllFigures(app)

app.T1S2previousValue=0;
app.T2S2previousValue=0;
app.T3S2previousValue=0;
app.T4S2previousValue=0;
app.T5S2previousValue=0;
app.T6S2previousValue=0;

app.MTEXisLoaded=false;

app.T2L1.Text={'The purpose of this tab is "only" finding dense objects and declaring other atoms as noise.';'We will prune (break) or stitch dense objects in the next tab.';...
               'We can also increase the probability threshold for the selected dense objects in the next tab.';'';'Please click on the "Initialize this tab" button.'};

app.T3L1.Text={'In this tab, you can prune (break) merged dense objects,';'stitch dense objects and increase the probability threshold for the selected dense objects.';'';...
               'Please click on the "Initialize this tab" button.'};
			   
app.T4L1.Text={'Please click on the "Initialize this tab" button.';'';'In this tab, we extract the skeleton of each dense object.';...
               'Generally, you do not need to put any input in this tab';'and you only need to click on the buttons numbered in cyan color.';... 
			   'However, if you think it is important to change skeleton extraction parameters for all of the dense objects,';...
			   'you can simply change it in the second column of the first table which is located'; 'above the "Extract skeletons" button. Also, if you think the skeleton extraction';...
			   'parameters are not appropriate for a specific dense object, you can modify the values in the table';...
			   'located above the "Finalizing the results" button.'};
               			   
app.T5L1.Text={'Please click on the "Initialize this tab" button.';'';...
               'In this tab, we finalize the DSF results.First we classify dense objects based on';
			   'the skeleton length to either dislocations or clusters and then the user can do';
			   'manual corrections by getting the skeleton ID of a selected dense object and then assign the';  
			   'object to dislocations, clusters or others. By pushing the "Finalizing the results" button,'; 
			   'the classification will be completed. We can also do two types of post-processing analyses in this'
			   'tab which are (1) Determination of the crystallographic plane of a selected dislocation loop'
			   'and (2) Plotting solute concentration variation with respect to distance'; 'from dislocation skeletons or cluster centers.'};
               
app.T6L1.Text={'Please click on the "Initialize this tab" button.';'';...
               'In this tab, we make videos and save customized figures.';...
			   'For saving a figure, please set the "Title type" to "Intrinsic".'; 'For capturing a video, set the "Title type" to "Fixed".'};
drawnow

app.T1L1.Text={'Welcome to DSF';'This interface is based on I. Ghamarian, L. Yu and E. Marquis, Ultramicroscopy (2020) publication.';'Please put your pos file in the current folder and'; 'start the analysis from tab 1 (Importing pos file).';...
               'Green lamp means DSF is waiting for the user action.';'Yellow lamp means DSF is working and the user must wait.';'Red lamp means DSF cannot continue and the user must fix the mentioned problem.';...
               'In each tab, there are small cyan-color labels on some push-buttons. To run DSF properly,'; 'the user must push these buttons in the order noted by the number written in these labels.';...
			   'Please do not hit the "Enter" button on the keyboard';'when you are done with filling white boxes in all the six tabs.';
			   'Good luck with your DSF analysis!'};
app.T1Lamp1.Color='g';pause(0.001)
               

end