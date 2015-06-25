% check 3 conditions for almost-everywhere stable on 2-torus
close all; clear all; clc
%  Direct Method
% compact space defined as 
xyspan = [-pi/2,pi/2,-2*pi,2*pi];
% bivariate function fxy
syms t
x = sym('x',[2,1]);

%% Choose the F(x,y)
% fxy = -2*cos(x(1))-cos(x(2))-cos(x(1)+x(2));
% fxy = -cos(x(1))-cos(x(2));
% fxy = -cos(x(1))-cos(x(2))-cos(x(1)+x(2));
% fxy = exp(-cos(x(1))-cos(x(2))-cos(x(1)+x(2)));
fxy = -cos(2*x(1))-cos(x(2));

%3d plot:
[X,Y]=meshgrid(xyspan(1):0.1:xyspan(2),xyspan(3):0.1:xyspan(4));
fval = eval(subs(fxy,x,{X;Y}));
figure(1)
surf(X,Y,fval)
title(['F(x,y)=',char(fxy)])
grid on

dfxy = [diff(fxy,x(1)); diff(fxy,x(2))]
sys = matlabFunction(-dfxy, 'Vars', {t, x});

figure(2)
pp = phaseportrait(sys,xyspan,10,1);

figure(3)
map2sphere(pp,xyspan)

% condition 1 & 2
x_eq = solve([dfxy(1)== 0,dfxy(2)==0,xyspan(1)<=x(1),x(1)<=xyspan(2),xyspan(3)<=x(2),x(2)<=xyspan(4)]...
    ,'ReturnConditions',true);

x_eq = [x_eq.x1 x_eq.x2];
x_eq_val = eval(x_eq);

ddfxy = laplacian(fxy,x);
x_stable = [];
x_unstable = [];
for i = 1:size(x_eq,1)
    if vpa(subs(ddfxy,x,[x_eq_val(i,1);x_eq_val(i,2)])) > 0 && (vpa(subs(dfxy(1),x,[x_eq_val(i,1);x_eq_val(i,2)]))==0) && (vpa(subs(dfxy(2),x,[x_eq_val(i,1);x_eq_val(i,2)]))==0)
        x_stable = [x_stable;x_eq(i,:)];
    elseif vpa(subs(ddfxy,x,[x_eq_val(i,1);x_eq_val(i,2)])) < 0 && (vpa(subs(dfxy(1),x,[x_eq_val(i,1);x_eq_val(i,2)]))==0) && (vpa(subs(dfxy(2),x,[x_eq_val(i,1);x_eq_val(i,2)]))==0)
        x_unstable = [x_unstable;x_eq(i,:)];
    end
end
x_stable
x_unstable

figure(2)
hold on
plot(vpa(x_stable(:,1)),vpa(x_stable(:,2)),'*r')
plot(vpa(x_unstable(:,1)),vpa(x_unstable(:,2)),'og')
hold off

% condition 3

for j = 1:size(x_stable,1)
    
    alpha = 0.2;
    ineq = eval(subs(fxy - subs(fxy,x,[x_stable(j,1);x_stable(j,2)]) - alpha*(norm(x-x_stable(j,:)')).^2,x,{X;Y})) >= 0;
    colors = zeros(size(X))+ineq;
    figure
    scatter(X(:),Y(:),3,colors(:),'filled')
end

