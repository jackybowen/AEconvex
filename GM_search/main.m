close all; clear all; clc
% This code would search for the global minimum of polynomial function F
% To solve the optimization problem as follows
% min F(x)
% s.t. h(x) = 0
% let h(x) = x'x - c
b_center = [2 2];
scl = 30;
F = @(x) x(1)^2+x(2)^2 + x(3)^2 + scl*exp(-((x(1)-b_center(1))^2+(x(2)-b_center(2))^2));
c = 2;

% figure(1)
% % xx = -1.2:0.01:1.2;
% % plot(xx,cellfun(F,num2cell(xx)))  % R^1
% x = -5:0.1:5;
% y = -5:0.1:5;
% [xx,yy] = meshgrid(x,y);
% xy = num2cell([xx(:),yy(:)],2);
% surf(xx,yy,reshape(cellfun(F,xy),size(xx))) % R^2

% solve for the corresponding discrete time system
% x_n+1= x_n - Del(F)

figure
x_n = [-10 -2 2 0];  % initial condition [x1 x2 x3 \lambda]
tf = 300; tt = 0.01;

DFx = @(x) 2*x(1) + (-2 * (x(1)-b_center(1))) * scl * exp(-((x(1)-b_center(1))^2+(x(2)-b_center(2))^2));
DFy = @(x) 2*x(2) + (-2 * (x(2)-b_center(2))) * scl * exp(-((x(1)-b_center(1))^2+(x(2)-b_center(2))^2));
DFz = @(x) 2*x(3);

for i = 1:1:tf-1
    x1_nn = x_n(i,1) - tt * (DFx(x_n(i,:)) + 2*x_n(i,1) * x_n(i,end)/sqrt(x_n(i,:)*x_n(i,:)'));
    x2_nn = x_n(i,2) - tt * (DFy(x_n(i,:)) + 2*x_n(i,2) * x_n(i,end)/sqrt(x_n(i,:)*x_n(i,:)'));
    x3_nn = x_n(i,3) - tt * (DFz(x_n(i,:)) + 2*x_n(i,3) * x_n(i,end)/sqrt(x_n(i,:)*x_n(i,:)'));
    x4_nn = x_n(i,4) + tt * sqrt(x_n(i,:)*x_n(i,:)' - c);
    x_n = [x_n; [x1_nn x2_nn x3_nn x4_nn]];
end
plot(1:tf,x_n(:,1))
hold on
plot(1:tf,x_n(:,2))
plot(1:tf,x_n(:,3))
plot(1:tf,x_n(:,4))
legend('x','y','z','{\lambda}')


% axis([-1,1,-1,1,0,0.5])
% %% specify the initial condition
% % x_0 = [];
% % ode45()
% 
% 
% 
% 
% %% compute the function F's first equilibrium point
% 
% 
% 
% 
% 
% %% search for other equilibrium point and compare
% 
% 






