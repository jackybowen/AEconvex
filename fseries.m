function [an,bn,f]=fseries(fx,x,n,a,b)
% calculate the fourier coeffecients for the given function
% f = a0/2 + sum of [ak*cos(k*wx) + bk*sin(k*wx)]
if nargin==3
    a=-pi;
    b=pi;
end
l=(b-a)/2;

an=int(fx,x,a,b)/l;
bn=[];
f=an/2;
for ii=1:n
    ann=int(fx*cos(ii*pi*x/l),x,a,b)/l;
    bnn=int(fx*sin(ii*pi*x/l),x,a,b)/l;
    an=[an,ann];
    bn=[bn,bnn];
    f=f+ann*cos(ii*pi*x/l)+bnn*sin(ii*pi*x/l);
end

end