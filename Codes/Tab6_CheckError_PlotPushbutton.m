%Tab 6, check error in the inputs for the "plot" pushbutton
function Message=Tab6_CheckError_PlotPushbutton(app)

Message=[];

%Figure 1 settings
b=str2num(char(app.T6EFT1.Value));%Point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 1 settings" panel,';'the "Point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT2.Value));%Point color
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) || b(1,1)<0 || b(1,1)>1 || b(1,2)<0 || b(1,2)>1 || b(1,3)<0 || b(1,3)>1 
    Message={'In "Figure 1 settings" panel,';'the "Point color" box is not in a correct format.';'There must be three values separated by ",".';'You can use "Get color values" button to get the'; 'three values for the color that you want.'};
    return
end

b=str2num(char(app.T6EFT3.Value));%Font size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 1 settings" panel,';'the "Font size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT4.Value));%Font title multiplier
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 1 settings" panel,';'the "Font title multiplier" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT5.Value));%scale bar position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 1 settings" panel,';'the "Scale bar position" box is not in a correct format.';'Please choose three values separated by ",".'};
    return
end

b=str2num(char(app.T6EFT6.Value));%Scale bar size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 1 settings" panel,';'the "Scale bar size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT8.Value));%Scale bar text font
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 1 settings" panel,';'the "Scale bar text font" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT7.Value));%Scale bar text position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 1 settings" panel,';'the "Scale bar text position" box is not in a correct format.';'Please choose three values separated by ",".'};
    return
end


%Figure 2 settings
b=str2num(char(app.T6EFT9.Value));%Skeleton-point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 2 settings" panel,';'the "Skeleton-point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT10.Value));%Original-point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 2 settings" panel,';'the "Original-point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT11.Value));%Font size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 2 settings" panel,';'the "Font size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT12.Value));%Font title multiplier
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 2 settings" panel,';'the "Font title multiplier" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT13.Value));%Scale bar position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 2 settings" panel,';'the "Scale bar position" box is not in a correct format.';'Please write three values separated by ",".'};
    return
end

b=str2num(char(app.T6EFT14.Value));%Scale bar size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 2 settings" panel,';'the "Scale bar size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT15.Value));%Scale bar text font
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 2 settings" panel,';'the "Scale bar text font" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT16.Value));%Scale bar text position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 2 settings" panel,';'the "Scale bar text position" box is not in a correct format.';'Please write three values separated by ",".'};
    return
end

%Figure 3 settings
b=str2num(char(app.T6EFT9_2.Value));%Skeleton-point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 3 settings" panel,';'the "Skeleton-point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT10_2.Value));%Original-point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 3 settings" panel,';'the "Original-point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT11_2.Value));%Font size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 3 settings" panel,';'the "Font size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT12_2.Value));%Font title multiplier
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 3 settings" panel,';'the "Font title multiplier" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT13_2.Value));%Scale bar position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 3 settings" panel,';'the "Scale bar position" box is not in a correct format.';'Please write three values separated by ",".'};
    return
end

b=str2num(char(app.T6EFT14_2.Value));%Sclae bar size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 3 settings" panel,';'the "Sclae bar size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT15_2.Value));%Scale bar text font
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 3 settings" panel,';'the "Scale bar text font" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT16_2.Value));%Scale bar text position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 3 settings" panel,';'the "Scale bar text position" box is not in a correct format.';'Please write three values separated by ",".'};
    return
end

%Figure 4 settings
b=str2num(char(app.T6EFT17_1.Value));%Dislocation point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 4 settings" panel,';'the "Dislocation point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT17_2.Value));%Cluster point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 4 settings" panel,';'the "Cluster point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT17_3.Value));%Other-object point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 4 settings" panel,';'the "Other-object point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT18_1.Value));%Dislocation point color
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) || b(1,1)<0 || b(1,1)>1 || b(1,2)<0 || b(1,2)>1 || b(1,3)<0 || b(1,3)>1 
    Message={'In "Figure 4 settings" panel,';'the "Dislocation point color" box is not in a correct format.';'There must be three values separated by ",".';'You can use "Get color values" button to get the'; 'three values for the color that you want.'};
    return
end

b=str2num(char(app.T6EFT18_2.Value));%Cluster point color
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) || b(1,1)<0 || b(1,1)>1 || b(1,2)<0 || b(1,2)>1 || b(1,3)<0 || b(1,3)>1 
    Message={'In "Figure 4 settings" panel,';'the "Cluster point color" box is not in a correct format.';'There must be three values separated by ",".';'You can use "Get color values" button to get the'; 'three values for the color that you want.'};
    return
end

b=str2num(char(app.T6EFT18_3.Value));%Other-object point color
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) || b(1,1)<0 || b(1,1)>1 || b(1,2)<0 || b(1,2)>1 || b(1,3)<0 || b(1,3)>1 
    Message={'In "Figure 4 settings" panel,';'the "Other-object point color" box is not in a correct format.';'There must be three values separated by ",".';'You can use "Get color values" button to get the'; 'three values for the color that you want.'};
    return
end

b=str2num(char(app.T6EFT21.Value));%Font title multiplier
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 4 settings" panel,';'the "Font title multiplier" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT20.Value));%Font size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 4 settings" panel,';'the "Font size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT22.Value));%Scale bar position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 4 settings" panel,';'the "Scale bar position" box is not in a correct format.';'Please write three values separated by ",".'};
    return
end

b=str2num(char(app.T6EFT23.Value));%Scale bar size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 4 settings" panel,';'the "Scale bar size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT24.Value));%Sclae bar text font
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 4 settings" panel,';'the "Sclae bar text font" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT25.Value));%
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 4 settings" panel,';'the "Scale bar text position" box is not in a correct format.';'Please write three values separated by ",".'};
    return
end

%Figure 5 settings
b=str2num(char(app.T6EFT9_3.Value));%Skeleton-point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 5 settings" panel,';'the "Skeleton-point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT10_3.Value));%Original-point size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 5 settings" panel,';'the "Original-point size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT11_3.Value));%Font size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 5 settings" panel,';'the "Font size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT12_3.Value));%Font title multiplier
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 5 settings" panel,';'the "Font title multiplier" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT13_3.Value));%Scale bar position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 5 settings" panel,';'the "Scale bar position" box is not in a correct format.';'Please write three values separated by ",".'};
    return
end

b=str2num(char(app.T6EFT14_3.Value));%Scale bar size
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 5 settings" panel,';'the "Scale bar size" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT15_3.Value));%Scale bar text font
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<=0
    Message={'In "Figure 5 settings" panel,';'the "Scale bar text font" box is not in a correct format.';'Please choose a value larger than zero.'};
    return
end

b=str2num(char(app.T6EFT16_3.Value));%Scale bar text position
if isempty(b) || ~(isnumeric(b)) || ~(size(b,1)==1) || ~(size(b,2)==3) 
    Message={'In "Figure 5 settings" panel,';'the "Scale bar text position" box is not in a correct format.';'Please write three values separated by ",".'};
    return
end


end