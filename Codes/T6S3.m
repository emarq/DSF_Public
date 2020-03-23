%Tab 6, Zoom slide bar
function T6S3(app)
app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)
value = app.T6S3.Value;
app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)
zoom(app.T6F1,value);drawnow
zoom(app.T6F2,value);drawnow
zoom(app.T6F3,value);drawnow
zoom(app.T6F4,value);drawnow
zoom(app.T6F5,value);drawnow
app.T6L1.Text='';
app.T6Lamp1.Color='g';pause(0.001)
app.T6L1.Text='Done!';
app.T6Lamp1.Color='g';pause(0.001)
end