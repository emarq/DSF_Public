%Tab 6, slice direction drop down
function T6DD1(app)

app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)
value = app.T6DD1.Value;
if strcmpi(value,'x-axis')
    app.T6S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
    app.T6S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
elseif strcmpi(value,'y-axis')
    app.T6S1.Limits=[app.AxisLimits(2,1) app.AxisLimits(2,2)];
    app.T6S1.Value=0.5*(app.AxisLimits(2,1)+app.AxisLimits(2,2));
elseif strcmpi(value,'z-axis')
    app.T6S1.Limits=[app.AxisLimits(3,1) app.AxisLimits(3,2)];
    app.T6S1.Value=0.5*(app.AxisLimits(3,1)+app.AxisLimits(3,2));
end
Reset_tab6_Figs(app.T6F1,app);drawnow
Reset_tab6_Figs(app.T6F2,app);drawnow
Reset_tab6_Figs(app.T6F3,app);drawnow
Reset_tab6_Figs(app.T6F4,app);drawnow
Reset_tab6_Figs(app.T6F5,app);drawnow
app.T6L1.Text='Done!';
app.T6Lamp1.Color='g';pause(0.001)
            
end