 function xdot=examplesystem(t,x)

 

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

v1 = -sin(x(1))-sin(x(1)+x(2));
v2 = -sin(x(2))-sin(x(1)+x(2));

xdot=[v1;v2];