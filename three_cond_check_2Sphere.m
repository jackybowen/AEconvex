% check 3 conditions for almost-everywhere stable on 2-Sphere
close all; clear all; clc
%  Direct Method
% compact space defined as a unit sphere,
span = [-pi,pi,-pi/2,pi/2];

% bivariate function F(x1,x2) <=> F(phi,theta)
syms t
x = sym('x',[2,1]);

%% Choose the F(x1,x2)
% F = -2*cos(x(1))-cos(x(2))-cos(x(1)+x(2));
F = -cos(2*x(2)+pi/5);
% F = -cos(x(1))-cos(x(2))-cos(x(1)+x(2));
% F = exp(-cos(x(1))-cos(x(2))-cos(x(1)+x(2)));

dF = [diff(F,x(1))/cos(x(2));diff(F,x(2))]
ddF = -tan(x(2))*diff(F,x(2)) + diff(F,x(2),2)+diff(F,x(1),2)/cos(x(2))^2
sys = matlabFunction(-dF, 'Vars', {t, x});

%3d plot:
[X1,X2]=meshgrid(span(1):0.1:span(2),span(3):0.1:span(4));
fval = eval(subs(F,x,{X1;X2}));
figure(1)
surf(X1,X2,fval)
title(['F(x1,x2)=',char(F)])
grid on
%phase portrait
figure(2)
pp = phaseportrait(sys,span,10,1);
%On the sphere
figure(3)
map2sphere(pp(:,1),pp(:,2))

figure(4)
stereog2plane(F)

% condition 1 & 2
x_eq = solve([dF(1)== 0,dF(2)==0,span(1)<=x(1),x(1)<=span(2),span(3)<=x(2),x(2)<=span(4)]...
    ,'ReturnConditions',true);

x_eq = [x_eq.x1 x_eq.x2];
x_eq_val = double(x_eq)+1e-5;


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
    
    alpha = 0.25;
    ineq = eval(subs(F - subs(F,x,[x_stable(j,1);x_stable(j,2)]) - alpha*(norm(x-x_stable(j,:)')).^2,x,{X1;X2})) >= 0;
    colors = zeros(size(X1))+ineq;
    figure
    scatter(X1(:),X2(:),3,colors(:),'filled')
end

