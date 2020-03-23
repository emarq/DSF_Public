%Tab 6, Capture the video pushbutton
function T6B3(app)

app.T6L1.Text={'Start capturing the video';'Please wait'};
app.T6Lamp1.Color='y';pause(0.001)

Message=Tab6_CheckErrors_CaptureTheVideo(app);
if ~isempty(Message)
    app.T6L1.Text=Message;
    app.T6Lamp1.Color='r';
    return 
end
%app.T6P0.BackgroundColor=str2num(char(app.T6EFT28.Value));%in a case that the user did not press the enter button

PosFileName=char(app.T1EFT1.Value);
NameOfElementOfInterest=char(app.T1EFT2.Value);

if app.T6BG6_Rotation.Value
    VideoFileName=[PosFileName '_' NameOfElementOfInterest '_Rotation.mp4'];
elseif app.T6BG6_Slice.Value
    VideoFileName=[PosFileName '_' NameOfElementOfInterest '_Slice.mp4'];
end

v = vision.VideoFileWriter(VideoFileName);
v.FileFormat='MPEG4';
v.FrameRate=app.T6EF7.Value;
v.Quality=app.T6EF8.Value;

[robo,rectangle]=DefineRectangleForJava(app);

if app.T6BG6_Rotation.Value
    StepSize=str2double(char(app.T6EFT27.Value));
    NL=ceil((str2double(char(app.T6EFT26.Value)))*360/StepSize);
    for i=1:NL
        T6S2_Automated(app,StepSize)
        outputImage=ScreenCaptureImanSecond(robo,rectangle);
        step(v,outputImage);
        app.T6L1.Text={[num2str(round(100*i/NL)) '% progress'];'Please wait'};
    end
elseif app.T6BG6_Slice.Value
    value = app.T6DD1.Value;
    if strcmpi(value,'x-axis')
        Limits=[ceil(app.AxisLimits(1,1)) floor(app.AxisLimits(1,2))];
    elseif strcmpi(value,'y-axis')
        Limits=[ceil(app.AxisLimits(2,1)) floor(app.AxisLimits(2,2))];
    elseif strcmpi(value,'z-axis')
        Limits=[ceil(app.AxisLimits(3,1)) floor(app.AxisLimits(3,2))];
    end
    StepSize=str2double(char(app.T6EFT27.Value));
    temp=Limits(1,1):StepSize:Limits(1,2);
    temp=([temp fliplr(temp)])';
    temp=repmat(temp,1,(str2double(char(app.T6EFT26.Value))));
    CenterList=reshape(temp,size(temp,1)*size(temp,2),1);
    SIZE=size(CenterList,1); 
    for i=1:SIZE
        T6S1_Automated(app,CenterList(i,1));
        outputImage=ScreenCaptureImanSecond(robo,rectangle);
        step(v,outputImage);
        app.T6L1.Text={[num2str(round(100*i/SIZE)) '% progress'];'Please wait'};
    end
end

release(v);
T6B9_Automated(app);
movefile(VideoFileName,[PosFileName '/4_FinalResults_Video/'])

app.T6L1.Text={'Done with making the video.';'The video file is in '; [PosFileName '/4_FinalResults_Video folder.']};
app.T6Lamp1.Color='g';pause(0.001)

end