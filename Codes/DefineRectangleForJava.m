%This function defines the window for making video in Tab 6
function [robo,rectangle]=DefineRectangleForJava(app)

screenSize=get(0,'ScreenSize');
appPos=app.DSF.Position;

switch app.T6EF1.Value
    case 1
        LeftFigPos=app.T6F1.Position;
    case 2
        LeftFigPos=app.T6F2.Position;
    case 3
        LeftFigPos=app.T6F3.Position;
    case 4
        LeftFigPos=app.T6F4.Position;
    case 5
        LeftFigPos=app.T6F5.Position;
end

switch app.T6EF2.Value
    case 1
        RightFigPos=app.T6F1.Position;
    case 2
        RightFigPos=app.T6F2.Position;
    case 3
        RightFigPos=app.T6F3.Position;
    case 4
        RightFigPos=app.T6F4.Position;
    case 5
        RightFigPos=app.T6F5.Position;
end

BorderLeft=app.T6EF3.Value;
BorderRight=app.T6EF4.Value;
BorderTop=app.T6EF5.Value;
BorderBottom=app.T6EF6.Value;

x=appPos(1,1)+LeftFigPos(1,1)-BorderLeft;
y=screenSize(1,4)-(appPos(1,2)+LeftFigPos(1,2)+LeftFigPos(1,4))-BorderTop;
w=(RightFigPos(1,1)+RightFigPos(1,3)+BorderRight+BorderLeft)-LeftFigPos(1,1);
h=LeftFigPos(1,4)+BorderBottom+BorderTop;

robo = java.awt.Robot;
rectangle = java.awt.Rectangle(x,y,w,h);

end