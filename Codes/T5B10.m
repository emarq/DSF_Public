%Tab 5, Zoom reset pushbutton
function T5B10(app)

app.T5S3.Value=1;
app.T5L1.Text='Please wait';
app.T5Lamp1.Color='y';pause(0.001)
Zoom_ratioANDlimit(app.T5F1,app);drawnow
Zoom_ratioANDlimit(app.T5F2,app);drawnow
Zoom_ratioANDlimit(app.T5F3,app);drawnow
Zoom_ratioANDlimit(app.T5F4,app);drawnow
Zoom_ratioANDlimit(app.T5F5,app);drawnow
Zoom_ratioANDlimit(app.T5F6,app);drawnow
app.T5L1.Text='Done!';
app.T5Lamp1.Color='g';pause(0.001)

end

