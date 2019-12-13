clc
clear
lambda=0.6328e-3;   % 波长
w0=0.5;   % 光斑半径
 
f=(pi*w0^2)/lambda;   % q0（虚部） 
 
F1=-6.2;   % 第一个透镜焦距
Mf1=[1,0;-1/F1,1];    % 薄透镜传输矩阵
F2=225;		%第二个透镜焦距
Mf2=[1,0;-1/F2,1];	  % 薄透镜传输矩阵
z=linspace(0,500,1000);   % 0到500的长度，分为1000份，每一小格为0.5；   z=[0:0.5:500]
q0=1/(-1i*lambda/pi/w0^2);    % z=0时，q参数的值, q0=i*f
L1=100;    % 焦点到第一个薄透镜之间的距离

 
wz=zeros(size(z));
  
for gk =1:1000     % 从1到1000的循环
      if z(gk)<=L1     % 第一部分
         M=[1,z(gk);0,1];     % z(gk)为光线进行的距离， M为系统传输矩阵
         q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));   % 传输之后的q参数  
         wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);      % 光斑大小，imag函数为取虚部
     elseif z(gk)>L1&&z(gk)<=(100+F1+F2)     % 第二部分  （F1+F2为第二部分的长）
                 M=[1,z(gk)-L1;0,1]*Mf1*[1,L1;0,1];    
                 q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));
                 wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);
      elseif z(gk)>(100+F1+F2)     % 第三部分
             M=[1,z(gk)-(L1+F1+F2);0,1]*Mf2*[1,+F1+F2;0,1]*Mf1*[1,L1;0,1];
             q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));
             wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);
      end
end
figure(1)
plot(z,wz,'b',z,-wz,'b');
title('高斯光束的聚焦');
xlabel('z/mm');
ylabel('Wz/mm');
hold on;
