%Tab 3, Slice direction drop down
function T3DD1(app)

app.T3L1.Text='Please wait';
app.T3Lamp1.Color='y';pause(0.001)

value = app.T3DD1.Value;
if strcmpi(value,'x-axis')
    app.T3S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
    app.T3S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
elseif strcmpi(value,'y-axis')
    app.T3S1.Limits=[app.AxisLimits(2,1) app.AxisLimits(2,2)];
    app.T3S1.Value=0.5*(app.AxisLimits(2,1)+app.AxisLimits(2,2));
elseif strcmpi(value,'z-axis')
    app.T3S1.Limits=[app.AxisLimits(3,1) app.AxisLimits(3,2)];
    app.T3S1.Value=0.5*(app.AxisLimits(3,1)+app.AxisLimits(3,2));
end

Reset_Figs(app.T3F1,app);drawnow
Reset_Figs(app.T3F2,app);drawnow
Reset_Figs(app.T3F3,app);drawnow

app.T3L1.Text='Done!';
app.T3Lamp1.Color='g';pause(0.001)

end