close all;
clear all;
clc;

%FREQUENCY MODULATION
fs=1000;
t=0:1/fs:1;

fm=10;
Am=1;
message_signal=Am*sin(2*pi*fm.*t);

fc=100;
Ac=2;
carrier_signal=Ac*sin(2*pi*fc.*t);


kf=25;
modulated_signal=Ac*sin(2*pi*fc.*t + kf*message_signal);

figure;

subplot(3,1,1);
plot(t,message_signal);
title('Message Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t,carrier_signal);
title('Carrier Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t,modulated_signal);
title('Modulated Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

%DEMOULATION
demodulated_signal=[diff(modulated_signal) 0]*fs;

%RECTIFICATION
rectified_signal=abs(demodulated_signal);

figure;
subplot(2,1,1);
plot(t,demodulated_signal);
title('Demodulated Sgnal');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t,rectified_signal);
title('Rectified Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;


%FIR LPF
cutoff_freq=20;
numtaps=20;
normalized_cutoff_freq=cutoff_freq/(fs/2);
fir_coeff=fir1(numtaps-1,normalized_cutoff_freq,'low');

filtered_signal=filter(fir_coeff,1,rectified_signal);

figure;
subplot(2,1,1);
plot(t,rectified_signal);
title('Rectified Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t,filtered_signal);
title('Filtered Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;
