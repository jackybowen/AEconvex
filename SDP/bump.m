function [ psi_x ] = bump( x, x_center )
%PSI_x
%   /psi(x) = exp(-1/(1-(x-x_enter)^2))   for |x|<1
%           = 0                 otherwise

% input:    x       = 
%           x_center=
    n = length(x);
    
    if n <= 0
        error('the input is empty here!')
    elseif n ~= length(x_center)
        error('x and x_center should be the same size')
    end

    psi_x = 1;
    
    if  all(abs(x-x_center) < 1)
%         for i = 1:n
%             psi_x = psi_x * exp(-1/(1-(x(i)-x_center(i))^2));
%         end
        psi_x = exp(-1/(1-(x(1)-x_center(1))^2))*exp(-1/(1-(x(2)-x_center(2))^2));
    else
        psi_x = 0;
    end

end

