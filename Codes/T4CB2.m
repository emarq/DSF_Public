%Tab 4, show plot number checkbox
function T4CB2(app)

value = app.T4CB2.Value;
if value
    app.T4L2.Visible=true;
    app.T4L3.Visible=true;
    app.T4L4.Visible=true;
    app.T4L5.Visible=true;
    app.T4L6.Visible=true;
    app.T4L7.Visible=true;
    app.T4L8.Visible=true;
    app.T4L9.Visible=true;
    app.T4L10.Visible=true;
    app.T4L11.Visible=true;
    app.T4L13.Visible=true;
    app.T4L14.Visible=true;
    app.T4L15.Visible=true;
    app.T4L16.Visible=true;
else
    app.T4L2.Visible=false;
    app.T4L3.Visible=false;
    app.T4L4.Visible=false;
    app.T4L5.Visible=false;
    app.T4L6.Visible=false;
    app.T4L7.Visible=false;
    app.T4L8.Visible=false;
    app.T4L9.Visible=false;
    app.T4L10.Visible=false;
    app.T4L11.Visible=false;
    app.T4L13.Visible=false;
    app.T4L14.Visible=false;
    app.T4L15.Visible=false;
    app.T4L16.Visible=false;
end

end