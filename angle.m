clc
clear
lambda=0.6328e-3;
w0=1; % ��ʼ��߰뾶
 
f=(pi*w0^2)/lambda;
 
F1=-50;   % ��һ��͸������
Mf1=[1,0;-1/F1,1];    % ��͸���������
F2=200;		%�ڶ���͸������
Mf2=[1,0;-1/F2,1];	  % ��͸���������
z=linspace(0,500,1000);
q0=1/(-1i*lambda/pi/w0^2);
L1=100;

 
wz=zeros(size(z));   % ÿ��λ�õĹ�ߴ�С��ɵ�����
az=zeros(size(z));   % ÿ��λ�õķ�ɢ����ɵ�����

for gk =1:1000   
      if z(gk)<=L1
         M=[1,z(gk);0,1];
         q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));
         wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);
         az(gk)=2*lambda/(pi*wz(gk));    % ��ɢ�ǹ�ʽ
         
     elseif z(gk)>L1&&z(gk)<=(100+F1+F2)
                 M=[1,z(gk)-L1;0,1]*Mf1*[1,L1;0,1];
                  q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));
                      wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);
                     az(gk)=2*lambda/(pi*wz(gk));   % ��ɢ�ǹ�ʽ
      elseif z(gk)>(100+F1+F2)
             M=[1,z(gk)-(L1+F1+F2);0,1]*Mf2*[1,+F1+F2;0,1]*Mf1*[1,L1;0,1];
             q=(M(1,1)*q0+M(1,2))/(M(2,1)*q0+M(2,2));
        wz(gk)=sqrt(-1/imag(1/q)/pi*lambda);
        az(gk)=2*lambda/(pi*wz(gk));     % ��ɢ�ǹ�ʽ
      end
       
end
figure(1)
plot(z,az,'b',z,-az,'b');
title('��˹�����ķ�ɢ��');
xlabel('z/mm');
ylabel('az/mm');
hold on;
