close all 
clear all

alpha=1;
beta=1;
xx=10*randn(1,1);
yy=10*randn(1,1);

%In this example we change the error tolerances using the odeset command and solve on a time interval [0 12] with an initial condition vector [0 1 1] at time 0.

%options = odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-5]);
[T,Y] = ode45(@rigid,[0 900000],[xx yy]);

plot(T,Y(:,1),'-',T,Y(:,2),'-.')
legend('x','y')

% hold on 
% 
% plot(T,Y(:,1).^2+Y(:,2).^2+Y(:,3).^2)