%Tab 4, Slice direction drop down
function T4DD1(app)


app.T4L1.Text='Please wait';
app.T4Lamp1.Color='y';pause(0.001)
value = app.T4DD1.Value;
if strcmpi(value,'x-axis')
    app.T4S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
    app.T4S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
elseif strcmpi(value,'y-axis')
    app.T4S1.Limits=[app.AxisLimits(2,1) app.AxisLimits(2,2)];
    app.T4S1.Value=0.5*(app.AxisLimits(2,1)+app.AxisLimits(2,2));
elseif strcmpi(value,'z-axis')
    app.T4S1.Limits=[app.AxisLimits(3,1) app.AxisLimits(3,2)];
    app.T4S1.Value=0.5*(app.AxisLimits(3,1)+app.AxisLimits(3,2));
end

Reset_Figs(app.T4F11,app);drawnow
Reset_Figs(app.T4F12,app);drawnow
Reset_Figs(app.T4F13,app);drawnow
app.T4L1.Text='Done!';
app.T4Lamp1.Color='g';pause(0.001)
end