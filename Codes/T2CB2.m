%Tab 2, All dense objects are detected checkbox
function T2CB2(app)

value = app.T2CB2.Value;
if value
    app.T2CB1.Visible=false;
    app.T2CB1.Value=1;
end
            
end