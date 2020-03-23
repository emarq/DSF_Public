%Tab 2, Plot selected object pushbutton
function T2B5(app)

app.T2L1.Text={'Please wait'};
app.T2Lamp1.Color='y';pause(0.001)

input=str2num(char(app.T2EFT3.Value));
if size(input,1)>1 || ((~isempty(app.T2EFT3.Value)) && isempty(input))
    app.T2L1.Text='Please separate dense object ID values with ","';
    app.T2Lamp1.Color='r';pause(0.001)
    return   
end

hdbscanSelByPersisAndProb=app.hdbscanSelByPersisAndProb;
SIZE=size(hdbscanSelByPersisAndProb,2);
for j=1:size(input,2)
    if input(1,j)>SIZE || input(1,j)<1 || (~(floor(input(1,j))==input(1,j))) 
        app.T2L1.Text={[num2str(input(1,j)) ' cannot be the ID of a dense object']};
        app.T2Lamp1.Color='r';pause(0.001)
        return
    end
end
    
if size(input,2)>1
    input=unique(input);%To avoid problem if the user repeats an ID
end

Save=cell(size(input,2),1);
for j=1:size(input,2)
    id=input(1,j);
    color=hdbscanSelByPersisAndProb(id).color;
    x=hdbscanSelByPersisAndProb(id).atomPositions;
    Save{j,1}=[x color.*ones(size(x,1),1)];
end
Save=cell2mat(Save);
cla(app.T2F6,'reset')
if size(Save,1)>0
    scatter3(app.T2F6,Save(:,1),Save(:,2),Save(:,3),5.*ones(size(Save,1),1),Save(:,4:6),'filled')
    
    view(app.T2F6,str2num(char(app.T1EFT5.Value)),str2num(char(app.T1EFT6.Value)))
    xlim(app.T2F6,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
    ylim(app.T2F6,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
    zlim(app.T2F6,[app.AxisLimits(3,1) app.AxisLimits(3,2)])
    
    xlabel(app.T2F6,'X (nm)')
    ylabel(app.T2F6,'Y (nm)')
    zlabel(app.T2F6,'Z (nm)')
    
    title(app.T2F6,'Selected dense objects')
    axis(app.T2F6,'off')
    pbaspect(app.T2F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
else
    title(app.T2F6,'No dense object is selected')
end
drawnow
app.T2L1.Text='Done!';
app.T2Lamp1.Color='g';pause(0.001)

end