%Tab 6, Title type radio button group for figure 5
function T6BG5(app)

selectedButton = app.T6BG5.SelectedObject;
T=selectedButton.Text;
if strcmp(T,'Intrinsic')
    app.T6L15.Visible=false;
elseif strcmp(T,'Fixed')
    app.T6L15.Visible=true;
elseif strcmp(T,'None')
    app.T6L15.Visible=false;
end

end