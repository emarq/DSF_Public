%Tab 6, Plot pushbutton
function T6B2(app)


app.T6L1.Text='Please wait';
app.T6Lamp1.Color='y';pause(0.001)

Message=Tab6_CheckError_PlotPushbutton(app);
if ~isempty(Message)
    app.T6L1.Text=Message;
    app.T6Lamp1.Color='r';
    return
end

selectedButton = app.T6BG4.SelectedObject;
T=selectedButton.Text;
if strcmp(T,'Intrinsic')
    uistackTop(app,app.T6P0,app.T6F4);%app,parent,children going up
elseif strcmp(T,'Fixed')
    axis(app.T6F4_2,'off')
    app.T6F4_2.BackgroundColor=[1 1 1];
    uistackTop(app,app.T6P0,app.T6F4_2);%app,parent,children going up
elseif strcmp(T,'None')
    uistackTop(app,app.T6P0,app.T6F4);%app,parent,children going up
end

Clusters=app.Clusters;
Dislocations=app.Dislocations;
Others=app.Others;
Interest=app.Interest;
PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

if ~(app.T6CB30.Value)
    app.T6L1.Text={'Plotting the original dataset';'Please wait'};pause(0.001)
    cla(app.T6F1,'reset')
    
    MaxNumAtomToPlot=str2double(char(app.T1EFT4.Value));
    if size(Interest,1)>MaxNumAtomToPlot   %if we have more than 250,000 atom of interest, we only present
        rng(7,'twister');%To ensure the randperm generates the same number array for plots T1F1 and T2F2
        INDEX=randperm(size(Interest,1),MaxNumAtomToPlot);
        plot3(app.T6F1,Interest(INDEX,1),Interest(INDEX,2),Interest(INDEX,3),'.','MarkerSize',str2num(char(app.T6EFT1.Value)),'MarkerEdgeColor',str2num(char(app.T6EFT2.Value)))
        T={[num2str(size(Interest,1)) ' ' NameOfElementOfInterest ' atoms in the original dataset'],['Only ' num2str(MaxNumAtomToPlot) ' of atoms are randomly shown (~' num2str(round(100*MaxNumAtomToPlot/size(Interest,1)),4) '%)']};
        if app.T6BG6_Intrinsic.Value
            title(app.T6F1,T);
        elseif app.T6BG6_Fixed.Value
            app.T6L11.Text=T;
        end
        view(app.T6F1,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
    else
        plot3(app.T6F1,Interest(:,1),Interest(:,2),Interest(:,3),'.','MarkerSize',str2num(char(app.T6EFT1.Value)),'MarkerEdgeColor',str2num(char(app.T6EFT2.Value)))
        T=[num2str(size(Interest,1)) ' ' NameOfElementOfInterest ' atoms in the original dataset'];
        if app.T6BG6_Intrinsic.Value
            title(app.T6F1,T);
        elseif app.T6BG6_Fixed.Value
            app.T6L11.Text=T;
        end
        view(app.T6F1,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
    end
    
    app.T6F1.FontSize=str2num(char(app.T6EFT3.Value));
    if app.T6BG6_Intrinsic.Value
        app.T6F1.TitleFontSizeMultiplier=str2num(char(app.T6EFT4.Value));
    elseif app.T6BG6_Fixed.Value
        app.T6L11.FontSize=floor((str2num(char(app.T6EFT3.Value)))*(str2num(char(app.T6EFT4.Value))));%FontSize*FontSizeMultiplier
    end
    xlabel(app.T6F1,'X (nm)')
    ylabel(app.T6F1,'Y (nm)')
    zlabel(app.T6F1,'Z (nm)')
    if app.T6CB2.Value==0
        axis(app.T6F1,'off')
    end
    app.T6F1.BackgroundColor=[1 1 1];
    xlim(app.T6F1,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T6F1,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T6F1,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    pbaspect(app.T6F1,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
    
    hold(app.T6F1,'on')
    if app.T6CB4.Value==1
        %put scalebar
        transfer=str2num(char(app.T6EFT5.Value));
        xc=app.AxisLimits(1,1)+transfer(1,1);
        yc=app.AxisLimits(2,1)+transfer(1,2);
        zc=app.AxisLimits(3,2)-transfer(1,3);
        w=str2num(char(app.T6EFT6.Value));  %Length of the scale bar in nm
        x = [xc, xc+w, nan, xc, xc  , nan, xc, xc  ];
        y = [yc, yc  , nan, yc, yc+w, nan, yc, yc  ];
        z = [zc, zc  , nan, zc, zc  , nan, zc, zc+w];
        hl = line(app.T6F1,x,y,z);
        hl.LineWidth = 2;
        hl.Color=[0 0 0];
        transferText=str2num(char(app.T6EFT7.Value));
        ht = text(app.T6F1,xc+transferText(1,1),yc+transferText(1,2),zc+transferText(1,3),[num2str(w), ' nm']);
        ht.FontSize = str2num(char(app.T6EFT8.Value));
        ht.FontWeight='bold';
        ht.Color =hl.Color;
        ht.VerticalAlignment = 'bottom';
    end
    hold(app.T6F1,'off')
    drawnow
end

if size(Dislocations,1)>0
    app.T6L1.Text={'Plotting the dislocation dataset';'Please wait'};pause(0.001)
    cla(app.T6F2,'reset')
    hold(app.T6F2,'on')
    for i=1:size(Dislocations,1)
        OrigPoints=Dislocations{i,1}.OrigPointsDN;
        SkeletonPoints=Dislocations{i,1}.SkeletonPointsDN;
        color=Dislocations{i,1}.color;
        if app.T6CB5.Value==1
            plot3(app.T6F2,SkeletonPoints(:,1),SkeletonPoints(:,2),SkeletonPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT9.Value)),'MarkerEdgeColor',color)
        end
        if app.T6CB6.Value==1
            if app.T6CB10.Value==1
                plot3(app.T6F2,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT10.Value)),'MarkerEdgeColor',[0 0 0])
            else
                plot3(app.T6F2,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT10.Value)),'MarkerEdgeColor',color)
            end     
        end
    end
    if size(Dislocations,1)==1
       T='1 dislocation';
    else 
       T=[num2str(size(Dislocations,1)) ' dislocations'];
    end
    if app.T6BG2_Intrinsic.Value
        title(app.T6F2,T)
    elseif app.T6BG2_Fixed.Value
        app.T6L12.Text=T;
    end
    view(app.T6F2,str2num(char(app.T1EFT5.Value)),str2num(char(app.T1EFT6.Value)))
    
    app.T6F2.FontSize=str2num(char(app.T6EFT11.Value));
    if app.T6BG2_Intrinsic.Value
        app.T6F2.TitleFontSizeMultiplier=str2num(char(app.T6EFT12.Value));
    elseif app.T6BG2_Fixed.Value
        app.T6L12.FontSize=floor((str2num(char(app.T6EFT11.Value)))*(str2num(char(app.T6EFT12.Value))));
    end
    xlabel(app.T6F2,'X (nm)')
    ylabel(app.T6F2,'Y (nm)')
    zlabel(app.T6F2,'Z (nm)')
    if app.T6CB7.Value==0
        axis(app.T6F2,'off')
    end
    app.T6F2.BackgroundColor=[1 1 1];
    xlim(app.T6F2,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T6F2,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T6F2,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    pbaspect(app.T6F2,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
    
    if app.T6CB9.Value==1
        transfer=str2num(char(app.T6EFT13.Value));
        xc=app.AxisLimits(1,1)+transfer(1,1);
        yc=app.AxisLimits(2,1)+transfer(1,2);
        zc=app.AxisLimits(3,2)-transfer(1,3);
        w=str2num(char(app.T6EFT14.Value));  %Length of the scale bar in nm
        x = [xc, xc+w, nan, xc, xc  , nan, xc, xc  ];
        y = [yc, yc  , nan, yc, yc+w, nan, yc, yc  ];
        z = [zc, zc  , nan, zc, zc  , nan, zc, zc+w];
        hl = line(app.T6F2,x,y,z);
        hl.LineWidth = 2;
        hl.Color=[0 0 0];
        transferText=str2num(char(app.T6EFT16.Value));
        ht = text(app.T6F2,xc+transferText(1,1),yc+transferText(1,2),zc+transferText(1,3),[num2str(w), ' nm']);
        ht.FontSize = str2num(char(app.T6EFT15.Value));
        ht.FontWeight='bold';
        ht.Color =hl.Color;
        ht.VerticalAlignment = 'bottom';
    end   
    hold(app.T6F2,'off')
    drawnow
end

if size(Clusters,1)>0
    app.T6L1.Text={'Plotting the cluster dataset';'Please wait'};pause(0.001)
    cla(app.T6F3,'reset')
    hold(app.T6F3,'on')
    for i=1:size(Clusters,1)
        OrigPoints=Clusters{i,1}.OrigPointsDN;
        SkeletonPoints=Clusters{i,1}.SkeletonPointsDN;
        color=Clusters{i,1}.color;
        if app.T6CB5_2.Value==1
            plot3(app.T6F3,SkeletonPoints(:,1),SkeletonPoints(:,2),SkeletonPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT9_2.Value)),'MarkerEdgeColor',color)
        end
        if app.T6CB6_2.Value==1
            if app.T6CB10_2.Value==1
                plot3(app.T6F3,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT10_2.Value)),'MarkerEdgeColor',[0 0 0])
            else
                plot3(app.T6F3,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT10_2.Value)),'MarkerEdgeColor',color)
            end 
        end
    end
    if size(Clusters,1)==1
        T='1 cluster';
    else
        T=[num2str(size(Clusters,1)) ' clusters'];
    end
    if app.T6BG3_Intrinsic.Value
        title(app.T6F3,T)
    elseif app.T6BG3_Fixed.Value
        app.T6L13.Text=T;
    end
    view(app.T6F3,str2num(char(app.T1EFT5.Value)),str2num(char(app.T1EFT6.Value)))
    
    app.T6F3.FontSize=str2num(char(app.T6EFT11_2.Value));
    if app.T6BG3_Intrinsic.Value
        app.T6F3.TitleFontSizeMultiplier=str2num(char(app.T6EFT12_2.Value));
    elseif app.T6BG3_Fixed.Value
        app.T6L13.FontSize=floor((str2num(char(app.T6EFT11_2.Value)))*(str2num(char(app.T6EFT12_2.Value))));
    end
    
    xlabel(app.T6F3,'X (nm)')
    ylabel(app.T6F3,'Y (nm)')
    zlabel(app.T6F3,'Z (nm)')
    if app.T6CB7_2.Value==0
        axis(app.T6F3,'off')
    end
    app.T6F3.BackgroundColor=[1 1 1];
    xlim(app.T6F3,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T6F3,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T6F3,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    pbaspect(app.T6F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
    
    if app.T6CB9_2.Value==1
        transfer=str2num(char(app.T6EFT13_2.Value));
        xc=app.AxisLimits(1,1)+transfer(1,1);
        yc=app.AxisLimits(2,1)+transfer(1,2);
        zc=app.AxisLimits(3,2)-transfer(1,3);
        w=str2num(char(app.T6EFT14_2.Value));  %Length of the scale bar in nm
        x = [xc, xc+w, nan, xc, xc  , nan, xc, xc  ];
        y = [yc, yc  , nan, yc, yc+w, nan, yc, yc  ];
        z = [zc, zc  , nan, zc, zc  , nan, zc, zc+w];
        hl = line(app.T6F3,x,y,z);
        hl.LineWidth = 2;
        hl.Color=[0 0 0];
        transferText=str2num(char(app.T6EFT16_2.Value));
        ht = text(app.T6F3,xc+transferText(1,1),yc+transferText(1,2),zc+transferText(1,3),[num2str(w), ' nm']);
        ht.FontSize = str2num(char(app.T6EFT15_2.Value));
        ht.FontWeight='bold';
        ht.Color =hl.Color;
        ht.VerticalAlignment = 'bottom';
    end  
    hold(app.T6F3,'off')
    drawnow
end

app.T6L1.Text={'Plotting the three-color figure';'Please wait'};pause(0.001)
cla(app.T6F4,'reset')
hold(app.T6F4,'on')
dF=false;
cF=false;
oF=false;
if size(Dislocations,1)>0 && app.T6CB11.Value==1
    dF=true;
    dPoints=cell(size(Dislocations,1),1);
    for i=1:size(Dislocations,1)
        dPoints{i,1}=Dislocations{i,1}.OrigPointsDN;
    end
    dPoints=cell2mat(dPoints);
    plot3(app.T6F4,dPoints(:,1),dPoints(:,2),dPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT17_1.Value)),'MarkerEdgeColor',str2num(char(app.T6EFT18_1.Value)))
