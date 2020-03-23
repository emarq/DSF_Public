%AppDesignerComponentName=app.UIaxes
%FigureName='Iman.tiff'
%FigureSize=[0.1 0.1 0.8 0.7]
function appDesignerFigSaver(AppDesignerComponentName,FigureName,FigureSize) 

    fNew = figure('visible','off');
    copyUIAxes(AppDesignerComponentName,fNew);

    set(fNew, 'Units', 'Normalized', 'OuterPosition', FigureSize);
    saveas(fNew,FigureName)

    close(fNew)

end