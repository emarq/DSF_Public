%Tab 4, Slice slide bar
function T4S1(app)

app.T4L1.Text='Please wait';
app.T4Lamp1.Color='y';pause(0.001)
Center = app.T4S1.Value;
halfThickness=0.5*app.T4EFN1.Value;
Slice_ratioANDlimit(app.T4F11,Center,halfThickness,app,app.T4DD1.Value);drawnow
Slice_ratioANDlimit(app.T4F12,Center,halfThickness,app,app.T4DD1.Value);drawnow
Slice_ratioANDlimit(app.T4F13,Center,halfThickness,app,app.T4DD1.Value);drawnow

app.T4L1.Text='Done!';
app.T4Lamp1.Color='g';pause(0.001)

end