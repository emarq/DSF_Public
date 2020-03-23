%Tab 6, callback function for the Background color box in the make video
%panel
function T6EFT28(app)

a=str2num(char(app.T6EFT28.Value));
if isempty(a) || ~isnumeric(a) || ~(size(a,1)==1) || ~(size(a,2)==3) || a(1,1)<0 || a(1,1)>1 || a(1,2)<0 || a(1,2)>1 || a(1,3)<0 || a(1,3)>1
    app.T6L1.Text={'In the "Make a video" panel,';'the "Background color" box is not in a correct format.';'Please write three values between 0 and 1.';'These values must be separated by ",".'
                   'You can find appropriate values by clicking on the "Get color values" button.'};
    app.T6Lamp1.Color='r';
    return
else
    app.T6P0.BackgroundColor=a;
end

end