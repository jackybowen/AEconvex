function [amn,bmn,cmn,dmn,f]=f2series(fxy,x,y,m,n,lx,ux,ly,uy)
% calculate the 2d fourier coeffecients for the given function
% f = a0/2 + sum of [ak*cos(k*wx) + bk*sin(k*wx)]
if nargin == 4
    lx = -pi;
    ux = pi;
    ly = -pi;
    uy = pi;
end
l = (ux-lx)/2;
h = (uy-ly)/2;
amn = zeros(m+1,n+1);
bmn = zeros(m+1,n+1);
cmn = zeros(m+1,n+1);
dmn = zeros(m+1,n+1);
f = 0;
for ii=0:m
    for jj = 0:n
        amn(ii+1,jj+1)=int(int(fxy*cos(ii*pi*x/l)*cos(jj*pi*y/h),x,lx,ux),y,ly,uy)/(l*h);
        bmn(ii+1,jj+1)=int(int(fxy*sin(ii*pi*x/l)*cos(jj*pi*y/h),x,lx,ux),y,ly,uy)/(l*h);
        cmn(ii+1,jj+1)=int(int(fxy*cos(ii*pi*x/l)*sin(jj*pi*y/h),x,lx,ux),y,ly,uy)/(l*h);
        dmn(ii+1,jj+1)=int(int(fxy*sin(ii*pi*x/l)*sin(jj*pi*y/h),x,lx,ux),y,ly,uy)/(l*h);
        if ii == 0 || jj == 0
            lamda = 1/2;
            if ii == 0 && jj == 0
                lamda = 1/4;
            end
        else
            lamda = 1;
        end
        f=f+lamda*(amn(ii+1,jj+1)*cos(ii*pi*x/l)*cos(jj*pi*y/h)+bmn(ii+1,jj+1)*sin(ii*pi*x/l)*cos(jj*pi*y/h)+...
            cmn(ii+1,jj+1)*cos(ii*pi*x/l)*sin(jj*pi*y/h)+dmn(ii+1,jj+1)*sin(ii*pi*x/l)*sin(jj*pi*y/h));
    end
end

end