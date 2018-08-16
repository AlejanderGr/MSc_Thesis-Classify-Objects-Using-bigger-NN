%We perform the curve and the curvature estimation using x(s) and y(s) and
%2nd order polynomials

function [ kamp2 ] = FUNcalcKampParametriki2ou( x,y, rot, trans )

ds=1;
lseN=10;


x=[x(end-lseN:end-1); x; x(2:1+lseN)];
y=[y(end-lseN:end-1); y; y(2:1+lseN)];


gonia_perist=rot;%rotation in degrees
xRot=cosd(gonia_perist)*x+sind(gonia_perist)*y;
yRot=-sind(gonia_perist)*x+cosd(gonia_perist)*y;
x=xRot+trans;%transition in pixels
y=yRot+trans;

S=zeros(length(x),1);
for i=1:length(x)-1
    S(i+1)=S(i)+pdist2( [x(i),y(i)], [x(i+1) y(i+1)]);
end

p=lseN+1;
s=S(p);
i=1;
while p<=length(S)-lseN+1
    
    sampleS=S(p-lseN:p+lseN-1);
    sampleX=x(p-lseN:p+lseN-1);
    sampleY=y(p-lseN:p+lseN-1); 
    
    matA=[sampleS.^2 , sampleS, ones( length(sampleS),1 ) ];
    matBx=matA \ sampleX;
    matBy=matA \ sampleY; 
    

    dx2=2*matBx(1);
    dy2=2*matBy(1); 
      
    kamp(i)=sqrt( (dx2)^2+(dy2)^2 );
    
    i=i+1;
    s=s+ds;
    p=find(S>s,1);  
end

windowSize = 9;
b = (1/windowSize)*ones(1,windowSize);
a = 1;
kamp2=filtfilt(b,a,kamp);

%{
%PLOT
figure
plot(x,y,'o')
hold on
plot(xEkt,yEkt,'r','Linewidth',2)
daspect([1 1 1])
legend('points','ektimisi')
plot(xEkt(1),yEkt(1),'x g','MarkerSize',10,'Linewidth',2)
hold off

figure
plot(kamp,'-')
legend('ektimomeni kampilotita')
hold on
plot(kamp2,'o-g')
legend('ektimomeni kampilotita','filtrarismeni kampilotita')
hold off
%}


end

