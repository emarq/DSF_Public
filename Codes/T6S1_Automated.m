function T6S1_Automated(app,Center)            
        
halfThickness=0.5*app.T6EFN11.Value;
Slice_ratioANDlimit_SixthTab_Video(app.T6F1,Center,halfThickness,app);drawnow
Slice_ratioANDlimit_SixthTab_Video(app.T6F2,Center,halfThickness,app);drawnow
Slice_ratioANDlimit_SixthTab_Video(app.T6F3,Center,halfThickness,app);drawnow
Slice_ratioANDlimit_SixthTab_Video(app.T6F4,Center,halfThickness,app);drawnow
Slice_ratioANDlimit_SixthTab_Video(app.T6F5,Center,halfThickness,app);drawnow

end