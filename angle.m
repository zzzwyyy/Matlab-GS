clc
clear
lambda=0.6328e-3;
w0=1; % 初始光斑半径
 
f=(pi*w0^2)/lambda;
 
F1=-50;   % 第一个透镜焦距
Mf1=[1,0;-1/F1,1];    % 薄透镜传输矩阵
F2=200;		%第二个透镜焦距
Mf2=[1,0;-1/F2,1];	  % 薄透镜传输矩阵
z=linspace(0,500,1000);
q0=1/(-1i*lambda/pi/w0^2);
L1=100;

 
wz=zeros(size(z));   % 每个位置的光斑大小组成的数组
az=zeros(size(z));   % 每个位置的发散角组成的数组

for gk =1:1000   
      if z(gk)<=L1
         M=[1,z(gk);0,1];
         q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));
         wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);
         az(gk)=2*lambda/(pi*wz(gk));    % 发散角公式
         
     elseif z(gk)>L1&&z(gk)<=(100+F1+F2)
                 M=[1,z(gk)-L1;0,1]*Mf1*[1,L1;0,1];
                  q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));
                      wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);
                     az(gk)=2*lambda/(pi*wz(gk));   % 发散角公式
      elseif z(gk)>(100+F1+F2)
             M=[1,z(gk)-(L1+F1+F2);0,1]*Mf2*[1,+F1+F2;0,1]*Mf1*[1,L1;0,1];
             q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));
        wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);
        az(gk)=2*lambda/(pi*wz(gk));     % 发散角公式
      end
       
end
figure(1)
plot(z,az,'b',z,-az,'b');
title('高斯光束的发散角');
xlabel('z/mm');
ylabel('az/mm');
hold on;
