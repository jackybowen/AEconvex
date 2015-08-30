% check 3 conditions for almost-everywhere stable on R2 plane
close all; clear all; clc
%  Direct Method

% bivariate function F(x1,x2) <=> F(phi,theta)
syms t
x = sym('x',[2,1]);
span = [-5,5,-5,5];
% ep = 0.01; % \epsilon
%alpha = 1; beta = 50; delta = (ep - pi/4)*2;
x1 = 2; y1 = 2; 
delta =1.8

%% Choose the F(x1,x2)
% F = -alpha*cos(atan(x(2)/x(1)))+beta*sin(2*acos((-1+x(1)^2+x(2)^2)/(1+x(1)^2+x(2)^2))+delta);
% F = alpha*(x(1)^2+x(2)^2)+beta/(1+(x(1)-x1).^2+(x(2)-y1).^2);
F = 2*x(1)/(1+x(1)^2+x(2)^2)-8*cos(delta)/(1+x(1)^2+x(2)^2)*sqrt(x(1)^2+x(2)^2)

dF = [diff(F,x(1));diff(F,x(2))]

ddF = laplacian(F)
sys = matlabFunction(-dF, 'Vars', {t, x});

%3d plot:
[X,Y]=meshgrid(span(1):0.1:span(2),span(3):0.1:span(4));
fval = eval(subs(F,x,{X;Y}));
figure(1)
surf(X,Y,fval)
% title(['F(x1,x2)=',char(F)])
grid on
%phase portrait
figure(2)
pp = phaseportrait(sys,span,100,1);


% condition 1 & 2
x_eq = solve([dF(1)== 0,dF(2)==0,span(1)<=x(1),x(1)<=span(2),span(3)<=x(2),x(2)<=span(4)]...
    ,'ReturnConditions',true);

x_eq = [x_eq.x1 x_eq.x2];
x_eq_val = vpa(x_eq);


x_stable = [];
x_unstable = [];
for i = 1:size(x_eq,1)
    if (vpa(subs(dF(1),x,{x_eq_val(i,1);x_eq_val(i,2)}))==0) && (vpa(subs(dF(2),x,{x_eq_val(i,1);x_eq_val(i,2)}))==0) && vpa(subs(ddF,x,{x_eq_val(i,1);x_eq_val(i,2)})) > 0
        x_stable = [x_stable;x_eq_val(i,:)];
    elseif (vpa(subs(dF(1),x,{x_eq_val(i,1);x_eq_val(i,2)}))==0) && (vpa(subs(dF(2),x,{x_eq_val(i,1);x_eq_val(i,2)}))==0) && vpa(subs(ddF,x,{x_eq_val(i,1);x_eq_val(i,2)})) < 0
        x_unstable = [x_unstable;x_eq_val(i,:)];
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
    ineq = eval(subs(F - subs(F,x,[x_stable(j,1);x_stable(j,2)]) - alpha*(norm(x-x_stable(j,:)')).^2,x,{X;Y})) >= 0;
    colors = zeros(size(X))+ineq;
    figure
    scatter(X(:),Y(:),3,colors(:),'filled')
end

