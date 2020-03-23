%Tab 3, Rotation slide bar
function T3S2(app)

app.T3L1.Text='Please wait';
app.T3Lamp1.Color='y';pause(0.001)
CurrentValue=app.T3S2.Value;
RotationValue=CurrentValue-app.T3S2previousValue;
app.T3S2previousValue=CurrentValue;

if strcmpi(app.T3DD2.Value,'x-axis')
    Direction=[1 0 0];
elseif strcmpi(app.T3DD2.Value,'y-axis')
    Direction=[0 1 0];
elseif strcmpi(app.T3DD2.Value,'z-axis')
    Direction=[0 0 1];
end
if strcmpi(app.T3DD3.Value,'Azimuth')
    camorbit(app.T3F1,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T3F2,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T3F3,RotationValue,0,'data',Direction);drawnow
elseif strcmpi(app.T3DD3.Value,'Elevation')
    camorbit(app.T3F1,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T3F2,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T3F3,0,RotationValue,'data',Direction);drawnow
elseif strcmpi(app.T3DD3.Value,'Azimuth_Reverse')
    camorbit(app.T3F1,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T3F2,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T3F3,-RotationValue,0,'data',Direction);drawnow
elseif strcmpi(app.T3DD3.Value,'Elevation_Reverse')
    camorbit(app.T3F1,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T3F2,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T3F3,0,-RotationValue,'data',Direction);drawnow
end
app.T3L1.Text='Done!';
app.T3Lamp1.Color='g';pause(0.001)
end