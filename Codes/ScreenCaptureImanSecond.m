%This function capture images from the screen in Tab 6.
%robo is related to Java
%rectangle is window for getting the image 
function outputImage=ScreenCaptureImanSecond(robo,rectangle)

image1 = robo.createScreenCapture(rectangle);

h=image1.getHeight();
w=image1.getWidth();
data=image1.getData();
pix=data.getPixels(0,0,w,h,[]);

tmp=reshape(pix(:),3,w,h);
outputImage(1:h,1:w,1:3)=0;
for k=1:3
    outputImage(:,:,k)=squeeze(tmp(k,:,:))';
end
outputImage=uint8(outputImage);
end