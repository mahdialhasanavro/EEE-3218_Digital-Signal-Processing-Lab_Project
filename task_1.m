clc;
clear all;
close all;

sine = dsp.sineWave(1,[100 200],'SampleRate',1250,'SamplesPerFrame',52);
n=-10:10;
x=sign(2*pi*100*n)+sin(2*pi*200*n);
figure(1)
stem(n,x,'Linewidth', 2);
title('Orginal Signal')

L=3;
[xup,nup]= upsampling (x,n,L);
figure(2)
stem(nup, nux, 'Linewidth', 2);
title (['Up Sampled Signal by ', Num2str(L)]);

M=2;
[xdown, ndown]= downsampling (x,n,M);
figure(3)
stem(ndown, xdown, 'Linewidth', 2);
title (['Down Sampled Signal by ', Num2str(L)]);

tx = (0:length(X)-1)/sine.SampleRate;
firrc = dsp.FIRRateConverter(3,2);
y = firrc(x);
FsIn = sine.SampleRate;
[delay,FsOut]=outputDelay(firrc,FsIn==FsIn);
ty = (0:length(y)-1)/FsOut-delay;
figure(4)
stem(tx,x,'filled', MarkerSize==4);
hold on
stem(ty,y)
hold off
xlim([0.0 0.0145])
ylim([-1.5 1.5])
legend('Original Input','Resampled')
