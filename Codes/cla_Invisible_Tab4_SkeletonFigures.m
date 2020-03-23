%clear and invisible skeleton figures
function cla_Invisible_Tab4_SkeletonFigures(app)

cla(app.T4F1,'reset')
cla(app.T4F2,'reset')
cla(app.T4F3,'reset')
cla(app.T4F4,'reset')
cla(app.T4F5,'reset')
cla(app.T4F6,'reset')
cla(app.T4F7,'reset')
cla(app.T4F8,'reset')
cla(app.T4F9,'reset')
cla(app.T4F10,'reset')

app.T4F1.Visible=false;
app.T4F2.Visible=false;
app.T4F3.Visible=false;
app.T4F4.Visible=false;
app.T4F5.Visible=false;
app.T4F6.Visible=false;
app.T4F7.Visible=false;
app.T4F8.Visible=false;
app.T4F9.Visible=false;
app.T4F10.Visible=false;

app.Label_T4F4.Visible=false;
app.Label_T4F4_2.Visible=false;

app.Label_T4F6_1.Visible=false;
app.Label_T4F6_2.Visible=false;
app.Label_T4F6_3.Visible=false;
drawnow

end