%Tab1, rotation slide bar
function T1S2(app)

app.T1L1.Text='Please wait';
app.T1Lamp1.Color='y';pause(0.001)

CurrentValue=app.T1S2.Value;

RotationValue=CurrentValue-app.T1S2previousValue;
app.T1S2previousValue=CurrentValue;
if strcmpi(app.T1DD2.Value,'x-axis')
    Direction=[1 0 0];
elseif strcmpi(app.T1DD2.Value,'y-axis')
    Direction=[0 1 0];
elseif strcmpi(app.T1DD2.Value,'z-axis')
    Direction=[0 0 1];
end
if strcmpi(app.T1DD3.Value,'Azimuth')
    camorbit(app.T1F1,RotationValue,0,'data',Direction)
elseif strcmpi(app.T1DD3.Value,'Elevation')
    camorbit(app.T1F1,0,RotationValue,'data',Direction)
elseif strcmpi(app.T1DD3.Value,'Azimuth_Reverse')
    camorbit(app.T1F1,-RotationValue,0,'data',Direction)
elseif strcmpi(app.T1DD3.Value,'Elevation_Reverse')
    camorbit(app.T1F1,0,-RotationValue,'data',Direction)
end
drawnow



app.T1L1.Text='Done!';
app.T1Lamp1.Color='g';pause(0.001)

end