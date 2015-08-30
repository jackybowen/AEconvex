close all; clear all; clc

alpha = 1;
beta = 30;
x1 = 2; y1 = 2;
f = @(x,y) x.^2+y.^2+beta*exp(-alpha*((x-x1).^2+(y-y1).^2));
x = -5:.1:5;
y = -5:.1:5;
[xx,yy] = meshgrid(x,y);
figure(1)
surf(xx,yy,reshape(f(xx(:),yy(:)),size(xx)))
% Polynomial Approximation starts from 2nd order ( exp(x) ~= 1 + x + 1/2*x^2 )
% figure(2)
% 
% f1 = @(x,y) beta*(1-((x-x1).^2+(y-y1).^2)+1/2*((x-x1).^2+(y-y1).^2).^2);
% surf(xx,yy,reshape(f1(xx(:),yy(:)),size(xx)))
% 
% figure(3)
% f2 = @(x,y) beta*(1-((x-x1).^2+(y-y1).^2)+1/2*((x-x1).^2+(y-y1).^2).^2 ...
%     - 1/6*(((x-x1).^2+(y-y1).^2).^3));
% surf(xx,yy,reshape(f2(xx(:),yy(:)),size(xx)))
% axis([-10,10,-10,10,-1e5,100])
% 
% figure(4)
% f3 = @(x,y) beta*(1-((x-x1).^2+(y-y1).^2)+1/2*((x-x1).^2+(y-y1).^2).^2 ...
%     - 1/6*(((x-x1).^2+(y-y1).^2).^3)+1/12*(((x-x1).^2+(y-y1).^2).^4));
% surf(xx,yy,reshape(f3(xx(:),yy(:)),size(xx)))




