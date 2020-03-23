function outputImage=ScreenCaptureIman(x,y,w,h)


robo = java.awt.Robot;


rectangle = java.awt.Rectangle(x,y,w,h);

image1 = robo.createScreenCapture(rectangle);


h=image1.getHeight();
w=image1.getWidth();
data=image1.getData();
pix=data.getPixels(0,0,w,h,[]);

tmp=reshape(pix(:),3,w,h);
for ii=1:3
    outputImage(:,:,ii)=squeeze(tmp(ii,:,:))';
end
 

end