function map2sphere(xy, xyspan)
% map2sphere
%   draw 3d plot of f(x,y) on 2-sphere
%       Input: fxy -------- function handle
%       Output: null
delta = pi/20;
phi   = -pi/2 : delta : pi/2;
theta = -pi : delta : pi;
[phi,theta] = meshgrid(phi,theta);
x0 = 0; y0 = 0; z0 = 0;
R = 1;

x = x0 + R.*cos(theta).*cos(phi);
y = y0 + R.*sin(theta).*cos(phi);
z = z0 + R.*sin(phi);
colormap([0,0,0]);
mesh(x,y,z); light; axis('equal'); axis off;
view(30,20) %box
hold on;

for i = 1:length(xy)
    t1 = xy{i}(:,1);
    t2 = xy{i}(:,2);
    px = x0+R.*cos(t2).*cos(t1);
    py = y0+R.*sin(t2).*cos(t1);
    pz = z0+R.*sin(t1);
    plot3(px,py,pz,'b-');
end
title('Sphere whose surface is traversed by phaseportrait');
hold off
end
