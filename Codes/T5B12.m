%Tab 5, plot combined IPF plot push button
function T5B12(app)
app.T5L1.Text={'Please wait'};
app.T5Lamp1.Color='y';pause(0.001)


dID=str2num(char(app.T5EFT15.Value));
if isempty(dID) && ~(isempty(app.T5EFT15.Value))
    app.T5L1.Text={'"Dislocation loop ID values" box is not in the correct format.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif isempty(dID)
    app.T5L1.Text={'"Dislocation loop ID values" box is not filled.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
elseif ~(size(dID,1)==1)
    app.T5L1.Text={'"Dislocation loop ID values" box is not in the correct format.';'Dislocation loop ID values must be separated by ",".'};
    app.T5Lamp1.Color='r';pause(0.001)
    return
end


PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);
DisData=load([PosFileName,'/4_FinalResults/' PosFileName '_' NameOfElementOfInterest '_FinalResults.mat']);
DisData=DisData.Dislocations;
if isempty(DisData)
    app.T5L1.Text={'We cannot do the analysis because there is no dislocation in this atom probe dataset.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return    
else
    IDsvaer(1:size(DisData,1),1)=0;
    for i=1:size(DisData,1)
        IDsvaer(i,1)=DisData{i,1}.SkeletonID;
    end
end

for j=1:size(dID,2)
    if ~ismember(dID(1,j),IDsvaer)
    app.T5L1.Text={['There is no dislocation with the ID value of ' num2str(dID(1,j)) '.'];'Please use "Get skeleton ID" button to get the correct ID value and';...
                    'then fix the problem of "Dislocation loop ID values" box.'};
    app.T5Lamp1.Color='r';pause(0.001)
    return 
    end
    if ~(exist([PosFileName,'/4_FinalResults/IPFplotData/DisID_' num2str(dID(1,j)) '.mat'],'file')==2)
        app.T5L1.Text={['You did not do the required crystallographic analysis for the dislocation #' num2str(dID(1,j)) '.'];...
                        'The crystallograhic analysis is done in "Finding the crystallographic plane of a dislocation loop" panel.';...
                        'Please make sure that you did the crystallographic analysis for all of the dislocations that you wrote in the';...
                        '"Dislocation loop ID values" box.'};
        app.T5Lamp1.Color='r';pause(0.001)
        return
    end
end

f1=figure('Visible','off','Position', [2000 2000 310 310]);
for j=1:size(dID,2)
    a=load([PosFileName,'/4_FinalResults/IPFplotData/DisID_' num2str(dID(1,j)) '.mat']);
    data=a.data;
    h=a.h;
    rSym=a.rSym;
    varargin=a.varargin;
    [~,cax] = h.plot(repmat(data,1,length(rSym)),'symmetrised',...
    'fundamentalRegion','doNotDraw',varargin{:});
    hold on
end
mtexTitle(cax(1),app.T5EFT16.Value)
hold off
    
PATH=[PosFileName,'/4_FinalResults/IPFplots/IPFplot_' PosFileName '_' NameOfElementOfInterest 'CombinedIPF_DisID_' num2str(dID)  '.tif']; 
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

cla(app.T5F6,'reset')
hold(app.T5F6,'on')

for j=1:size(dID,2)
    for i=1:size(DisData,1)
        if dID(1,j)==DisData{i,1}.SkeletonID
            points=DisData{i,1}.OrigPointsDN;%I need to make sure whether I need to change z coordinate to -z or not
            Color=DisData{i,1}.color;
            SkelPoint=DisData{i,1}.SkeletonPointsDN;
            plot3(app.T5F6,SkelPoint(:,1),SkelPoint(:,2),SkelPoint(:,3),'.','MarkerSize',8,'MarkerEdgeColor',Color)
            plot3(app.T5F6,points(:,1),points(:,2),points(:,3),'.','MarkerSize',3,'MarkerEdgeColor',[0 0 0])
            
            break
        end
    end
end
hold(app.T5F6,'off')

view(app.T5F6,str2double(char(app.T1EFT5.Value)),str2double(char(app.T1EFT6.Value)))
  
xlim(app.T5F6,[app.AxisLimits(1,1) app.AxisLimits(1,2)])
ylim(app.T5F6,[app.AxisLimits(2,1) app.AxisLimits(2,2)])
zlim(app.T5F6,[app.AxisLimits(3,1) app.AxisLimits(3,2)])

xlabel(app.T5F6,'X (nm)')
ylabel(app.T5F6,'Y (nm)')
zlabel(app.T5F6,'Z (nm)')
    
title(app.T5F6,'Dislocations presented in the combined IPF plot')
axis(app.T5F6,'off')
pbaspect(app.T5F6,[1 ((app.AxisLimits(2,2)-app.AxisLimits(2,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1))) ((app.AxisLimits(3,2)-app.AxisLimits(3,1))/(app.AxisLimits(1,2)-app.AxisLimits(1,1)))]);
drawnow



app.T5L1.Text={'Done!';'The colors in the combined IPF plot are consistent with the colors used for the skeleton of dislocations.';
               '';
              'A high quality figure of the combined plot is saved in the';[PosFileName,'/4_FinalResults folder.']};
app.T5Lamp1.Color='g';pause(0.001)
end