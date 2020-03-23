%Tab 5, Rotation slide bar
function T5S2(app)

app.T5L1.Text='Please wait';
app.T5Lamp1.Color='y';pause(0.001)

CurrentValue=app.T5S2.Value;
RotationValue=CurrentValue-app.T5S2previousValue;
app.T5S2previousValue=CurrentValue;

if strcmpi(app.T5DD2.Value,'x-axis')
    Direction=[1 0 0];
elseif strcmpi(app.T5DD2.Value,'y-axis')
    Direction=[0 1 0];
elseif strcmpi(app.T5DD2.Value,'z-axis')
    Direction=[0 0 1];
end
if strcmpi(app.T5DD3.Value,'Azimuth')
    camorbit(app.T5F1,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F2,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F3,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F4,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F5,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F6,RotationValue,0,'data',Direction);drawnow
elseif strcmpi(app.T5DD3.Value,'Elevation')
    camorbit(app.T5F1,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T5F2,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T5F3,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T5F4,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T5F5,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T5F6,0,RotationValue,'data',Direction);drawnow
elseif strcmpi(app.T5DD3.Value,'Azimuth_Reverse')
    camorbit(app.T5F1,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F2,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F3,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F4,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F5,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T5F6,-RotationValue,0,'data',Direction);drawnow
elseif strcmpi(app.T5DD3.Value,'Elevation_Reverse')
    camorbit(app.T5F1,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T5F2,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T5F3,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T5F4,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T5F5,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T5F6,0,-RotationValue,'data',Direction);drawnow
end

app.T5L1.Text='Done!';
app.T5Lamp1.Color='g';pause(0.001)

end