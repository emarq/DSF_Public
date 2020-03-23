%Tab 1, zoom slide bar
function T1S3(app)
app.T1L1.Text='Please wait';
app.T1Lamp1.Color='y';pause(0.001)
value = app.T1S3.Value;
zoom(app.T1F1,value);drawnow
app.T1L1.Text='Done!';
app.T1Lamp1.Color='g';pause(0.001)

end