%Tab 1, Slice direction drop down 
function T1DD1(app)

app.T1L1.Text='Please wait';
app.T1Lamp1.Color='y';pause(0.001)
if strcmpi(app.T1DD1.Value,'x-axis')
    app.T1S1.Limits=[app.AxisLimits(1,1) app.AxisLimits(1,2)];
    app.T1S1.Value=0.5*(app.AxisLimits(1,1)+app.AxisLimits(1,2));
elseif strcmpi(app.T1DD1.Value,'y-axis')
    app.T1S1.Limits=[app.AxisLimits(2,1) app.AxisLimits(2,2)];
    app.T1S1.Value=0.5*(app.AxisLimits(2,1)+app.AxisLimits(2,2));
elseif strcmpi(app.T1DD1.Value,'z-axis')
    app.T1S1.Limits=[app.AxisLimits(3,1) app.AxisLimits(3,2)];
    app.T1S1.Value=0.5*(app.AxisLimits(3,1)+app.AxisLimits(3,2));
end

xlim(app.T1F1,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T1F1,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T1F1,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
pbaspect(app.T1F1,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
view(app.T1F1,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))

app.T1L1.Text='Done!';
app.T1Lamp1.Color='g';pause(0.001)
end