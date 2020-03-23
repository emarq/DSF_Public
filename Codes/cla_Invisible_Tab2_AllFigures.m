%Clear and invisible all Tab 2 figures
function cla_Invisible_Tab2_AllFigures(app)


cla(app.T2F1,'reset')
cla(app.T2F2,'reset')
cla(app.T2F3,'reset')
cla(app.T2F4,'reset')
cla(app.T2F5,'reset')
cla(app.T2F6,'reset')

app.T2F1.Visible=false;
app.T2F2.Visible=false;
app.T2F3.Visible=false;
app.T2F4.Visible=false;
app.T2F5.Visible=false;
app.T2F6.Visible=false;

end