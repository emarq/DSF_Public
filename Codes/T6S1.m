%Tab 6, Slice slide bar
function T6S1(app)

app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)
Center=app.T6S1.Value;
halfThickness=0.5*app.T6EFN11.Value;
Slice_ratioANDlimit_SixthTab(app.T6F1,Center,halfThickness,app);drawnow
Slice_ratioANDlimit_SixthTab(app.T6F2,Center,halfThickness,app);drawnow
Slice_ratioANDlimit_SixthTab(app.T6F3,Center,halfThickness,app);drawnow
Slice_ratioANDlimit_SixthTab(app.T6F4,Center,halfThickness,app);drawnow
Slice_ratioANDlimit_SixthTab(app.T6F5,Center,halfThickness,app);drawnow
app.T6L1.Text='Done!';
app.T6Lamp1.Color='g';pause(0.001)
            
end