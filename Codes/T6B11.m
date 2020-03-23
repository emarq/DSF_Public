%Tab 6, Get color values pushbutton
function T6B11(app)

app.T6L1.Text='Please select a color';
app.T6Lamp1.Color='y';pause(0.001)

c=uisetcolor([1 1 0],'Select a color');

app.T6L1.Text={'Done!';'';'The RGB values for the selected color is:'; [num2str(c(1,1)) ', ' num2str(c(1,2)) ', ' num2str(c(1,3))]};
app.T6Lamp1.Color='g';pause(0.001)
end