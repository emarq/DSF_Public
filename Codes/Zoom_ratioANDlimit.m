%Reseting figure limits and aspect ratio to their initial values
function Zoom_ratioANDlimit(FigH,app)
    xlim(FigH,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(FigH,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(FigH,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    pbaspect(FigH,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
end