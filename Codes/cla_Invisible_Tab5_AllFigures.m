%clear and invisible all plots in Tab 5
function cla_Invisible_Tab5_AllFigures(app)

cla(app.T5F1,'reset')
cla(app.T5F2,'reset')
cla(app.T5F3,'reset')
cla(app.T5F4,'reset')
cla(app.T5F5,'reset')
cla(app.T5F6,'reset')
cla(app.T5F7,'reset')
cla(app.T5F8,'reset')
cla(app.T5F9,'reset')
cla(app.T5F10,'reset')
cla(app.T5F11,'reset')

app.T5F1.Visible=false;
app.T5F2.Visible=false;
app.T5F3.Visible=false;
app.T5F4.Visible=false;
app.T5F5.Visible=false;
app.T5F6.Visible=false;
app.T5F7.Visible=false;
app.T5F8.Visible=false;
app.T5F9.Visible=false;
app.T5F10.Visible=false;
app.T5F11.Visible=false;

app.T5EFT2.Value='';
app.T5EFT3.Value='';
app.T5EFT4.Value='';
app.T5EFT5.Value='';
app.T5EFT10.Value='';

app.T5P2.Visible=false;%Applying corrections
app.T5P4.Visible=false;%composition
app.T5P5.Visible=false;%orientation
app.T5P6.Visible=false;%angle between two dislocations
app.T5P8.Visible=false;%plot combined IPF plot
app.T5B3.Visible=false;%plot selected skeletons pushbutton
app.T5EFT2.Visible=false;%SkeletonIDs box
app.T5EFT2Label.Visible=false;
app.T5EFT5.Visible=false;%Skeleton as others box
%app.T5EFT5Label.Visible=false;

app.T5T1.Visible=false;
app.T5T1.Data=array2table([]);

app.T5T2.Visible=false;
app.T5T2.Data=array2table([]);

app.T5EFT11.Value='';
app.T5EFT12.Value='';
app.T5RB1Hidden.Value=true;

app.T5EFT14.Value='';

app.T5EFT15.Value='';

app.T5EFT16.Value='';


drawnow

end