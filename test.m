clear;close all;clc
delta = pi/30; theta = 0 : delta : 2*pi;
phi   = 0 : delta : 2*pi;       
[phi,theta] = meshgrid(phi,theta);
r1 = 11/3; r2 = 1;
x = (r1+r2.*cos(theta)).*cos(phi);
y = (r1+r2.*cos(theta)).*sin(phi);
z = r2.*sin(theta);
sigma = 10;
y0 = [0 0.7]; t= 0:0.001:1;
ty = rem(t + y0(1),1);
tx = rem(t*sigma + y0(2),1);
px = (r1+r2.*cos(2*pi*tx)).*cos(2*pi*ty);
py = (r1+r2.*cos(2*pi*tx)).*sin(2*pi*ty);
pz = r2.*sin(2*pi*tx); colormap(jet);
mesh(x,y,z); light; axis('equal'); axis off; view(30,20) %box
hold on;
plot3(px,py,pz,'b.','markersize',5);
title('Torus whose surface is traversed by a point');
