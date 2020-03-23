%Tab 4, Reset pushbutton
function T4B3(app)

app.T4L1.Text='Please wait';
app.T4Lamp1.Color='y';pause(0.001)
app.T4DD1.Value='x-axis';
app.T4DD2.Value='z-axis';
app.T4DD3.Value='Azimuth';
app.T4S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T4S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
app.T4S2.Value=0;
app.T4S2previousValue=0;
app.T4S3.Value=1;
Reset_Figs(app.T4F11,app);drawnow
Reset_Figs(app.T4F12,app);drawnow
Reset_Figs(app.T4F13,app);drawnow
app.T4L1.Text='Done!';
app.T4Lamp1.Color='g';pause(0.001)

end