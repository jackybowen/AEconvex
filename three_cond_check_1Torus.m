% check 3 conditions for almost-everywhere stable
close all; clear all; clc
%case 1:
syms x
fx=-cos(x);
figure(1)
fplot((@(x) -cos(x)),[-pi,pi])
title('F(x)=-cos(x)')
grid on
[an,bn,f]=fseries(fx,x,12,-pi,pi)   % first 12 terms of an(startfrom a0) and bn
%case 2:
fx=exp(-cos(x));
figure(2)
fplot((@(x) exp(-cos(x))),[-pi,pi])
grid on
[an,bn,f]=fseries(fx,x,12,-pi,pi)   % first 12 terms of an(startfrom a0) and bn
an = eval(an)
bn = eval(bn)
title('F(x)=e^{-cos(x)}')
% solve an*((0:1:n).*sin((0:1:n)*w*x)) == bn*((1:n).*cos((1:n)*w*x)
%case 3:
fx=(-cos(x))^2;
figure(3)
fplot((@(x) (-cos(x))^2),[0,pi])
title('F(x)=cos^2(x)')
grid on
[an,bn,f]=fseries(fx,x,12,0,pi)   % first 12 terms of an(startfrom a0) and bn


