[y,fs,bits]=wavread('C:\Users\ibm\Desktop\a.wav');      %�����źŵĲɼ�
n1=length (y) ;    %��������źŵĳ���
Y=fft(y,n1);       %����Ҷ�任
f=8000000; %�ز�Ƶ��
M=size(y);
t=0:1:M-1;
s=sin(f*2*3.14*t);%�����ز�����
s=s';  %������
c=[s,s];
A0=1;
A=ones(M);%����ֱ������
y1=(y+A).*c;%ͬ�����ƣ����źż���
n2=length(y1);
Y1=fft(y1,n2);       %����Ҷ�任
wavwrite(y1, 'C:\Users\ibm\Desktop\����.wav');% ���ܺ����Ƶ�ź���Ϊ������.wav��
y2=y1.*c; %���ز����
n3=length(y2);
Y2=fft(y2,n3);
Ft=8000;
Fp=1000;
Fs=1200;
wp=2*pi*Fp/Ft;
ws=2*pi*Fs/Ft;
fp=2*Ft*tan(wp/2);
fs=2*Fs*tan(wp/2);
[n11,wn11]=buttord(wp,ws,1,50,'s');    %���ͨ�˲����Ľ����ͽ�ֹƵ��
[b11,a11]=butter(n11,wn11,'s');        %��S���Ƶ����Ӧ�Ĳ��� 
[num11,den11]=bilinear(b11,a11,0.5);  %����˫���Ա任ʵ��Ƶ����ӦS��Z��ı任 
z11=filter(num11,den11,y2);        %��ͨ�˲�����ź�
n4=length(z11);
m11=fft(z11,n4);          %���˲�����ź�Ƶ��
figure;
subplot(2,1,1);
plot(z11);
subplot(2,1,2);
plot(abs(m11));
[a,b]=size(z11);
B=ones(a,b);
y3=z11-0.5*B;   %��ȥֱ������
figure;
subplot(3,2,1);
plot(y);
title('ԭʼ�źŲ���');
subplot(3,2,2);
plot(abs(Y)); title('ԭʼ�ź�Ƶ��');
subplot(3,2,3);
plot(y1);
title('�����źŲ���');
subplot(3,2,4);
plot(abs(Y1)); 
title('�����ź�Ƶ��');
subplot(3,2,5);
plot(y3);
title('�����źŲ���');
n4=length(y3);
Y3=fft(y3,n4);%����Ҷ�任
subplot(3,2,6);
plot(abs(Y3));
title('�����ź�Ƶ��');
wavwrite(y3, 'C:\Users\ibm\Desktop\����.wav');% ���ܺ����Ƶ�ź���Ϊ������.wav��