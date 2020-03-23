%Tab 5, reset pushbutton
function T5B9(app)

app.T5L1.Text='Please wait';
app.T5Lamp1.Color='y';pause(0.001)
app.T5DD1.Value='x-axis';
app.T5DD2.Value='z-axis';
app.T5DD3.Value='Azimuth';
app.T5S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T5S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
app.T5S2.Value=0;
app.T5S2previousValue=0;
app.T5S3.Value=1;
Reset_Figs(app.T5F1,app);drawnow
Reset_Figs(app.T5F2,app);drawnow
Reset_Figs(app.T5F3,app);drawnow
Reset_Figs(app.T5F4,app);drawnow
Reset_Figs(app.T5F5,app);drawnow
Reset_Figs(app.T5F6,app);drawnow
app.T5L1.Text='Done!';
app.T5Lamp1.Color='g';pause(0.001)

end