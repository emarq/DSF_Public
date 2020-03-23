%This function is used to reset figures 
%Inputs are figure and app
function Reset_Figs(FigH,app)
    zoom(FigH,1)
    xlim(FigH,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(FigH,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(FigH,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    pbaspect(FigH,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
    view(FigH,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
end