%Tab 4, Rotation slide bar
function T4S2(app)

app.T4L1.Text='Please wait';
app.T4Lamp1.Color='y';pause(0.001)

CurrentValue=app.T4S2.Value;
RotationValue=CurrentValue-app.T4S2previousValue;
app.T4S2previousValue=CurrentValue;

if strcmpi(app.T4DD2.Value,'x-axis')
    Direction=[1 0 0];
elseif strcmpi(app.T4DD2.Value,'y-axis')
    Direction=[0 1 0];
elseif strcmpi(app.T4DD2.Value,'z-axis')
    Direction=[0 0 1];
end

if strcmpi(app.T4DD4.Value,'All (Plots 11-13)')
    if strcmpi(app.T4DD3.Value,'Azimuth')
        camorbit(app.T4F11,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F12,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F13,RotationValue,0,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Elevation')
        camorbit(app.T4F11,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F12,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F13,0,RotationValue,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Azimuth_Reverse')
        camorbit(app.T4F11,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F12,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F13,-RotationValue,0,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Elevation_Reverse')
        camorbit(app.T4F11,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F12,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F13,0,-RotationValue,'data',Direction);drawnow
    end

elseif strcmpi(app.T4DD4.Value,'Selected (Plot 14)')    
    if strcmpi(app.T4DD3.Value,'Azimuth')
        camorbit(app.T4F14,RotationValue,0,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Elevation')
        camorbit(app.T4F14,0,RotationValue,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Azimuth_Reverse')
        camorbit(app.T4F14,-RotationValue,0,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Elevation_Reverse')
        camorbit(app.T4F14,0,-RotationValue,'data',Direction);drawnow
    end    
elseif strcmpi(app.T4DD4.Value,'Skeleton (Plots 1-10)')
    if strcmpi(app.T4DD3.Value,'Azimuth')
        camorbit(app.T4F1,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F2,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F3,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F4,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F6,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F7,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F8,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F9,RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F10,RotationValue,0,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Elevation')
        camorbit(app.T4F1,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F2,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F3,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F4,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F6,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F7,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F8,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F9,0,RotationValue,'data',Direction);drawnow
        camorbit(app.T4F10,0,RotationValue,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Azimuth_Reverse')
        camorbit(app.T4F1,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F2,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F3,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F4,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F6,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F7,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F8,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F9,-RotationValue,0,'data',Direction);drawnow
        camorbit(app.T4F10,-RotationValue,0,'data',Direction);drawnow
    elseif strcmpi(app.T4DD3.Value,'Elevation_Reverse')
        camorbit(app.T4F1,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F2,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F3,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F4,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F6,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F7,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F8,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F9,0,-RotationValue,'data',Direction);drawnow
        camorbit(app.T4F10,0,-RotationValue,'data',Direction);drawnow
    end
end
app.T4L1.Text='Done!';
app.T4Lamp1.Color='g';pause(0.001)

end