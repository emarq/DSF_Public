%Tab 4, Zoom reset pushbutton
function T4B4(app)

app.T4S3.Value=1;
app.T4L1.Text='Please wait';
app.T4Lamp1.Color='y';pause(0.001)
Zoom_ratioANDlimit(app.T4F11,app);drawnow
Zoom_ratioANDlimit(app.T4F12,app);drawnow
Zoom_ratioANDlimit(app.T4F13,app);drawnow
app.T4L1.Text='Done!';
app.T4Lamp1.Color='g';pause(0.001)

end