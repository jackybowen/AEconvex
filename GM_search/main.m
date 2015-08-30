close all; clear all; clc
% This code would search for the global minimum of polynomial function F

x_center = [2 2];
F = @(x) 2*x(1)^4-x(1)^2*x(2)^2+2*x(1)^3*x(2)+5*x(2)^4+1e4*bump(x,x_center);

figure(1)
% xx = -1.2:0.01:1.2;
% plot(xx,cellfun(F,num2cell(xx)))  % R^1
x = -5:0.1:5;
y = -5:0.1:5;
[xx,yy] = meshgrid(x,y);
xy = num2cell([xx(:),yy(:)],2);
surf(xx,yy,reshape(cellfun(F,xy),size(xx))) % R^2

% axis([-1,1,-1,1,0,0.5])
%% specify the initial condition
% x_0 = [];
% ode45()




%% compute the function F's first equilibrium point





%% search for other equilibrium point and compare