end

if size(Clusters,1)>0 && app.T6CB12.Value==1
    cF=true;
    cPoints=cell(size(Clusters,1),1);
    for i=1:size(Clusters,1)
        cPoints{i,1}=Clusters{i,1}.OrigPointsDN;
    end
    cPoints=cell2mat(cPoints);
    plot3(app.T6F4,cPoints(:,1),cPoints(:,2),cPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT17_2.Value)),'MarkerEdgeColor',str2num(char(app.T6EFT18_2.Value)))
end

if size(Others,1)>0 && app.T6CB13.Value==1
    oF=true;
    oPoints=cell(size(Others,1),1);
    for i=1:size(Others,1)
        oPoints{i,1}=Others{i,1}.OrigPointsDN;
    end
    oPoints=cell2mat(oPoints);
    plot3(app.T6F4,oPoints(:,1),oPoints(:,2),oPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT17_3.Value)),'MarkerEdgeColor',str2num(char(app.T6EFT18_3.Value)))
end
if app.T6BG4_Intrinsic.Value || app.T6BG4_Fixed.Value
    dC=str2num(char(app.T6EFT18_1.Value));
    cC=str2num(char(app.T6EFT18_2.Value));
    oC=str2num(char(app.T6EFT18_3.Value));
    if dF && cF && oF
        T=['{\color[rgb]{' num2str(dC(1,1)) ' ' num2str(dC(1,2)) ' ' num2str(dC(1,3)) '}' 'Dislocations}, {\color[rgb]{' num2str(cC(1,1)) ' ' num2str(cC(1,2)) ' ' num2str(cC(1,3)) '}' 'clusters} & {\color[rgb]{' num2str(oC(1,1)) ' ' num2str(oC(1,2)) ' ' num2str(oC(1,3)) '}' 'other objects}'];
    elseif dF && cF
        T=['{\color[rgb]{' num2str(dC(1,1)) ' ' num2str(dC(1,2)) ' ' num2str(dC(1,3)) '}' 'Dislocations} & {\color[rgb]{' num2str(cC(1,1)) ' ' num2str(cC(1,2)) ' ' num2str(cC(1,3)) '}' 'clusters}'];
    elseif dF && oF
        T=['{\color[rgb]{' num2str(dC(1,1)) ' ' num2str(dC(1,2)) ' ' num2str(dC(1,3)) '}' 'Dislocations} & {\color[rgb]{' num2str(oC(1,1)) ' ' num2str(oC(1,2)) ' ' num2str(oC(1,3)) '}' 'other objects}'];
    elseif cF && oF
        T=['{\color[rgb]{' num2str(cC(1,1)) ' ' num2str(cC(1,2)) ' ' num2str(cC(1,3)) '}' 'Clusters} & {\color[rgb]{' num2str(oC(1,1)) ' ' num2str(oC(1,2)) ' ' num2str(oC(1,3)) '}' 'other objects}'];
    elseif dF
        T=['{\color[rgb]{' num2str(dC(1,1)) ' ' num2str(dC(1,2)) ' ' num2str(dC(1,3)) '}' 'Dislocations}'];
    elseif cF
        T=['{\color[rgb]{' num2str(cC(1,1)) ' ' num2str(cC(1,2)) ' ' num2str(cC(1,3)) '}' 'Clusters}'];
    elseif oF
        T=['{\color[rgb]{' num2str(oC(1,1)) ' ' num2str(oC(1,2)) ' ' num2str(oC(1,3)) '}' 'Other objects}'];
    end
    
    if app.T6BG4_Intrinsic.Value
        title(app.T6F4,T,'interpreter','tex')      
    elseif app.T6BG4_Fixed.Value
        title(app.T6F4_2,T,'interpreter','tex')
    end
