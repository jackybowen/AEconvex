function map2sphere(xy,arrs)
% map2sphere
%   draw 3d plot of f(x,y) on 2-sphere
%       Input: fxy -------- function handle
%       Output: null
delta = pi/20;
phi   = -pi : delta : pi;
theta = -pi/2 : delta : pi/2;
[phi,theta] = meshgrid(phi,theta);
x0 = 0; y0 = 0; z0 = 0;
r = 1;

x = x0 + r.*cos(theta).*cos(phi);
y = y0 + r.*cos(theta).*sin(phi);
z = z0 + r.*sin(theta);
colormap([0,0,0]);
mesh(x,y,z); light; axis('equal'); %axis off;
view(30,20) %box
hold on;

for i = 1:size(xy,1)
    t1 = xy{i}(:,1);
    t2 = xy{i}(:,2);
    px = x0+r.*cos(t2).*cos(t1);
    py = y0+r.*cos(t2).*sin(t1);
    pz = z0+r.*sin(t2);
    plot3(px,py,pz,'b-');
% draw arrows on the sphere
    t1 = arrs{i}(:,1);
    t2 = arrs{i}(:,2);
    ax = x0+r.*cos(t2).*cos(t1);
    ay = y0+r.*cos(t2).*sin(t1);
    az = z0+r.*sin(t2);
    plot3(ax,ay,az,'r')
end
title('Sphere whose surface is traversed by phaseportrait');
hold off
end
