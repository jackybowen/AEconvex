function map2plane(xy,arrs)
% map2plane
%   draw 2d plot of D_f(X,Y) on a plane
%       Input: fxy -------- function handle
%       Output: null
x0 = 0; y0 = 0; z0 = 0;
r = 1;

for i = 1:size(xy,1)
    t1 = xy{i}(:,1);
    t2 = xy{i}(:,2);
    px = x0+r.*sin(t2).*cos(t1);
    py = y0+r.*sin(t2).*sin(t1);
    pz = z0+r.*cos(t2);
    X = px./(r-pz);
    Y = py./(r-pz);
    plot(X,Y,'b-');
    hold on
% draw arrows on the sphere
    t1 = arrs{i}(:,1);
    t2 = arrs{i}(:,2);
    ax = x0+r.*sin(t2).*cos(t1);
    ay = y0+r.*sin(t2).*sin(t1);
    az = z0+r.*cos(t2);
    X = ax./(r-az);
    Y = ay./(r-az);
    plot(X,Y,'r-');
end
title('Phaseportrait on the plane');
hold off
end
