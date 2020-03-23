%Tab 1, check box 1
function T1CB1(app)
if app.T1CB1.Value
    app.T1L1.Text={'In general, this parameter affects the Z direction of plots.';'This parameter is very critical for the analysis done in the';
        '"Finding the crystallographic plane of a dislocation loop" panel.'};
    app.T1Lamp1.Color=[1,0.549,0];pause(0.001)
else
    app.T1L1.Text='';
    app.T1Lamp1.Color='g';pause(0.001)    
end
end