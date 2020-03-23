%Tab 6, show plot number checkbox
function T6CB1(app)

value = app.T6CB1.Value;
if value
    app.T6L6.Visible=true;
    app.T6L2.Visible=true;
    app.T6L3.Visible=true;
    app.T6L4.Visible=true;
    app.T6L5.Visible=true;
else
    app.T6L6.Visible=false;
    app.T6L2.Visible=false;
    app.T6L3.Visible=false;
    app.T6L4.Visible=false;
    app.T6L5.Visible=false;
end
            
end