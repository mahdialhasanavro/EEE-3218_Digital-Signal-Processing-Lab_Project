clc;
clear all;
close all;

Fs = 44000 ; 
ch = 1 ; 
data_type = 'uint8' ; 
nbits = 16 ; 
Nseconds = 12 ; 

recorder_1=audiorecorder(Fs,nbits,ch) 
disp('start speaking')
recordblocking(recorder_1,Nseconds);
disp('stop')
x1=getaudiodata(recorder_1,data_type);
audiowrite('Input_audio.wav',x1,Fs)

r_1=audioread('Input_audio.wav') 

audio_data_1 = r_1.' ;

dt = 1/Fs ;
t=0:1/Fs:(length(x1)-1)/Fs ;

figure(1)
plot(t,audio_data_1) ;
title('Audio Signal Data 1 (Time Domain)')
grid on
xlabel('Time (sec) ')
ylabel('  Magnitude  ')

N = 262144 ;
df = Fs/N ;

f = -Fs/2 : df : Fs/2-df ;

fft_audio_data_1 = fft(audio_data_1,N) ; 



figure(2)
stem(f,fftshift(abs(fft_audio_data_1)))
grid on
title(' FFT of Audio Data 1 (Frequency Domain) ')
grid on
xlabel('Frequency (Hz) ')
ylabel(' | Magnitude | ')

Fc = 3700 ; 
Ts = 1/Fs ; 

Wd = 2*pi*Fc ; 
Wa = (2/Ts)*tan((Wd*Ts)/2) ; 

num = 1 ; 
den = [1 1] ; 

[A, B] = lp2lp(num, den, Fc) ;
[a, b] = bilinear(A, B, Fs) ;

[hz, fz] = freqz(a, b, N, Fs) ;

figure(5)
freqz(den,num,Fc,2*Fc)
title(' Frequency response of designed Filter ')

phi = 180*unwrap(angle(hz))/pi ;

filtered_audio_data_1 = filter(a,b,audio_data_1) ;

figure(3)
plot(t,filtered_audio_data_1)
title(' Filtered Data in Time Domain ')
grid on
xlabel('Time (sec) ')
ylabel('  Magnitude  ')

figure(4)
stem(t,fftshift(abs(filtered_audio_data_1)))
title(' Low pass Filtered Data in Frequency Domain ')
grid on
xlabel('Frequency (Hz) ')
ylabel('  Magnitude ')
