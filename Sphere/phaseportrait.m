function phaseportrait(fname,limits,tf,flag)
% PHASEportrait: interactively construct phase portrait for xdot=f(x)
%
%   Synopsis: phaseportrait(fname,limits,tf,flag)
%             phaseportrait(fname,limits,tf)
%             phaseportrait
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
global h;


if nargin > 0
   narginchk(3,4)
   if nargin == 3, flag = 1; end
else
   fname=input('enter file name: ', 's');
   limits(1)=input('enter horizontal minimum: ');
   limits(2)=input('enter horizontal maximum: ');
   limits(3)=input('enter vertical minimum: ');
   limits(4)=input('enter vertical maximum: ');
   tf=input('enter simulation time (>0): ');
   flag=input('enter 1 for forward simulation or -1 for backward: ');
   if flag == -1
      flag = -1;
   else
      flag = 1;
   end
end

lengthx=limits(2)-limits(1);
lengthy=limits(4)-limits(3);

'Left click to draw an orbit starting there, right click to quit.'

while 1,
        [V,P]=select3d(h);
        x1 = acos(V(3));
        x2 = atan(V(2)/V(1));
        [t,x]=ode45(fname,[0,tf],[x1 x2]);
        plot(x(:,1),x(:,2));
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
        
        pp = [pp; {x,[x0,y0;x1,y1;x2,y2]}];
        
end
hold off
axis('normal');

end