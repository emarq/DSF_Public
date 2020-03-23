%Tab 6, Title type radio button group for figure 4
function T6BG4(app)

app.T6L1.Text='Please wait!';
app.T6Lamp1.Color='y';pause(0.001)

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
drawnow
app.T6L1.Text={'When you are done with tunning all the parameters,'; 'please press the "Plot" button';'to apply the changes that you made regarding';'the title of the three-color plot (the fourth plot from the left side).'};
app.T6Lamp1.Color=[1,0.549,0];pause(0.001)

end