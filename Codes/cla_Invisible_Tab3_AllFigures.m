function cla_Invisible_Tab3_AllFigures(app)

cla(app.T3F1,'reset')
cla(app.T3F2,'reset')
cla(app.T3F3,'reset')

app.T3F1.Visible=false;
app.T3F2.Visible=false;
app.T3F3.Visible=false;

app.T3EFT1.Value='';
app.T3EFT2.Value='';
app.T3EFT3.Value='';

app.T3EFN3.Value='';
app.T3EFN4.Value='';
app.T3EFN5.Value='';

app.T3EFT5.Value='';
app.T3EFT6.Value='';
app.T3EFT7.Value='';
app.T3EFT8.Value='';

end