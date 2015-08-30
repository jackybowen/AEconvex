% check 3 conditions for almost-everywhere stable on 2-Sphere
close all; clear all; clc
%  Direct Method
% compact space defined as a unit sphere,
span = [0,2*pi,0,pi];

% bivariate function F(x1,x2) <=> F(phi,theta)
syms t
x = sym('x',[2,1]);
alpha = -1; beta = 2; delta = 1.8; %(ep - pi/4)*2;

%% Choose the F(x1,x2)
% F = -2*cos(x(1))-cos(x(2))-cos(x(1)+x(2));
% F = -alpha * cos(x(1)) + beta * sin(2*x(2)+delta);
F = alpha*cos(x(1))*sin(x(2)) + beta * sin(2*x(2)+delta);


dF = [diff(F,x(1))/sin(x(2));diff(F,x(2))]
ddF = cot(x(2))*diff(F,x(2)) +diff (F,x(2),2)+diff(F,x(1),2)/sin(x(2))^2
sys = matlabFunction(-dF, 'Vars', {t, x});

% scalar field on the sphere:
[X1,X2]=meshgrid(span(1):0.1:span(2),span(3):0.1:span(4));
figure(1)
n = 40;
[x1,y1,z1] = sphere(n);
theta = acos(z1);
phi = atan2(y1,x1);
phi = (phi < 0).* 2*pi + phi;

C = eval(subs(F,x,{phi;theta}));
h = surf(x1,y1,z1,C); colorbar
view(-45-180,20)
axis equal; %shading interp% title(['F(x1,x2)=',char(F)])
grid on

hold on
e(1,:) = [0,2.7833];
e(2,:) = [0,1.4791];
e(3,:) = [pi,0.14421];
e(4,:) = [pi,2.7833];
xe = sin(e(:,2)).*cos(e(:,1));
ye = sin(e(:,2)).*sin(e(:,1));
ze = cos(e(:,2));
plot3(xe(2),ye(2),ze(2),'ro')
% text(xe(2),ye(2),ze(2),'The unique minimum')

% phase portrait
figure(2)
pp = phaseportrait(sys,span,10,1);

% Gradient Field on the sphere
figure(3)
map2sphere(pp(:,1),pp(:,2))

% steographic projection
figure(4)
map2plane(pp(:,1),pp(:,2))

% condition 1 & 2
x_eq = solve([dF(1)== 0,dF(2)==0,span(1)<=x(1),x(1)<=span(2),span(3)<=x(2),x(2)<=span(4)]...
    ,'ReturnConditions',true);

x_eq = [x_eq.x1 x_eq.x2];
x_eq_val = double(x_eq);


x_stable = [];
x_unstable = [];
for i = 1:size(x_eq,1)
    if (vpa(subs(dF(1),x,{x_eq(i,1);x_eq(i,2)}))==0) && (vpa(subs(dF(2),x,{x_eq(i,1);x_eq(i,2)}))==0) && vpa(subs(ddF,x,{x_eq_val(i,1);x_eq_val(i,2)})) > 0
        x_stable = [x_stable;x_eq(i,:)];
    elseif (vpa(subs(dF(1),x,{x_eq(i,1);x_eq(i,2)}))==0) && (vpa(subs(dF(2),x,{x_eq(i,1);x_eq(i,2)}))==0) && vpa(subs(ddF,x,{x_eq_val(i,1);x_eq_val(i,2)})) < 0
        x_unstable = [x_unstable;x_eq(i,:)];
    end
end
x_stable
x_unstable

figure
hold on
plot(vpa(x_stable(:,1)),vpa(x_stable(:,2)),'*r')
plot(vpa(x_unstable(:,1)),vpa(x_unstable(:,2)),'og')
hold off

% condition 3

for j = 1:size(x_stable,1)
    
    alpha = 0.001;
    ineq = eval(subs(F - subs(F,x,[x_stable(j,1);x_stable(j,2)]) - alpha*(norm(x-x_stable(j,:)')).^2,x,{X1;X2})) >= 0;
    colors = zeros(size(X1))+ineq;
    figure
    scatter(X1(:),X2(:),3,colors(:),'filled')
end

