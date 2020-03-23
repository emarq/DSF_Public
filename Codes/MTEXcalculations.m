%Tab 5, doing calculations to find the crystallographic plane of a
%dislocation loop
function out=MTEXcalculations(i,j,k,cs,Ori,Pnormal,app,SolNum,Color)

    m=Miller(i,j,k,cs);
    mRotated=Ori*m;
    v=vector3d(mRotated);
    MTEXdir=v.xyz;
    
    theta=rad2deg(acos(((Pnormal*MTEXdir')')./(vecnorm(MTEXdir(:,1:3),2,2).*norm(Pnormal))));
    thetaRounded=round(theta,2);
    out=sortrows([i,j,k,thetaRounded],4);
        
    m=Miller((out(SolNum,1)),(out(SolNum,2)),(out(SolNum,3)),cs);
    v=vector3d(m);
    f1=figure('Visible','off');
    plotIPDF(Ori,v,'Position', [2000 2000 380 380],'MarkerColor',Color)
    
    PosFileName=char(app.T1EFT1.Value);
    NameOfElementOfInterest=char(app.T1EFT2.Value); 
    dID=str2num(char(app.T5EFT12.Value));
    
    EA=str2num(char(app.T5EFT11.Value));
    EulerString=[num2str(EA(1,1)) '_' num2str(EA(1,2)) '_' num2str(EA(1,3))];
    
    
    Deviation=num2str(out(SolNum,4));
    
    PATH=[PosFileName,'/4_FinalResults/IPFplots/IPFplot_' PosFileName '_' NameOfElementOfInterest '_DisID_' num2str(dID) '_Euler_' EulerString '_SolutionNumber_' num2str(SolNum) '_Deviation_' Deviation '.tif']; 

    saveas(f1,PATH)
    close(f1)
    
    b=imread(PATH);
    title(app.T5F11, []);
    xlabel(app.T5F11, []);
    ylabel(app.T5F11, []);
    app.T5F11.XAxis.TickLabels = {};
    app.T5F11.YAxis.TickLabels = {};
    imshow(b,'Parent',app.T5F11,...
        'XData', [1 app.T5F11.Position(3)], ...
        'YData', [1 app.T5F11.Position(4)]);
   
    movefile('IPFplotData.mat',['DisID_' num2str(dID) '.mat'])
    movefile(['DisID_' num2str(dID) '.mat'],[PosFileName,'/4_FinalResults/IPFplotData/'])
    
    

end