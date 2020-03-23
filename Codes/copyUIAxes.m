function h = copyUIAxes(varargin)
%  The use of copyobj() is not supported with UI axes. COPYUIAXES
% provides a way to copy the content of a UI axis to a new figure.
% COPYUIAXES receives the handle to a UI axes and copies all of its
% children and most of its properties to a new axis. If the UI axis
% has a legend, the legend is copied too (but see tech notes within). 
% The handle to a colobar may also be included to copy the colorbar.
% Requires Matlab r2016a or later. 
%
% COPYUIAXES(uiax) creates a new figure and axis in default position
% and copies the content of the UI axis onto the new axis. 'uiax' is
% required to be a UI axis handle of class matlab.ui.control.UIAxes.
% If the axis handle contains a non-empty legend property, the legend
% is copied too (but see tech notes within).
%
% COPYUIAXES(uiax,destination) copies the content of the UI axis to 
% destination object which can either be a figure or axes handle. If
% the handle is a figure the axes will be created in default position.
%
% h = COPYUIAXES( ) returns a scalar structure containing all graphics
% handles that were produced.  
%
% COPYUIAXES(. . . , 'legend', h) specifies the legend handle (h) to 
% copy to the new destination. If the lengend handles is provided 
% here, it overrides any legend detected from within the axis handle.
%
% COPYUIAXES(. . . , 'colorbar', h) specifies the colorbar handle (h)  
% to copy to the new destination (but see tech notes within). 
%
% COPYUIAXES(. . . , 'listIgnoredProps', TF) when TF is true, a table
% of property names appears in the command window listing the properties
% of each copied object that were ignored. Some properties are not 
% editable while others are intentionally ignored.  
%
% Examples (for r2016b or later)
%     fh = uifigure();
%     uiax = uiaxes(fh);
%     hold(uiax,'on')
%     grid(uiax,'on')
%     x = linspace(0,3*pi,200);
%     y = cos(x) + rand(1,200);
%     ph = scatter(uiax,x,y,25,linspace(1,10,200),'filled');
%     lh = plot(uiax, x, smooth(x,y), 'k-'); 
%     title(uiax,'copyUIaxes Demo','FontSize',18)
%     xlabel(uiax,'x axis')
%     ylabel(uiax,'y axis')
%     zlabel(uiax,'z axis')
%     cb = colorbar(uiax); 
%     cb.Ticks = -2:2:12;
%     caxis(uiax,[-2,12])
%     ylabel(cb,'cb ylabel')
%     lh = legend(uiax,[ph,lh],{'Raw','lowess'},'Location','NorthEast'); 
%     drawnow()% all graphics to catch up before copying
% 
%     % Ex 1: Copy axis to another figure
%     h = copyUIAxes(uiax);
%     
%     % Ex 2: specify ax axis as destination
%     fNew = figure();
%     axh = subplot(2,2,1,'Parent',fNew);
%     h = copyUIAxes(uiax,axh);
% 
%     % Ex 3: Provide colorbar and legend handles
%     h = copyUIAxes(uiax, 'colorbar', cb, 'legend', lh);
%     
%     % Ex 4: See which properties were not copied
%     h = copyUIAxes(uiax, 'colorbar', cb, 'listIgnoredProps', true);
%    
% To report bugs, feature requests, or high fives, the author's 
% email address is within the file. 
% Adam Danz Oct 2019.
% Copyright (c) 2019, Adam Danz
% All rights reserved
% Please contact me if you experience any bugs. 
% Email: (Run the line below)
% char([97 100 97 109 46 100 97 110 122 64 103 109 97 105 108 46 99 111 109]) 
% To follow discussion on matlab central see note [1].
%% Tech notes
% Mimicking copyobj() for UIaxes is not trivial.  Many of the axes properties
% and sub-handles are hidden or obscured so some properties are not copied. 
% Copying the legend is not currently supported so we have to create a new one.
% This is also not trivial since we do not have a 1:1 matching  between line 
% object handles and their DisplayName values from within the legend handle. 
% So we must re-create the legend and search for the DisplayName values in 
% the axis children.  This may result in inconsistencies with the original 
% legend.  For example, if there is more than 1 object with the same DisplayName
% value then the legend will pair with the first one which may not be the same 
% object as what is intended.  In these cases it is better to delete the new
% legend and just recreate it.  Similar problems exist with copying the 
% colorbar.  The colorbar cannot be copied so we must recreated it and do 
% our best to copy the properties. 
%
% I've chosen to not copy the axis position property.  Typically UIaxes are 
% smaller because they are embedded in an app.  If you want the axes to 
% match in size you can make those adjustments after the recreation.  
%
% See footnotes for additional details regarding certain lines of the code. 
%% input parser
destinationValidity = @(h)isgraphics(h,'axes') || isgraphics(h,'figure'); 
p = inputParser();
p.FunctionName = mfilename;
addRequired(p, 'uiax', @(h)isa(h,'matlab.ui.control.UIAxes'))
addOptional(p, 'destination', [], destinationValidity);  % see notes [9,10]
addParameter(p, 'legend', [], @(h)isgraphics(h,'legend'));
addParameter(p, 'colorbar', [], @(h)isgraphics(h,'colorbar')); 
addParameter(p, 'listIgnoredProps', false, @islogical)
parse(p,varargin{:})
%% Produce figure and axes if needed
if isempty(p.Results.destination)
    axParent = figure('Visible','off'); 
    h.axes = axes(axParent); 
    figureCreatedInternal = true; 
