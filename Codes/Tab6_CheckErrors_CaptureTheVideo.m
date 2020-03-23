%Tab 6, Check errors for the capture the video pushbutton
function Message=Tab6_CheckErrors_CaptureTheVideo(app)

Message=[];

a=app.T6EF1.Value;%From plot #
if isempty(a) || ~isnumeric(a) || ~(size(a,1)==1) || ~(size(a,2)==1) || a<1 || a>5 || ~(floor(a)==a)
    Message={'In the "Make a video" panel,';'the "From plot#" box is not in a correct format.';'Please write an integer value smaller than 6.'};
    return
end

b=app.T6EF2.Value;%to plot #
if isempty(b) || ~isnumeric(b) || ~(size(b,1)==1) || ~(size(b,2)==1) || b<1 || b>5 || ~(floor(b)==b)
    Message={'In the "Make a video" panel,';'the "to plot#" box is not in a correct format.';'Please write an integer value smaller than 6.'};
    return
end

if a>b
    Message={'In the "Make a video" panel,';'the value written in the "From plot#" box must not be';
             'larger than the value written in the "to plot#" box.';
             'Please please write an integer value smaller than 6.'};
    return    
end

a=str2num(char(app.T6EFT28.Value));
if isempty(a) || ~isnumeric(a) || ~(size(a,1)==1) || ~(size(a,2)==3) || a(1,1)<0 || a(1,1)>1 || a(1,2)<0 || a(1,2)>1 || a(1,3)<0 || a(1,3)>1
    Message={'In the "Make a video" panel,';'the "Background color" box is not in a correct format.';'Please write three values between 0 and 1.';'These values must be separated by ",".'
             'You can find appropriate values by clicking on the "Get color values" button.'};
    return     
end

a=app.T6EF7.Value;
if a<=0 || ~(floor(a)==a)
    Message={'In the "Make a video" panel,';'the "Frame rate" box is not in a correct format.';'Please write an integer value.'};
    return    
end

a=app.T6EF8.Value;
if a<1 || a>100 || ~(floor(a)==a)
    Message={'In the "Make a video" panel,';'the "Video quality" box is not in a correct format.';'Please write an integer value smaller than 101.'};
    return    
end

a=str2num(char(app.T6EFT26.Value));
if isempty(a) || ~isnumeric(a) || ~(size(a,1)==1) || ~(size(a,2)==1) || a<=0 || ~(floor(a)==a)
    Message={'In the "Make a video" panel,';'the "Number of cycles" box is not in a correct format.';'Please write an integer value.';
             'If you write 2, it means that it makes a movie for'; 'two times of complete rotation or slicing of the plot.'};
    return    
end

a=str2num(char(app.T6EFT27.Value));
if isempty(a) || ~isnumeric(a) || ~(size(a,1)==1) || ~(size(a,2)==1) || a<=0
    if app.T6BG6_Rotation.Value
        Message={'In the "Make a video" panel,';'the "Rotation step size" box is not in a correct format.';'Please write a value larger than zero.'};
    elseif app.T6BG6_Slice.Value
        Message={'In the "Make a video" panel,';'the "Slice center movement" box is not in a correct format.';'Please write a value larger than zero.'};
    end
    return
end

end