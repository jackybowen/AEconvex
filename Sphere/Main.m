clear all; close all; clc
global h;
global alpha beta epsl delta;
%% Formalize the function F(phi,theta) on the sphere
% compact space defined on a unit sphere
span = [0,2*pi,0,pi];
syms t
x = [sym('phi');sym('theta')];
epsl = 0.3; % \epsilon
alpha = 1; beta = 1; delta = (epsl - pi/4)*2;

F = -alpha * cos(x(1)) + beta * sin(2*x(2)+delta); % x1---\phi, x2---\theta

% derive the gradient field and the Laplacian
dF = [diff(F,x(1))/sin(x(2));diff(F,x(2))]
ddF = cot(x(2))*diff(F,x(2)) + diff(F,x(2),2)+diff(F,x(1),2)/sin(x(2))^2
sys = matlabFunction(-dF, 'Vars', {t, x});


%% Plot the scalar field on a sphere
n = 30; % define the sphere via n*n grids
% Phi   = linspace(0,2*pi,n+1);
% Theta = linspace(0,pi,n+1);
% [phi,theta] = meshgrid(Phi,Theta);
% % 3d plot:
% x1 = sin(theta).*cos(phi);
% y1 = sin(theta).*sin(phi);
% z1 = cos(theta);
[x1,y1,z1] = sphere(n);
theta = acos(z1);
phi = atan2(y1,x1);
phi = (phi < 0).* 2*pi + phi;

C = eval(subs(F,x,{phi;theta}));
figure(1)
h = surf(x1,y1,z1,C); colorbar
view(-45-180,20)
axis equal; %shading interp
title(['F(\phi,\theta)=',char(F)])
                                                                                                                                                                                          
hold on
e(1,:) = [0,pi/4-delta/2];
e(2,:) = [0,3*pi/4-delta/2];
e(3,:) = [pi,pi/4-delta/2];
e(4,:) = [pi,3*pi/4-delta/2];
xe = sin(e(:,2)).*cos(e(:,1));
ye = sin(e(:,2)).*sin(e(:,1));
ze = cos(e(:,2));
plot3(xe(:),ye(:),ze(:),'r*')

% [P, V] = select3d(h)
%% Plot the phase portrait on the sphere
figure(2)
sphere(30)
% shading flat
colormap([1,1,1]);
plot3(xe(:),ye(:),ze(:),'r*')
hold on
init = [xe,ye,ze];
init = [init;0,0,1]
[t,traj] = phaseportrait3d('examplesystem',init,[-1 1 -1 1 -1 1],10,1);
% figure(3)
% plot(t,traj(:,1))
% hold on
% plot(t,traj(:,2))
% hold on
% plot(t,traj(:,3))
% legend('x','y','z')
