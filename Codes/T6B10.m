%Tab 6, reset zoom pushbutton
function T6B10(app)

app.T6S3.Value=1;
app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)
Zoom_ratioANDlimit(app.T6F1,app);drawnow
Zoom_ratioANDlimit(app.T6F2,app);drawnow
Zoom_ratioANDlimit(app.T6F3,app);drawnow
Zoom_ratioANDlimit(app.T6F4,app);drawnow
Zoom_ratioANDlimit(app.T6F5,app);drawnow
app.T6L1.Text='Done!';
app.T6Lamp1.Color='g';pause(0.001)

end