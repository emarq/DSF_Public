%Tab 3, Stitching pushbutton
function T3B6(app)

cla(app.T3F4,'reset')
app.T3F4.Visible=false;

app.T3L1.Text='Please wait';
app.T3Lamp1.Color='y';pause(0.001)
hdb=app.hdb;

Str=char(app.T3EFT3.Value);

if size(Str,1)==0 || size(Str,2)==0 
    app.T3L1.Text='Please fill the "Object ID" box and then click on the "Plot" button.';
    app.T3Lamp1.Color='r';pause(0.001)
    return
end
[Message,Flag]=T3B6_CheckInputString(Str);
if Flag
    app.T3L1.Text=Message;
    app.T3Lamp1.Color='r';pause(0.001)
    return    
end

StrCell =(strsplit(Str,';'))';

tempSaver=[];
Save=cell(size(StrCell,1),1);
for i=1:size(StrCell,1)
    id=str2num(StrCell{i,1});
    if isempty(id)
        app.T3L1.Text={'The following part is not in the correct format:';StrCell{i,1};'Please correct the "Object ID" box and then click on the "Plot" button.'};
        app.T3Lamp1.Color='r';pause(0.001)
        return        
    elseif size(id,2)<2
        app.T3L1.Text={['Object ID ' num2str(id(1,1)) ' is alone.'];'Please either remove it from the box or write a pair for it'};
        app.T3Lamp1.Color='r';pause(0.001)
        return
    elseif min(id)<1
        app.T3L1.Text='Minimum acceptable object ID value is 1.';
        app.T3Lamp1.Color='r';pause(0.001)
        return
    elseif max(id)>size(hdb,2)
        app.T3L1.Text=['Maximum object ID value is ' num2str(size(hdb,2)) '.'];
        app.T3Lamp1.Color='r';pause(0.001)
        return
    elseif size(unique(id),2)<size(id,2)
        app.T3L1.Text='A dense object cannot be stitched with itself.';
        app.T3Lamp1.Color='r';pause(0.001)
        return
    end
    if size(tempSaver,2)>0
        if sum(ismember(id,tempSaver))>0
            Index=ismember(id,tempSaver);
            app.T3L1.Text=['Object ' num2str(id(1,Index)) ' is repeated more than one in the "Object ID" box.'];
            app.T3Lamp1.Color='r';pause(0.001)
            return
        end
    end
    
    tempSaver=[tempSaver id];
    
    x=cat(1,hdb(id).atomPositions);
    Save{i,1}=[x i.*ones(size(x,1),1)];
end

colors=distinguishable_colors(size(StrCell,1));
Save=cell2mat(Save);
Save(:,4:6)=colors(Save(:,4),1:3);

scatter3(app.T3F3,Save(:,1),Save(:,2),Save(:,3),5.*ones(size(Save,1),1),Save(:,4:6),'filled');

view(app.T3F3,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T3F3,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T3F3,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T3F3,[app.AxisLimits(3,1) app.AxisLimits(3,2)])

xlabel(app.T3F3,'X (nm)')
ylabel(app.T3F3,'Y (nm)')
zlabel(app.T3F3,'Z (nm)')

if i>1
title(app.T3F3,[num2str(size(StrCell,1)) ' stitched dense objects'])
else
    title(app.T3F3,[num2str(size(StrCell,1)) ' stitched dense object'])
end

pbaspect(app.T3F3,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
app.T3F3.Visible=true;
drawnow

app.T3L1.Text={'Done!';'Please note that the results were not saved. If you want to apply the corrections,';'you need to write them in the brown-box of the "apply corrections" panel'; 'in the same format you have written here.'};
app.T3Lamp1.Color='g';pause(0.001)

end