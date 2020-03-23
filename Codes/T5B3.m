%Tab 5, Plot selected skeletons pushbuttons
function T5B3(app)

app.T5L1.Text='Please wait';
app.T5Lamp1.Color='y';pause(0.001)
Skeleton=app.Skeleton;
input=str2num(char(app.T5EFT2.Value));

if ~(size(input,1)==1)  
    app.T5L1.Text={'Pleas fill the "Skeleton IDs" box with skeleton ID values separated by ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif (sum(input<1))>0 || (sum(input>(1+size(Skeleton,1))))>0
    app.T5L1.Text={['Pleas fill the box with integer values smaller than ' num2str(1+size(Skeleton,1)) '.']};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif size(unique(input),2)<size(input,2)
    app.T5L1.Text={['Skeleton ID values must not be repeated.']};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
end

F=cell(size(input,2),1);
P=cell(size(input,2),1);
for i=1:size(input,2)
    id=input(1,i);
    color=Skeleton{id,1}.color;
    SkeletonPointsDN=Skeleton{id, 1}.SkeletonPointsDN;
    F{i,1}=[SkeletonPointsDN ones(size(SkeletonPointsDN,1),1).*color];
    P{i,1}=Skeleton{id,1}.OrigPointsDN;
end
F=cell2mat(F);
P=cell2mat(P);

scatter3(app.T5F6,F(:,1),F(:,2),F(:,3),7.*ones(size(F,1),1),F(:,4:6),'filled');
hold(app.T5F6,'on')
plot3(app.T5F6,P(:,1),P(:,2),P(:,3),'k.','MarkerSize',3)
hold(app.T5F6,'off')
view(app.T5F6,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
xlim(app.T5F6,[min(P(:,1))-3 max(P(:,1))+3])
ylim(app.T5F6,[min(P(:,2))-3 max(P(:,2))+3])
zlim(app.T5F6,[min(P(:,3))-3 max(P(:,3))+3])
xlabel(app.T5F6,'X (nm)')
ylabel(app.T5F6,'Y (nm)')
zlabel(app.T5F6,'Z (nm)')
if size(input,2)>1
    title(app.T5F6,'Selected objects')
else
    title(app.T5F6,'Selected object')
end
axis(app.T5F6,'off')
pbaspect(app.T5F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
drawnow
app.T5L1.Text='Done!';
app.T5Lamp1.Color='g';pause(0.001)
end