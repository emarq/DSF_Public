%Tab 6, Title type radio button group for figure 1
function T6BG1(app)

selectedButton = app.T6BG1.SelectedObject;
T=selectedButton.Text;
if strcmp(T,'Intrinsic')
    app.T6L11.Visible=false;
elseif strcmp(T,'Fixed')
    app.T6L11.Visible=true;
elseif strcmp(T,'None')
    app.T6L11.Visible=false;
end

end