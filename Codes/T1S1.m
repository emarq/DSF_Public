%Tab 1, slice slide bar
function T1S1(app)

app.T1L1.Text='Please wait';
app.T1Lamp1.Color='y';pause(0.001)

Center = app.T1S1.Value;
halfThickness=0.5*app.T1EFN1.Value;
if strcmpi(app.T1DD1.Value,'x-axis')
    xlim(app.T1F1,[Center-halfThickness Center+halfThickness])
    pbaspect(app.T1F1,[(app.T1EFN1.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
elseif strcmpi(app.T1DD1.Value,'y-axis')
    ylim(app.T1F1,[Center-halfThickness Center+halfThickness])
    pbaspect(app.T1F1,[1 (app.T1EFN1.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
elseif strcmpi(app.T1DD1.Value,'z-axis')
    zlim(app.T1F1,[Center-halfThickness Center+halfThickness])
    pbaspect(app.T1F1,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) (app.T1EFN1.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
end

app.T1L1.Text='Done!';
app.T1Lamp1.Color='g';pause(0.001)

end