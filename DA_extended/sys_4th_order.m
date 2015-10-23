clear;close all;clc
span = [-3 3 -3 3];

% Hamiltonian system for x in R
syms t;
x = sym('x',[2,1]);l = sym('lamda',[2,1]);
alpha = 10;

L = [-1 1;1 -1];
% f = (x(1) - 2).^2.*(x(1) + 2).^2;
% f = 3*x(1).^4 - 4*x(1).^3+1;
f = x(1).*(x(1)+1.5).*(x(1)-1.5).*(x(1)-2);
figure(1)
% subplot(2,1,1)
ezplot(f,[span(1) span(2)])
grid on
clf
f = f + x(2).*(x(2)+1.5).*(x(2)-1.5).*(x(2)-2)


z_dot = sym('z_dot',[4,1]); z = [x;l];
z_dot(1:2) = -alpha*([diff(f,z(1));diff(f,z(2))] + L'*[z(3);z(4)] + alpha^(-1/2)* L'*L*[z(3);z(4)]);
z_dot(3:4) = alpha^(-1/2)*L* z(1:2);

% subplot(2,1,2)
m1 = [0.6693 0.6693];
m2 = [0.6693 0.6693];
hold on
line([m1(1) span(2)],[m1(2) m1(2)],'Color','r');line([m1(1) m1(1)],[m1(2) span(4)],'Color','r');
line([m2(1) span(1)],[m2(2) m2(2)]);line([m2(1) m2(1)],[m2(2) span(3)]);
sys = matlabFunction(z_dot, 'Vars', {t, z});
tf = 100;
phaseportrait2(sys,span,tf,1);
% hold on
% [xx,yy] = meshgrid(span(1):0.01:span(2),span(3):1:span(4));
% contour(xx,yy,subs(H,x,{xx;yy}),10)