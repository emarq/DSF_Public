%Tab 6, Title type radio button group for figure 2
function T6BG2(app)

selectedButton = app.T6BG2.SelectedObject;
T=selectedButton.Text;
if strcmp(T,'Intrinsic')
    app.T6L12.Visible=false;
elseif strcmp(T,'Fixed')
    app.T6L12.Visible=true;
elseif strcmp(T,'None')
    app.T6L12.Visible=false;
end

end