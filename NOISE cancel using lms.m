clc;
clear all;
order = 2;
size = 2;
fs = 8192;
t = (0:1/fs:size);
N = fs*size;
f1 = 35/2;
f2 = 99/2;
voice = cos (2*pi*f1*t);
subplot(4,1,1);
plot(t,voice);
title('voice (do not have access to)')
noise=cos(2*pi*f2*t.^2);
primary  =  voice + noise;
subplot(4,1,2)
plot(t,primary)
title('primary = voice + noise (input1)')
ref = noise+.25*rand;
subplot(4,1,3)
plot(t,ref)
title('referance (noisy noise) (input2)')
 mu=0.006;
 n=length(primary);
 delayed=zeros(1,order);
 adap=zeros(1,order);
 cancelled=zeros(1,n);
 
 for i = 1:N 
    delayed(1)=ref(i);
     y=delayed*adap';
     cancelled(i)=primary(i)-y;
     adap = adap + 2*mu*cancelled(i) .* delayed;
     delayed(2:order)=delayed(1:order-1);
    
end

 
 subplot(4,1,4);
 plot(t,cancelled);
 title('adaptive output (hopefully it isclose t "voice")')

