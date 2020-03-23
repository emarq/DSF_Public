function T6S2(app)

app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)

CurrentValue=app.T6S2.Value;
RotationValue=CurrentValue-app.T6S2previousValue;
app.T6S2previousValue=CurrentValue;

if strcmpi(app.T6DD2.Value,'x-axis')
    Direction=[1 0 0];
elseif strcmpi(app.T6DD2.Value,'y-axis')
    Direction=[0 1 0];
elseif strcmpi(app.T6DD2.Value,'z-axis')
    Direction=[0 0 1];
end
if strcmpi(app.T6DD3.Value,'Azimuth')
    camorbit(app.T6F1,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F2,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F3,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F4,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F5,RotationValue,0,'data',Direction);drawnow
    
elseif strcmpi(app.T6DD3.Value,'Elevation')
    camorbit(app.T6F1,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T6F2,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T6F3,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T6F4,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T6F5,0,RotationValue,'data',Direction);drawnow
    
elseif strcmpi(app.T6DD3.Value,'Azimuth_Reverse')
    camorbit(app.T6F1,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F2,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F3,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F4,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F5,-RotationValue,0,'data',Direction);drawnow
    
elseif strcmpi(app.T6DD3.Value,'Elevation_Reverse')
    camorbit(app.T6F1,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T6F2,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T6F3,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T6F4,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T6F5,0,-RotationValue,'data',Direction);drawnow
    
end
app.T6L1.Text='Done!';
app.T6Lamp1.Color='g';pause(0.001)




end