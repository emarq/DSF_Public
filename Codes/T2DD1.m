%Tab 2, slice direction drop down 
function T2DD1(app)

app.T2L1.Text='Please wait';
app.T2Lamp1.Color='y';pause(0.001)

value = app.T2DD1.Value;
if strcmpi(value,'x-axis')
    app.T2S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
    app.T2S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
elseif strcmpi(value,'y-axis')
    app.T2S1.Limits=[app.AxisLimits(2,1) app.AxisLimits(2,2)];
    app.T2S1.Value=0.5*(app.AxisLimits(2,1)+app.AxisLimits(2,2));
elseif strcmpi(value,'z-axis')
    app.T2S1.Limits=[app.AxisLimits(3,1) app.AxisLimits(3,2)];
    app.T2S1.Value=0.5*(app.AxisLimits(3,1)+app.AxisLimits(3,2));
end
Reset_Figs(app.T2F2,app);drawnow
Reset_Figs(app.T2F3,app);drawnow
Reset_Figs(app.T2F4,app);drawnow
Reset_Figs(app.T2F5,app);drawnow
Reset_Figs(app.T2F6,app);drawnow

app.T2L1.Text='Done!';
app.T2Lamp1.Color='g';pause(0.001)

end