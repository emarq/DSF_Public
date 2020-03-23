%Tab1, reset zoom pushbutton
function T1B3(app)

app.T1L1.Text='Please wait';
app.T1Lamp1.Color='y';pause(0.001)
app.T1S3.Value=1;
xlim(app.T1F1,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T1F1,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T1F1,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
pbaspect(app.T1F1,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
app.T1L1.Text='Done!';
app.T1Lamp1.Color='g';pause(0.001)
            
end