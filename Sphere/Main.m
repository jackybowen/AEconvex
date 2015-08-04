clear all; close all; clc
delta = pi/20;
phi   = 0 : delta : 2*pi;
theta = 0 : delta : pi;
[phi,theta] = meshgrid(phi,theta);
x0 = 0; y0 = 0; z0 = 0;
r = 1;

x = x0 + r.*sin(theta).*cos(phi);
y = y0 + r.*sin(theta).*sin(phi);
z = z0 + r.*cos(theta);
h = surf(x,y,z);
%zoom(10);
disp('Click anywhere on the surface, then hit return')
pause
[p v vi face facei] = select3d(h);
marker1 = line('xdata',p(1),'ydata',p(2),'zdata',p(3),'marker','o',...
            'erasemode','xor','markerfacecolor','k');
marker2 = line('xdata',v(1),'ydata',v(2),'zdata',v(3),'marker','o',...
            'erasemode','xor','markerfacecolor','b');
% marker2 = line('erasemode','xor','xdata',face(1,:),'ydata',face(2,:),...
%             'zdata',face(3,:),'linewidth',10);
disp(sprintf('\nYou clicked at\nX: %.2f\nY: %.2f\nZ: %.2f',p(1),p(2),p(3)'))
disp(sprintf('\nThe nearest vertex is\nX: %.2f\nY: %.2f\nZ: %.2f',v(1),v(2),v(3)'))
