%Tab 5, Slice slide bar
function T5S1(app)

app.T5L1.Text='Please wait';
app.T5Lamp1.Color='y';pause(0.001)
Center=app.T5S1.Value;
halfThickness=0.5*app.T5EFN11.Value;
Slice_ratioANDlimit(app.T5F1,Center,halfThickness,app,app.T5DD1.Value);drawnow
Slice_ratioANDlimit(app.T5F2,Center,halfThickness,app,app.T5DD1.Value);drawnow
Slice_ratioANDlimit(app.T5F3,Center,halfThickness,app,app.T5DD1.Value);drawnow
Slice_ratioANDlimit(app.T5F4,Center,halfThickness,app,app.T5DD1.Value);drawnow
Slice_ratioANDlimit(app.T5F5,Center,halfThickness,app,app.T5DD1.Value);drawnow
Slice_ratioANDlimit(app.T5F6,Center,halfThickness,app,app.T5DD1.Value);drawnow
app.T5L1.Text='Done!';
app.T5Lamp1.Color='g';pause(0.001)
            
end