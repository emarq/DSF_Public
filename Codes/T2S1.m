%Tab2, Slice slide bar
function T2S1(app)

app.T2L1.Text='Please wait';
app.T2Lamp1.Color='y';pause(0.001)

app.T2L1.Text='Please wait';
app.T2Lamp1.Color='y';pause(0.001)
Center = app.T2S1.Value;
halfThickness=0.5*app.T2EFN1.Value;
Slice_ratioANDlimit(app.T2F2,Center,halfThickness,app,app.T2DD1.Value);drawnow
Slice_ratioANDlimit(app.T2F3,Center,halfThickness,app,app.T2DD1.Value);drawnow
Slice_ratioANDlimit(app.T2F4,Center,halfThickness,app,app.T2DD1.Value);drawnow
Slice_ratioANDlimit(app.T2F5,Center,halfThickness,app,app.T2DD1.Value);drawnow
Slice_ratioANDlimit(app.T2F6,Center,halfThickness,app,app.T2DD1.Value);drawnow
app.T2L1.Text='Done!';
app.T2Lamp1.Color='g';pause(0.001)

end