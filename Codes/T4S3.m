%Tab 4, Zoom slide bar
function T4S3(app)

value = app.T4S3.Value;
app.T4L1.Text='Please wait';
app.T4Lamp1.Color='y';pause(0.001)
zoom(app.T4F11,value);drawnow
zoom(app.T4F12,value);drawnow
zoom(app.T4F13,value);drawnow
app.T4L1.Text='Done!';
app.T4Lamp1.Color='g';pause(0.001)

end
