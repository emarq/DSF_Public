%Tab 2, Reseting zoom pushbutton
function T2B3(app)

app.T2S3.Value=1;
app.T2L1.Text='Please wait';
app.T2Lamp1.Color='y';pause(0.001)
Zoom_ratioANDlimit(app.T2F2,app);drawnow
Zoom_ratioANDlimit(app.T2F3,app);drawnow
Zoom_ratioANDlimit(app.T2F4,app);drawnow
Zoom_ratioANDlimit(app.T2F5,app);drawnow
Zoom_ratioANDlimit(app.T2F6,app);drawnow
app.T2L1.Text='Done!';
app.T2Lamp1.Color='g';pause(0.001)

end