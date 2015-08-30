close all; clear all; clc
x_center = [2 2];
F = @(x) 2*x(1)^4-x(1)^2*x(2)^2+2*x(1)^3*x(2)+5*x(2)^4+1e4*bump(x,x_center);
 
figure(1)
x = -5:0.1:5;
y = -5:0.1:5;
[xx,yy] = meshgrid(x,y);
xy = num2cell([xx(:),yy(:)],2);
surf(xx,yy,reshape(cellfun(F,xy),size(xx))) % R^2