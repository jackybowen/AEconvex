 function xdot=examplesystem(t,x)
global alpha beta delta

% %Duffing oscillator
% 
% v1=x(2);
% v2=(1-x(1)^2)*x(2)-x(1);%-x(2)-x(1)^3;

% % Van der Pol oscillator
% eps = 1;
% v1=-x(2);
% v2=x(1)-eps*(1-x(1)^2)*x(2);

% v1 = -sin(x(1));
% v2 = -sin(x(2));

v1 = x(1)/(sqrt(x(1)^2+x(2)^2+x(3)^2))-x(1)+alpha*x(2)^2/(x(1)^2+x(2)^2)...
    -2*beta*x(1)*x(3)/sqrt(x(1)^2+x(2)^2)/(sqrt(x(1)^2+x(2)^2+x(3)^2))*(2*x(3)*(x(3)*cos(delta)-sqrt(x(1)^2+x(2)^2)*sin(delta))/sqrt(x(1)^2+x(2)^2+x(3)^2)-cos(delta));
v2 = x(2)/(sqrt(x(1)^2+x(2)^2+x(3)^2))-x(2)-alpha*x(1)*x(2)/(x(1)^2+x(2)^2)...
    -2*beta*x(2)*x(3)/sqrt(x(1)^2+x(2)^2)/(sqrt(x(1)^2+x(2)^2+x(3)^2))*(2*x(3)*(x(3)*cos(delta)-sqrt(x(1)^2+x(2)^2)*sin(delta))/sqrt(x(1)^2+x(2)^2+x(3)^2)-cos(delta));

v3 = x(3)/(sqrt(x(1)^2+x(2)^2+x(3)^2))-x(3)+2*beta*sqrt(x(1)^2+x(2)^2)/sqrt(x(1)^2+x(2)^2+x(3)^2)*(2*x(3)*(x(3)*cos(delta)-sqrt(x(1)^2+x(2)^2)*sin(delta))/sqrt(x(1)^2+x(2)^2+x(3)^2)-cos(delta));


% v1 = -sin(x(1))/sin(x(2));
% v2 = -2*sin(2*x(2));

xdot=[v1;v2;v3];