elseif isgraphics(p.Results.destination, 'figure')
    axParent = p.Results.destination; 
    h.axes = axes(axParent); 
    figureCreatedInternal = true; 
else % we assume it's an axis handle; see notes [9,10]
    axParent = p.Results.destination.Parent; 
    h.axes = p.Results.destination; 
    figureCreatedInternal = false; 
end
%% Copy axis children and (most) properties
% drawnow() % To avoid lagging graphics problems
% Copy all opjects from UIAxes to new axis
copyobj(p.Results.uiax.Children, h.axes)
% Copy selected properties
badListTemp = {'Title';'XLabel';'YLabel';'ZLabel';'Toolbar'}; % see note [13]
badList = [{'Parent'; 'Children'; 'XAxis'; 'YAxis'; 'ZAxis';'Position';'OuterPosition';'Units'};badListTemp]; 
[uiaxGoodParams, uiaxbadProps] = getGoodParams(p.Results.uiax, h.axes, badList, 'axis');  % see note [2]
uiaxbadProps(ismember(uiaxbadProps.axis,badListTemp),:) = []; %rm the fields that we'll copy separately.
% move axis limit fields last or they may not be set properly
params = fields(uiaxGoodParams);  
limIdx = ismember(params,{'XLim','YLim','ZLim'}); 
permVec = (1:numel(params)).';
permVec = [permVec(~limIdx);find(limIdx)]; 
uiaxGoodParams = orderfields(uiaxGoodParams,permVec); 
% set properties
set(h.axes, uiaxGoodParams)
% Copy title and axis labels; see note [13]
h.axesTitle = title(h.axes, p.Results.uiax.Title.String);
[axTtlGoodParams, axTtlbadProps] = getGoodParams(p.Results.uiax.Title, h.axesTitle, {'Parent'; 'Position'}, 'axesTitle');
set(h.axesTitle, axTtlGoodParams)
h.axesXLabel = xlabel(h.axes, p.Results.uiax.XLabel.String);
[axXLGoodParams, axXLbadProps] = getGoodParams(p.Results.uiax.XLabel, h.axesXLabel, {'Parent'; 'Position'}, 'axesXLabel');
set(h.axesXLabel, axXLGoodParams)
h.axesYLabel = ylabel(h.axes, p.Results.uiax.YLabel.String);
[axYLGoodParams, axYLbadProps] = getGoodParams(p.Results.uiax.YLabel, h.axesYLabel, {'Parent'; 'Position'}, 'axesYLabel');
set(h.axesYLabel, axYLGoodParams)
h.axesZLabel = zlabel(h.axes, p.Results.uiax.ZLabel.String);
[axZLGoodParams, axZLbadProps] = getGoodParams(p.Results.uiax.ZLabel, h.axesZLabel, {'Parent'; 'Position'}, 'axesZLabel');
set(h.axesZLabel, axZLGoodParams)
%% Detect legend and copy if one exists (see note [14])
if (any(strcmpi(properties(p.Results.uiax),'Legend')) && ~isempty(p.Results.uiax.Legend)) ... % see notes [6,8]
        || ~isempty(p.Results.legend) 
    % if Legend was provided, use that handle, otherwise use the detected one. 
    if ~isempty(p.Results.legend)
        legHand = p.Results.legend;
    else
        legHand = p.Results.uiax.Legend; 
    end
    % Search for objects in new axes that have matching displayNames values as legend strings (see note [11])
    newChildren = h.axes.Children; 
    dispNames = get(newChildren,'DisplayName'); 
    [~,legIdx] = ismember(legHand.String, dispNames); 
    legObjHands = newChildren(legIdx); 
    
    % Create new legend and copy selected properties
    h.legend = legend(h.axes,legObjHands,legHand.String); % see note [7]
    badList = {'String';'Parent'; 'Children'; 'Position'; 'Units'; 'UIContextMenu'}; 
    [legGoodParams, legbadProps] = getGoodParams(legHand, h.legend, badList, 'legend');  % see note [3]
    set(h.legend, legGoodParams)
else
    legbadProps = table(); 
