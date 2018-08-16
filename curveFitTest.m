%In this part we use the basis-NN to classify a new image. For this image
%we calculate the curvature. We feed it to all the basis-NN and we
%calculate their errors. The network that gives the lowest error
%classifies the image.

clear all
load curveNets
load curveNetType


PicNum=1;

coilPics=[1 4 5 8 11 13 14 15 16 18]; 

totalPoses=32; % MUST BE =numel(totalPoses) from the curveFitTrain.m


poses=[0 10 18 26 36 45 53 60];


objClass=zeros(1,length(coilPics)*length(poses));
trueFalse=zeros(1,length(coilPics)*length(poses));


for objNum=coilPics
    
    for poseNum=poses         
        image=imread( sprintf('coil/obj%d__%d.png', objNum,poseNum)  );
        [x,y]=FUNfindContour(image);
        kamp=FUNcalcKampParametriki2ou(x,y,0,0);
        netErrors=FUNPrediction(kamp,netMat,netType );    
        
        [~, poseClass] =min(netErrors);        
        objClass(PicNum)=ceil(poseClass/totalPoses);  
        
         if ceil(PicNum/length(poses))==objClass(PicNum)
            trueFalse(PicNum)=1;
        else 
            trueFalse(PicNum)=0;
        end           
        
        PicNum=PicNum+1;        
        
    end
        
end
Accuracy=100*sum(trueFalse)/length(trueFalse);



