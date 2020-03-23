function T6S2_Automated(app,RotationValue)

if strcmpi(app.T6DD2_2.Value,'x-axis')
    Direction=[1 0 0];
elseif strcmpi(app.T6DD2_2.Value,'y-axis')
    Direction=[0 1 0];
elseif strcmpi(app.T6DD2_2.Value,'z-axis')
    Direction=[0 0 1];
end
if strcmpi(app.T6DD3_2.Value,'Azimuth')
    camorbit(app.T6F1,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F2,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F3,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F4,RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F5,RotationValue,0,'data',Direction);drawnow
    
elseif strcmpi(app.T6DD3_2.Value,'Elevation')
    camorbit(app.T6F1,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T6F2,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T6F3,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T6F4,0,RotationValue,'data',Direction);drawnow
    camorbit(app.T6F5,0,RotationValue,'data',Direction);drawnow
    
elseif strcmpi(app.T6DD3_2.Value,'Azimuth_Reverse')
    camorbit(app.T6F1,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F2,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F3,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F4,-RotationValue,0,'data',Direction);drawnow
    camorbit(app.T6F5,-RotationValue,0,'data',Direction);drawnow
    
elseif strcmpi(app.T6DD3_2.Value,'Elevation_Reverse')
    camorbit(app.T6F1,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T6F2,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T6F3,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T6F4,0,-RotationValue,'data',Direction);drawnow
    camorbit(app.T6F5,0,-RotationValue,'data',Direction);drawnow
    
end

end