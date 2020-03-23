%Tab 6, Title type radio button group for figure 3
function T6BG3(app)

selectedButton = app.T6BG3.SelectedObject;
T=selectedButton.Text;
if strcmp(T,'Intrinsic')
    app.T6L13.Visible=false;
elseif strcmp(T,'Fixed')
    app.T6L13.Visible=true;
elseif strcmp(T,'None')
    app.T6L13.Visible=false;
end

end