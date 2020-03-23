%Tab 6 clear all plots
function cla_Tab6_AllFigures(app)

cla(app.T6F1,'reset')
app.T6F1.Visible=false;

cla(app.T6F2,'reset')
app.T6F2.Visible=false;

cla(app.T6F3,'reset')
app.T6F3.Visible=false;

cla(app.T6F4,'reset')
app.T6F4.Visible=false;

cla(app.T6F4_2,'reset')
app.T6F4_2.Visible=false;

cla(app.T6F5,'reset')
app.T6F5.Visible=false;

app.T6L11.Text='';
app.T6L12.Text='';
app.T6L13.Text='';
app.T6L15.Text='';

app.T6EFN11.Value=8;
app.T6DD1.Value='x-axis';
app.T6DD2.Value='z-axis';
app.T6DD3.Value='Azimuth';

app.T6EFT0.Value='';

app.T6P6.Visible=false;
app.T6P7.Visible=false;




end