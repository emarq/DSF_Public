function Slice_ratioANDlimit_SixthTab_Video(FigH,Center,halfThickness,app)

if strcmpi(app.T6DD1_2.Value,'x-axis')
    xlim(FigH,[Center-halfThickness Center+halfThickness])
    ylim(FigH,[app.AxisLimits(2,1),app.AxisLimits(2,2)])
    zlim(FigH,[app.AxisLimits(3,1),app.AxisLimits(3,2)])
    pbaspect(FigH,[(app.T6EFN11.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
elseif strcmpi(app.T6DD1_2.Value,'y-axis')
    xlim(FigH,[app.AxisLimits(1,1),app.AxisLimits(1,2)])
    ylim(FigH,[Center-halfThickness Center+halfThickness])
    zlim(FigH,[app.AxisLimits(3,1),app.AxisLimits(3,2)])
    pbaspect(FigH,[1 (app.T6EFN11.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
elseif strcmpi(app.T6DD1_2.Value,'z-axis')
    xlim(FigH,[app.AxisLimits(1,1),app.AxisLimits(1,2)])
    ylim(FigH,[app.AxisLimits(2,1),app.AxisLimits(2,2)])
    zlim(FigH,[Center-halfThickness Center+halfThickness])
    pbaspect(FigH,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) (app.T6EFN11.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
end

end