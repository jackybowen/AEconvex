clear all; close all; clc

delta = pi/20;
phi   = -pi : delta : pi;
theta = -pi/2 : delta : pi/2;
x0 = 0; y0 = 0; z0 = 0;
r = 1;
[phi,theta] = meshgrid(phi,theta);
F = -cos(phi);

x = x0 + r.*cos(theta).*cos(phi);
y = y0 + r.*cos(theta).*sin(phi);
z = z0 + r.*sin(theta);
X = x./(r-z);
Y = y./(r-z);

surf(X,Y,F); light; axis('equal'); %axis off;
hold on
plot3(-1,0,0,'ro')
plot3(1,0,-2,'g*')

% axis([-2,0,-1,1])
view(30,20) %box