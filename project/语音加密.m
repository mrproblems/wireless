[y,fs,bits]=wavread('C:\Users\ibm\Desktop\a.wav');      %语音信号的采集
n1=length (y) ;    %求出语音信号的长度
Y=fft(y,n1);       %傅里叶变换
f=8000000; %载波频率
M=size(y);
t=0:1:M-1;
s=sin(f*2*3.14*t);%构造载波序列
s=s';  %矩阵倒置
c=[s,s];
A0=1;
A=ones(M);%构造直流分量
y1=(y+A).*c;%同步调制，给信号加密
n2=length(y1);
Y1=fft(y1,n2);       %傅里叶变换
wavwrite(y1, 'C:\Users\ibm\Desktop\加密.wav');% 加密后的音频信号名为“加密.wav”
y2=y1.*c; %与载波相乘
n3=length(y2);
Y2=fft(y2,n3);
Ft=8000;
Fp=1000;
Fs=1200;
wp=2*pi*Fp/Ft;
ws=2*pi*Fs/Ft;
fp=2*Ft*tan(wp/2);
fs=2*Fs*tan(wp/2);
[n11,wn11]=buttord(wp,ws,1,50,'s');    %求低通滤波器的阶数和截止频率
[b11,a11]=butter(n11,wn11,'s');        %求S域的频率响应的参数 
[num11,den11]=bilinear(b11,a11,0.5);  %利用双线性变换实现频率响应S域到Z域的变换 
z11=filter(num11,den11,y2);        %低通滤波后的信号
n4=length(z11);
m11=fft(z11,n4);          %求滤波后的信号频谱
figure;
subplot(2,1,1);
plot(z11);
subplot(2,1,2);
plot(abs(m11));
[a,b]=size(z11);
B=ones(a,b);
y3=z11-0.5*B;   %减去直流分量
figure;
subplot(3,2,1);
plot(y);
title('原始信号波形');
subplot(3,2,2);
plot(abs(Y)); title('原始信号频谱');
subplot(3,2,3);
plot(y1);
title('加密信号波形');
subplot(3,2,4);
plot(abs(Y1)); 
title('加密信号频谱');
subplot(3,2,5);
plot(y3);
title('解密信号波形');
n4=length(y3);
Y3=fft(y3,n4);%傅里叶变换
subplot(3,2,6);
plot(abs(Y3));
title('解密信号频谱');
wavwrite(y3, 'C:\Users\ibm\Desktop\解密.wav');% 解密后的音频信号名为“解密.wav”