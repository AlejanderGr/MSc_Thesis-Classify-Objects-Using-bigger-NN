% We calculate the curvature for an image. Then we train a NAR network 
%which is supposed to learn the entire curvature function. We group
%the pics properly and thus we create the basis-NN. 
%We can feed a NN with data that come from more than one images but for 
%this purpose we need bigger NN.

clear all

netMat=cell(1,10*8);


coilPics=[1 4 5 8 11 13 14 15 16 18]; 

totalPoses=[70 71 1 2  8 9 11 12  16 17 19 20  24 25 27 28  34 35 37 38  43 44 46 47  51 52 54 55  58 59 61 62];


feedbackDelays = 1:2;
hiddenLayerSize = 17;
netType = narnet(feedbackDelays,hiddenLayerSize);
netType.divideParam.trainRatio = 70/100;
netType.divideParam.valRatio = 30/100;
netType.divideParam.testRatio = 0/100;        
netType.trainParam.goal = 1e-10;
%netType.trainParam.min_grad = 1e-10;
%netType.trainParam.max_fail=10;

nnNum=1;

for objNum=coilPics
    
    for poseNum=1:1:numel(totalPoses) 
        kamp=[];
        for i=0:0 %if you switch is to eg 0:2 you will train one NN with data from 3 successive images
            image=imread( sprintf('coil/obj%d__%d.png', objNum,totalPoses(poseNum+i) )  );
            [X,Y]=FUNfindContour(image);
            kamp=[kamp, FUNcalcKampParametriki2ou(X,Y,0,0)];
        end
        
        kamp=tonndata(kamp,true,false);
        %Train NN   
        [x,xi,ai,t] = preparets(netType,{},{},kamp);
        [net,tr] = train(netType,x,t,xi,ai);
        
        netMat(nnNum)={net};
        nnNum=nnNum+1;        
        
    end
        
end


save curveNets netMat
save curveNetType netType