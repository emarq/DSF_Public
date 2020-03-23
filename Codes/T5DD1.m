%Tab 5, Slice direction drop down
function T5DD1(app)

app.T5L1.Text='Please wait';
app.T5Lamp1.Color='y';pause(0.001)
value = app.T5DD1.Value;
if strcmpi(value,'x-axis')
    app.T5S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
    app.T5S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
elseif strcmpi(value,'y-axis')
    app.T5S1.Limits=[app.AxisLimits(2,1) app.AxisLimits(2,2)];
    app.T5S1.Value=0.5*(app.AxisLimits(2,1)+app.AxisLimits(2,2));
elseif strcmpi(value,'z-axis')
    app.T5S1.Limits=[app.AxisLimits(3,1) app.AxisLimits(3,2)];
    app.T5S1.Value=0.5*(app.AxisLimits(3,1)+app.AxisLimits(3,2));
end

Reset_Figs(app.T5F1,app);drawnow
Reset_Figs(app.T5F2,app);drawnow
Reset_Figs(app.T5F3,app);drawnow
Reset_Figs(app.T5F4,app);drawnow
Reset_Figs(app.T5F5,app);drawnow
Reset_Figs(app.T5F6,app);drawnow

app.T5L1.Text='Done!';
app.T5Lamp1.Color='g';pause(0.001)
            
end