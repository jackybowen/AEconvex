function stereog2plane( )
%STEREOG2PLANE 
%   stereographic projection from spherical coordinates to flat plane
%   
delta = pi/20;
phi   = -pi : delta : pi;
theta = -pi/2 : delta : pi/2;
x0 = 0; y0 = 0; z0 = 0;
r = 1;
[phi,theta] = meshgrid(phi,theta);
F = -cos(phi)-cos(2*theta);

x = x0 + r.*cos(theta).*cos(phi);
y = y0 + r.*cos(theta).*sin(phi);
z = z0 + r.*sin(theta);
X = x./(1-z);
Y = y./(1-z);

contour(X,Y,z); light; axis('equal'); %axis off;
view(30,20) %box

end

