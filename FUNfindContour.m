%This function takes an image, finds the contour and extracts the x and y 
%coordinates of eachpixel. The image should have black background. 
%It tested on the COIL20 database

function [ x,y ] = FUNfindContour( image )

im=image;
%im=imrotate(im,0);
im(im<10)=0; 
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
im = imdilate(im, [se90 se0]);
im = imfill(im, 'holes');
[yStart, xStart]=find(im,1);
contour=bwtraceboundary(im, [yStart, xStart],'SE');
x=contour(:,2);
y=contour(:,1);
y=-y;
y=y+abs(min(y))+1;
%x=x';y=y';

end

