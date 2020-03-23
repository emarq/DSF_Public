%Tab 1, check box 2
function T1CB2(app)
 if app.T1CB2.Value
    app.T1L1.Text={'If the dataset is too large and the plots of the original dataset are like a solid black box,';
                   'you can reduce the value of this box. This value will affect the following plots:';
                   'Tab 1: Figure 1';
                   'Tab 2: Figure 2 (original dataset) and Figure 3 (detected dense objects and noise) from the left side';
                   'Tab 3: Figure 1 from the left side';
                   'Tab 5: Figure 1 from the left side';
                   'Tab 6: Figure 1 from the left side'};
    app.T1Lamp1.Color=[1,0.549,0];pause(0.001)
else
    app.T1L1.Text='';
    app.T1Lamp1.Color='g';pause(0.001)    
end
end