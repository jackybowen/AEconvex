function [t,x] = phaseportrait3d(fname,init,limits,tf,flag)
% PHASEportrait: interactively construct phase portrait for xdot=f(x)
%
%   Synopsis: phaseportrait3d(fname,limits,tf,flag)
%             phaseportrait3d(fname,limits,tf)
%             phaseportrait3d
%
%      fname: name of file containing f(x)
%     limits: range of phase plane, form: [xmin, xmax, ymin, ymax]
%         tf: time of simulation
%       flag: indicating forward or reverse simulation, default value is 1,
%                if flag=-1, arrows will be backwards
%
% If no arguments provided, it will interactively request them.
% To draw an orbit, click left mouse button at proper initial condition.
% To end drawing, click right mouse button in phase plane.
% To integrate from 0 to -T, change f(x) to -f(x) and integrate from 0 to T
%

nargs=nargin;

if nargs > 0
   narginchk(4,5)
   if nargs == 4, flag = 1; end
else
   fname=input('enter file name: ', 's');
   init(1) = input('enter initial point x: ');
   init(2) = input('enter initial point y: ');
   init(3) = input('enter initial point z: ');
   limits(1)=input('enter horizontal minimum: ');
   limits(2)=input('enter horizontal maximum: ');
   limits(3)=input('enter vertical minimum: ');
   limits(4)=input('enter vertical maximum: ');
   limits(5)=input('enter Zedical minimum: ');
   limits(6)=input('enter Zedical maximum: ');
   tf = input('enter simulation time (>0): ');
   flag = input('enter 1 for forward simulation or -1 for backward: ');
   if flag == -1
      flag = -1;
   else
      flag = 1;
   end
end

lengthx=limits(2)-limits(1);
lengthy=limits(4)-limits(3);
lengthz=limits(6)-limits(5);
% clf
% axis(limits);
hold on
grid on;

for i = 1:size(init,1)
    [t,x]=ode45(fname,[0,tf],[init(i,1) init(i,2) init(i,3)]);
    plot3(x(:,1),x(:,2),x(:,3),'--*','Linewidth',2);
    xmx=min([limits(2) max(x(:,1))]); xmn=max([limits(1) min(x(:,1))]);
    ymx=min([limits(4) max(x(:,2))]); ymn=max([limits(3) min(x(:,2))]);
    if (ymx-ymn)/lengthy > (xmx-xmn)/lengthx
       mid=(ymx+ymn)/2;
       [mid,ind]=min(abs(x(:,2)-mid));
    else
       mid=(xmx+xmn)/2;
       [mid,ind]=min(abs(x(:,1)-mid));
    end
    x1=x(ind,1); y1=x(ind,2);
    x2=x(ind+1,1); y2=x(ind+1,2);
    theta=atan2((y1-y2)/lengthy,(x1-x2)/lengthx);
    x0=x1+cos(theta-pi/8)*lengthx/50*flag;
    y0=y1+sin(theta-pi/8)*lengthy/50*flag;
    x2=x1+cos(theta+pi/8)*lengthx/50*flag;
    y2=y1+sin(theta+pi/8)*lengthy/50*flag;
    plot([x0 x1 x2],[y0 y1 y2]);
    view(-45-180,20)
    pause
end
hold off
% axis('normal');

end