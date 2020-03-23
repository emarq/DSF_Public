%Tab 3, Slice slide bar
function T3S1(app)

app.T3L1.Text='Please wait';
app.T3Lamp1.Color='y';pause(0.001)
Center = app.T3S1.Value;
halfThickness=0.5*app.T3EFN1.Value;
Slice_ratioANDlimit(app.T3F1,Center,halfThickness,app,app.T3DD1.Value);drawnow
Slice_ratioANDlimit(app.T3F2,Center,halfThickness,app,app.T3DD1.Value);drawnow
Slice_ratioANDlimit(app.T3F3,Center,halfThickness,app,app.T3DD1.Value);drawnow
app.T3L1.Text='Done!';
app.T3Lamp1.Color='g';pause(0.001)

end