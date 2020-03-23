%Tab 6, reset pushbutton
function T6B9(app)

app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)
app.T6DD1.Value='x-axis';
app.T6DD2.Value='z-axis';
app.T6DD3.Value='Azimuth';
app.T6S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
app.T6S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
app.T6S2.Value=0;
app.T6S2previousValue=0;
app.T6S3.Value=1;
Reset_tab6_Figs(app.T6F1,app);drawnow
Reset_tab6_Figs(app.T6F2,app);drawnow
Reset_tab6_Figs(app.T6F3,app);drawnow
Reset_tab6_Figs(app.T6F4,app);drawnow
Reset_tab6_Figs(app.T6F5,app);drawnow
app.T6L1.Text='Done!';
app.T6Lamp1.Color='g';pause(0.001)

end