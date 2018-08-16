%This functions uses all the existing Neural Networks and a calculated 
%curvature of an image. We use NAR NN
%In every step we predict the next curvature value using all the NN and
%calculate their errors. The Network which has given the minimum average
%error wins and it performs the classification
%It is used in curveFitTest.m


function [ netErrors ] = FUNPrediction( kamp,netMat,netType )

nnNum=numel(netMat);
testData=tonndata(kamp,true,false); 
[x,xi,ai,t] = preparets(netType,{},{},testData);


netErrors=zeros(1,nnNum);


for nn=1:nnNum 
        net=nncell2mat(netMat(nn));
        provlepsi = net(x,xi,ai);
        netErrors(nn)= mean( abs( fromnndata(gsubtract(t,provlepsi),1,1,0) ) );
end


end

