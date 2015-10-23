clear all;close all;clc
alpha = 30;
x_center = [20,10]
[xx,yy]=meshgrid(-10:.5:10,-10:.5:10);
f = @(x) x(1)^2 + x(2)^2 + alpha/((x(1)-x_center(1))^2+(x(2)-x_center(2))^2+1);
xy = [xx(:),yy(:)];
surf(xx,yy,reshape(cellfun(f,num2cell(xy,2)),size(xx)))


