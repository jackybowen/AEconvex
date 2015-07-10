function map2torus( xy, R, r )
% map2TORUS
%   draw 3d plot of f(x,y) on 2-torus
%       Input: fxy -------- function handle
%       Output: null
delta = pi/10;
theta = -pi : delta : pi;
phi   = -pi : delta : pi;       
[phi,theta] = meshgrid(phi,theta);

x = (R+r.*cos(theta)).*cos(phi);
y = (R+r.*cos(theta)).*sin(phi);
z = r.*sin(theta);
colormap([0,0,0]);
mesh(x,y,z); light; axis('equal'); axis off; 
view(30,20) %box
hold on;

for i = 1:length(xy)
    t1 = xy{i}(:,1);
    t2 = xy{i}(:,2);
    px = (R+r.*cos(t1)).*cos(t2);
    py = (R+r.*cos(t1)).*sin(t2);
    pz = r.*sin(t1);
    plot3(px,py,pz,'b-');
end
title('Torus whose surface is traversed by phaseportrait');
hold off
end
