%Tab 3, show help checkbox
function T3CB1(app)

value = app.T3CB1.Value;
if value
    app.T3Lh1.Visible=true;
    app.T3Lh2.Visible=true;
    app.T3Lh3.Visible=true;
else
    app.T3Lh1.Visible=false;
    app.T3Lh2.Visible=false;
    app.T3Lh3.Visible=false;
end

end