end
%% Detect colorbar and copy if one exists (see note [14])
% Note, as of r2019b, there is no way I know of to detect colorbar or get its handle from ui axes (email me if you know how).
if  ~isempty(p.Results.colorbar) 
    %Copy colorbar & selected properties
    h.colorbar = colorbar(h.axes); % see note [3]
    badList = {'Parent'; 'Children'; 'Position'; 'Units'; 'UIContextMenu'};
    [cbGoodParams, cbbadProps] = getGoodParams(p.Results.colorbar, h.colorbar, badList, 'colorbar'); 
    set(h.colorbar, cbGoodParams)
       
    % Copy title
    h.colorbarTitle = title(h.colorbar, p.Results.colorbar.Title.String);
    [cbTtlGoodParams, cbTtlbadProps] = getGoodParams(p.Results.colorbar.Title, h.colorbarTitle, {'Parent'; 'Children';'Position'}, 'colorbarTitle'); 
    set(h.colorbarTitle, cbTtlGoodParams)
    
    % Copy ylabels
    h.colorbarYlabel = ylabel(h.colorbar, p.Results.colorbar.YLabel.String);
    [cbYLabGoodParams, cbYLabbadProps] = getGoodParams(p.Results.colorbar.YLabel, h.colorbarYlabel, {'Parent'; 'Children';'Position'},'colorbarYlabel'); 
    set(h.colorbarYlabel, cbYLabGoodParams)
else
    cbbadProps = table(); 
    cbTtlbadProps = table();
    cbYLabbadProps = table(); 
end
%% If we just created the figure|axes, turn on its visibility
if figureCreatedInternal
    axParent.Visible = 'off'; %'on'
    h.axes.Visible = 'on'; %'on'
end
%% Show summary of properties that were not copied
if p.Results.listIgnoredProps
    % Put all badProps arrays into table
    badProps = {uiaxbadProps, axTtlbadProps, axXLbadProps, axYLbadProps, axZLbadProps, ...
        legbadProps, cbbadProps, cbTtlbadProps, cbYLabbadProps};
    numProps = cellfun(@numel,badProps);
    badProps(numProps==0) = []; 
    badParams = cellfun(@(c)[c;repmat({' '},max(numProps)-numel(c),1)],badProps,'UniformOutput',false);
    badParams = [badParams{:}];
    % Display table
    if ~isempty(badParams)
        fprintf(['\n %s\n The following properties were not copied either because they are not\n ', ...
            'editable or because they were intentionally ignored.\n See %s for detils.\n'], char(42*ones(1,70)), ...
            sprintf('<a href="matlab: help(''%s'') ">%s.m</a>', which(mfilename), mfilename))
        disp(badParams)
        fprintf('%s\n\n',char(42*ones(1,70)))
    else
        fprintf('\n %s\n All properties were copied.\n See %s for details.\n%s\n\n ',char(42*ones(1,70)), ...
            sprintf('<a href="matlab: help(''%s'') ">%s.m</a>', which(mfilename), mfilename), char(42*ones(1,70)))
    end
end
%% Local functions
function [goodParams, badParams] = getGoodParams(hObjSource, hObjDest, badList, objName)
% The goal is to create a structure of parameter values to be changed in the destination object.  
% INPUTS
% hObjSource: handle to object being copied (ie, the old legend)
% hObjDest: handle to the new, existing copied object (ie, the new legend)
% badList: a nx1 cell array of strings that match property names (case sensitive).  These
%   properties will not be copied and will be removed from the structure.  
% objName: a char array identifying the object in hObhDest (for badParams output headers)
% OUTPUTS
% goodParams: a strcture of parameter names (fields) and their values that will be used
%   to update the parameters in hObjDest. To apply the parameter values, set(hObjDest, goodParams).
% badParams: a mx1 table of strings listing the properties that will not be copied either because
%   they were listed in badList or because they are not editable. Headers are defined by objName.
% List all parameters of the source object
params = get(hObjSource);
paramNames = fieldnames(hObjSource);
% Get list of editable params in destination object
editableParams = fieldnames(set(hObjDest));
% Remove the params that aren't editable or are unwanted in the destination obj
badParams = paramNames(~ismember(paramNames, editableParams));
badParams = [badParams; badList(ismember(badList,paramNames))]; % see note [4]
goodParams = rmfield(params,unique(badParams)); % see note [5]
badParams = table(sort(badParams),'VariableNames', {objName}); % see note [12]
% For trouble shooting, or to loop through each property rather then setting them all at once, 
% replace the last line of the code above with this for-loop below which indicates the property 
% being edited in the command window.  
%     allf = fieldnames(goodParams);
%     for i = 1:length(allf)
%         fprintf('Property #%d: %s\n', i, allf{i});
%         set(hObjDest, allf{i}, goodParams.(allf{i}))
%     end
