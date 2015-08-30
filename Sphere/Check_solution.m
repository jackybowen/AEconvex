close all; clear all; clc
syms theta phi;
alpha = 1; beta = 1;

for delta = 1.8:0.1:2
    % soln is the \theta equlibrium point
    soln(1) = vpasolve(alpha*cos(theta)*cos(0)==2*beta*cos(2*theta+delta),theta,0.2);
    soln(2) = vpasolve(alpha*cos(theta)*cos(0)==2*beta*cos(2*theta+delta),theta,2);
    figure(1)
    ezplot(alpha*cos(theta)*cos(0))
    hold on
    ezplot(2*beta*cos(2*theta+delta))
    title('\alpha*cos(\theta)*cos(\phi) = 2*\beta*cos(2*\theta+\delta),\phi=0')
    axis([0 pi -2*beta 2*beta])

    pause
    
    soln(3) = vpasolve(alpha*cos(theta)*cos(pi)==2*beta*cos(2*theta+delta),theta,0.2);
    soln(4) = vpasolve(alpha*cos(theta)*cos(pi)==2*beta*cos(2*theta+delta),theta,1.5);
    figure(2)
    ezplot(alpha*cos(theta)*cos(pi))
    hold on
    ezplot(2*beta*cos(2*theta+delta))
    title('\alpha*cos(\theta)*cos(\phi) = 2*\beta*cos(2*\theta+\delta),\phi=\pi')
    axis([0 pi -2*beta 2*beta])
    
    pause
% Laplacian of F = cot(theta)*diff(F,theta) + diff(F,theta,2)+diff(F,phi,2)/sin(theta)^2
%               = -alpha*cos(theta)^2/sin(theta)*cos(phi)+2*beta*cos(theta)*cos(2*theta+delta)/sin(theta)+alpha*(sin(theta)+1)*cos(phi)-4*beta*sin(2*theta+delta)
    d2F = @(theta, phi) -alpha*cos(theta)^2/sin(theta)*cos(phi)+2*beta*cos(theta)*cos(2*theta+delta)/sin(theta)...
        +alpha*cos(phi)/sin(theta)-4*beta*sin(2*theta+delta);
    % sign of Laplacian
    Lap_sign = subs(d2F,{theta,phi},{soln,[0,0,pi,pi]})>0
    if sum(Lap_sign) == 1 
        break
    end
    
end






