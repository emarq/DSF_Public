%Tab 5, Zoom slide bar
function T5S3(app)

value = app.T5S3.Value;
app.T5L1.Text='Please wait';
app.T5Lamp1.Color='y';pause(0.001)
zoom(app.T5F1,value);drawnow
zoom(app.T5F2,value);drawnow
zoom(app.T5F3,value);drawnow
zoom(app.T5F4,value);drawnow
zoom(app.T5F5,value);drawnow
zoom(app.T5F6,value);drawnow
app.T5L1.Text='Done!';
app.T5Lamp1.Color='g';pause(0.001)
            
end