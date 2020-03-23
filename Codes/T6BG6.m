%Tab 6, video type Radio button group
function T6BG6(app)

selectedButton = app.T6BG6.SelectedObject;
T=selectedButton.Text;
if strcmp(T,'Rotation')
    app.T6EFT27Label.Text={'Rotation step';'size (degree)'};
    app.T6DD2_2.Value='z-axis';
    app.T6DD3_2.Value='Azimuth';
    app.T6DD1_2.Visible=false;
    app.T6DD1_2Label.Visible=false;
    app.T6DD2_2.Visible=true;
    app.T6DD2_2Label.Visible=true;
    app.T6DD3_2.Visible=true;
    app.T6DD3_2Label.Visible=true;
elseif strcmp(T,'Slice')
    app.T6EFT27Label.Text={'Slice center';'movement (nm)'};
    app.T6DD1_2.Value='x-axis';
    app.T6DD1_2.Visible=true;
    app.T6DD1_2Label.Visible=true;
    app.T6DD2_2.Visible=false;
    app.T6DD2_2Label.Visible=false;
    app.T6DD3_2.Visible=false;
    app.T6DD3_2Label.Visible=false;
end

end




