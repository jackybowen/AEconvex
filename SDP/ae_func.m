% Apply the almost-everywhere function in ipopt solver
% f = @

function [x, info] = ae_func
  alpha = 30;
  beta = 1;
  x_center = [2,1];

  x0         = [-1 -1];  % The starting point.
%   options.lb = [-10 -10];  % Lower bound on the variables.
%   options.ub = [inf inf];  % Upper bound on the variables.
%   options.cl = [-inf -inf];   % Lower bounds on the constraint functions.
%   options.cu = [inf inf];   % Upper bounds on the constraint functions.
  
%   % Initialize the dual point.
  options.zl     = [1 1];
  options.zu     = [1 1];
  options.lambda = [1];
  
  % Set the IPOPT options.
  options.ipopt.hessian_approximation = 'limited-memory';
  options.ipopt.mu_strategy = 'adaptive';
  options.ipopt.tol         = 1e-7;
  
  % The callback functions.
  funcs.objective         = @(x) x(1)^2 + x(2)^2 + 30*1/((x(1)-20)^2+(x(2)-10)^2+1);% + 10*1/((x(1)-2)^2+(x(2)-1)^2+1);
%   funcs.constraints       = @(x) [ prod(x); sum(x.^2) ];
  funcs.gradient          = @gradient;
%   funcs.jacobian          = @(x) sparse([ prod(x)./x; 2*x ]);
%   funcs.jacobianstructure = @() sparse(ones(2,4));
%   funcs.hessian           = @hessian;
%   funcs.hessianstructure  = @() sparse(tril(ones(4)));
%   
  % Run IPOPT.
  [x info] = ipopt(x0,funcs,options);

% ----------------------------------------------------------------------
function g = gradient (x)
%   g = [ 2*x(1) - 2*alpha*beta*(x(1)-x_center(1))*exp(-alpha*((x(1)-x_center(1))^2+(x(2)-x_center(2))^2))
%       2*x(2) - 2*alpha*beta*(x(2)-x_center(2))*exp(-alpha*((x(1)-x_center(1))^2+(x(2)-x_center(2))^2))]; 
% g = [2*x(1)
%     2*x(2)];
g = [ 2*x(1) - 2*30*(x(1)-20)/((x(1)-20)^2+(x(2)-10)^2+1)^2;%- 2*10*(x(1)-2)/((x(1)-2)^2+(x(2)-1)^2+1)^2
     2*x(2) - 2*30*(x(2)-10)/((x(1)-20)^2+(x(2)-10)^2+1)^2];%- 2*10*(x(1)-2)/((x(1)-2)^2+(x(2)-1)^2+1)^2];




% ----------------------------------------------------------------------
function H = hessian (x, sigma, lambda)
  
  H = sigma*[ 2*x(4)             0      0   0;
              x(4)               0      0   0;
              x(4)               0      0   0;
              2*x(1)+x(2)+x(3)  x(1)  x(1)  0 ];
  
  H = H + lambda(1)*[    0          0         0         0;
                      x(3)*x(4)     0         0         0;
                      x(2)*x(4) x(1)*x(4)     0         0;
                      x(2)*x(3) x(1)*x(3) x(1)*x(2)     0  ];
  H = H + lambda(2)*diag([2 2 2 2]);
  H = sparse(H);
  