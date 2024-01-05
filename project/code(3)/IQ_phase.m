function rawPhase = IQ_phase(fc,rec)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
rec=rec';
fs=48e3;
[b1,a1]=butter(4,[fc-100 fc+100]/(fs/2),'bandpass');
rec=filtfilt(b1,a1,rec);

len=length(rec);
t=(0:len-1)/fs;
signalCos=cos(2*pi*fc*t);
signalSin=-sin(2*pi*fc*t);
[b,a]=butter(3,20/(fs/2),'low');
signalI=filtfilt(b,a,rec.*signalCos);
signalQ=filtfilt(b,a,rec.*signalSin);

signalI=signalI-mean(signalI);
signalQ=signalQ-mean(signalQ);
phase=atan(signalQ./signalI);
rawPhase = phase;

figure
plot((1:length(phase))/fs,rawPhase)
xlabel('t/(s)')
title('Without unwrap')


waveLength=340/fc;
phase=unwrap(phase*2)/2;
distance=phase/2/pi*waveLength/2;

figure
plot((1:length(phase))/fs,distance)
xlabel('t/s')
title('With unwrap')


[b,a] = butter(2, 1/(fs/2), "high");
phase = filtfilt(b,a, phase);

distance=phase/2/pi*waveLength/2;
figure
plot((1:length(distance))/fs,distance)
xlabel('t/s')
ylabel('distance/m')
title('With unwrap')
end