end

view(app.T6F4,str2num(char(app.T1EFT5.Value)),str2num(char(app.T1EFT6.Value)))

app.T6F4.FontSize=str2num(char(app.T6EFT20.Value));
if app.T6BG4_Intrinsic.Value
    app.T6F4.TitleFontSizeMultiplier=str2num(char(app.T6EFT21.Value));
elseif app.T6BG4_Fixed.Value
    app.T6F4_2.TitleFontSizeMultiplier=str2num(char(app.T6EFT21.Value));
end
xlabel(app.T6F4,'X (nm)')
ylabel(app.T6F4,'Y (nm)')
zlabel(app.T6F4,'Z (nm)')
if app.T6CB14.Value==0
    axis(app.T6F4,'off')
end
app.T6F4.BackgroundColor=[1 1 1];
xlim(app.T6F4,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T6F4,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T6F4,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
pbaspect(app.T6F4,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);

if app.T6CB16.Value==1
    transfer=str2num(char(app.T6EFT22.Value));
    xc=app.AxisLimits(1,1)+transfer(1,1);
    yc=app.AxisLimits(2,1)+transfer(1,2);
    zc=app.AxisLimits(3,2)-transfer(1,3);
    w=str2num(char(app.T6EFT23.Value));  %Length of the scale bar in nm
    x = [xc, xc+w, nan, xc, xc  , nan, xc, xc  ];
    y = [yc, yc  , nan, yc, yc+w, nan, yc, yc  ];
    z = [zc, zc  , nan, zc, zc  , nan, zc, zc+w];
    hl = line(app.T6F4,x,y,z);
    hl.LineWidth = 2;
    hl.Color=[0 0 0];
    transferText=str2num(char(app.T6EFT25.Value));
    ht = text(app.T6F4,xc+transferText(1,1),yc+transferText(1,2),zc+transferText(1,3),[num2str(w), ' nm']);
    ht.FontSize = str2num(char(app.T6EFT24.Value));
    ht.FontWeight='bold';
    ht.Color =hl.Color;
    ht.VerticalAlignment = 'bottom';
end

hold(app.T6F4,'off')
drawnow

if size(Others,1)>0
    app.T6L1.Text={'Plotting other objects';'Please wait'};pause(0.001)
    cla(app.T6F5,'reset')
    hold(app.T6F5,'on')
    for i=1:size(Others,1)
        OrigPoints=Others{i,1}.OrigPointsDN;
        SkeletonPoints=Others{i,1}.SkeletonPointsDN;
        color=Others{i,1}.color;
        if app.T6CB5_3.Value==1
            plot3(app.T6F5,SkeletonPoints(:,1),SkeletonPoints(:,2),SkeletonPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT9_3.Value)),'MarkerEdgeColor',color)
        end
        if app.T6CB6_3.Value==1
            if app.T6CB10_3.Value==1
                plot3(app.T6F5,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT10_3.Value)),'MarkerEdgeColor',[0 0 0])
            else
                plot3(app.T6F5,OrigPoints(:,1),OrigPoints(:,2),OrigPoints(:,3),'.','MarkerSize',str2num(char(app.T6EFT10_3.Value)),'MarkerEdgeColor',color)
            end
        end
    end
    if size(Others,1)==1
        T='1 other object';
    else
        T=[num2str(size(Others,1)) ' other objects'];
    end
    if app.T6BG5_Intrinsic.Value
        title(app.T6F5,T)
    elseif app.T6BG5_Fixed.Value
        app.T6L15.Text=T;
    end
    view(app.T6F5,str2num(char(app.T1EFT5.Value)),str2num(char(app.T1EFT6.Value)))
    
    app.T6F5.FontSize=str2num(char(app.T6EFT11_3.Value));
    if app.T6BG5_Intrinsic.Value
        app.T6F5.TitleFontSizeMultiplier=str2num(char(app.T6EFT12_3.Value));
    elseif app.T6BG5_Fixed.Value
        app.T6L15.FontSize=floor((str2num(char(app.T6EFT11_3.Value)))*(str2num(char(app.T6EFT12_3.Value))));
    end
    xlabel(app.T6F5,'X (nm)')
    ylabel(app.T6F5,'Y (nm)')
    zlabel(app.T6F5,'Z (nm)')
    if app.T6CB7_3.Value==0
        axis(app.T6F5,'off')
    end
    app.T6F5.BackgroundColor=[1 1 1];
    xlim(app.T6F5,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T6F5,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T6F5,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    pbaspect(app.T6F5,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
        
    if app.T6CB9_3.Value==1
        transfer=str2num(char(app.T6EFT13_3.Value));
        xc=app.AxisLimits(1,1)+transfer(1,1);
        yc=app.AxisLimits(2,1)+transfer(1,2);
        zc=app.AxisLimits(3,2)-transfer(1,3);
        w=str2num(char(app.T6EFT14_3.Value));  %Length of the scale bar in nm
        x = [xc, xc+w, nan, xc, xc  , nan, xc, xc  ];
        y = [yc, yc  , nan, yc, yc+w, nan, yc, yc  ];
        z = [zc, zc  , nan, zc, zc  , nan, zc, zc+w];
        hl = line(app.T6F5,x,y,z);
        hl.LineWidth = 2;
        hl.Color=[0 0 0];
        transferText=str2num(char(app.T6EFT16_3.Value));
        ht = text(app.T6F5,xc+transferText(1,1),yc+transferText(1,2),zc+transferText(1,3),[num2str(w), ' nm']);
        ht.FontSize = str2num(char(app.T6EFT15_3.Value));
        ht.FontWeight='bold';
        ht.Color =hl.Color;
        ht.VerticalAlignment = 'bottom';
    end
    hold(app.T6F5,'off')
    drawnow
end

app.T6P6.Visible=true;
app.T6P7.Visible=true;

app.T6L1.Text={'You can capture a video or save figures now.';
               'For your information, if the title of plots does not look good you should:'
               'For saving a figure, please set the "Title type" to "Intrinsic" and click on the';
               '"plot" button again. For capturing a video, set the "Title type" to "Fixed"'; 
               'and click on the "plot" button again.If the plot which shows the orginal dataset';
               'has too many atoms, please reduce the value of the "Maximum number of';
    'atoms to plot" box in the first tab. Then get back to tab 6 and click on "Plot".'};
               
app.T6Lamp1.Color='g';pause(0.001)
end