%Tab 2, rotation slide bar
function T2S2(app)

app.T2L1.Text='Please wait';
app.T2Lamp1.Color='y';pause(0.001)

CurrentValue=app.T2S2.Value;
RotationValue=CurrentValue-app.T2S2previousValue;
app.T2S2previousValue=CurrentValue;

if strcmpi(app.T2DD2.Value,'x-axis')
    Direction=[1 0 0];
elseif strcmpi(app.T2DD2.Value,'y-axis')
    Direction=[0 1 0];
elseif strcmpi(app.T2DD2.Value,'z-axis')
    Direction=[0 0 1];
end
if strcmpi(app.T2DD3.Value,'Azimuth')
    camorbit(app.T2F2,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T2F3,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T2F4,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T2F5,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T2F6,RotationValue,0,'data',Direction);drawnow
elseif strcmpi(app.T2DD3.Value,'Elevation')
    camorbit(app.T2F2,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T2F3,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T2F4,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T2F5,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T2F6,0,RotationValue,'data',Direction);drawnow
elseif strcmpi(app.T2DD3.Value,'Azimuth_Reverse')
    camorbit(app.T2F2,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T2F3,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T2F4,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T2F5,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T2F6,-RotationValue,0,'data',Direction);drawnow
elseif strcmpi(app.T2DD3.Value,'Elevation_Reverse')
    camorbit(app.T2F2,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T2F3,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T2F4,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T2F5,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T2F6,0,-RotationValue,'data',Direction);drawnow
end
app.T2L1.Text='Done!';
app.T2Lamp1.Color='g';pause(0.001)

end