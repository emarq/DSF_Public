%Tab 2, reset pushbutton
function T2B2(app)

app.T2L1.Text='Please wait';
app.T2Lamp1.Color='y';pause(0.001)
app.T2DD1.Value='x-axis';
app.T2DD2.Value='z-axis';
app.T2DD3.Value='Azimuth';
app.T2S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T2S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
app.T2S2.Value=0;
app.T2S2previousValue=0;
app.T2S3.Value=1;
Reset_Figs(app.T2F2,app);drawnow
Reset_Figs(app.T2F3,app);drawnow
Reset_Figs(app.T2F4,app);drawnow
Reset_Figs(app.T2F5,app);drawnow
Reset_Figs(app.T2F6,app);drawnow
app.T2L1.Text='Done!';
app.T2Lamp1.Color='g';pause(0.001)

end