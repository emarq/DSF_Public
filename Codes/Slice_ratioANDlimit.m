function Slice_ratioANDlimit(FigH,Center,halfThickness,app,DD1Value)

if strcmpi(DD1Value,'x-axis')
    xlim(FigH,[Center-halfThickness Center+halfThickness])
    ylim(FigH,[app.AxisLimits(2,1),app.AxisLimits(2,2)])
    zlim(FigH,[app.AxisLimits(3,1),app.AxisLimits(3,2)])
    pbaspect(FigH,[(app.T1EFN1.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
elseif strcmpi(DD1Value,'y-axis')
    xlim(FigH,[app.AxisLimits(1,1),app.AxisLimits(1,2)])
    ylim(FigH,[Center-halfThickness Center+halfThickness])
    zlim(FigH,[app.AxisLimits(3,1),app.AxisLimits(3,2)])
    pbaspect(FigH,[1 (app.T1EFN1.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
elseif strcmpi(DD1Value,'z-axis')
    xlim(FigH,[app.AxisLimits(1,1),app.AxisLimits(1,2)])
    ylim(FigH,[app.AxisLimits(2,1),app.AxisLimits(2,2)])
    zlim(FigH,[Center-halfThickness Center+halfThickness])
    pbaspect(FigH,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) (app.T1EFN1.Value/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))])
end

end
