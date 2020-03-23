function T6B9_Automated(app)

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
            
            
end