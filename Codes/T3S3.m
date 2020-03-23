%Tab 3, Zoom slide bar
function T3S3(app)

value = app.T3S3.Value;
app.T3L1.Text='Please wait';
app.T3Lamp1.Color='y';pause(0.001)
zoom(app.T3F1,value);drawnow
zoom(app.T3F2,value);drawnow
zoom(app.T3F3,value);drawnow
app.T3L1.Text='Done!';
app.T3Lamp1.Color='g';pause(0.001)

end