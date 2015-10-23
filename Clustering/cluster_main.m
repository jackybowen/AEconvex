close all; clear all; clc
%% Initialization
m = 2;      % the dimension of data space...
n = 100;    % number of inital data points
X = rand(n,m);
% Visualize the initial positions in 2D space
figure(1)
scatter(X(:,1),X(:,2))
%% Showing the graph of the \phi function with the sigma we chose
figure(2)
sigma = 0.01;    % Here we assume sigma is fixed
x_l = [2,2]';    span = [-3,3,-3,3];
phi = @(x_i) exp(-norm([x_i(1),x_i(2)]'-x_l)^2./sigma); % Here we choose norm-2
[xx,yy] = meshgrid(span(1):0.1:span(2),span(3):0.1:span(4));
xy = num2cell([xx(:),yy(:)],2);
surf(xx,yy,reshape(cellfun(phi,xy),size(xx))) % R^2
axis([span,0 1])
% compared with \phi_dot
figure(3)
phi_dot = @(x_i) -2/sigma*exp(-1/sigma*norm([x_i(1),x_i(2)]'-x_l)^2).*([x_i(1),x_i(2)]'-x_l);
dxy = reshape(cell2mat(cellfun(phi_dot,xy,'UniformOutput',false)),[],2);
quiver(xx,yy,reshape(dxy(:,1),size(xx)),reshape(dxy(:,2),size(xx))) % R^2

%% Use the \phi function we have chosen to construct the gradient system
tf = 100; dt = 0.001; tol = 1e-3;
x_f = zeros(n,2);
Cost = [];
for sigma = 0:0.01:0.5;    % Change the value of \sigma here
for i = 1:1:size(X,1)
    x_i = zeros(tf,2);
    x_i(1,:) = X(i,:);
    for j = 1:1:tf-1
        D = zeros(2,1);
        for l = 1:1:size(X,1)
            D = D + (-2/sigma*exp(-1/sigma*norm(x_i(j,:)-X(l,:))^2)*(x_i(j,:)-X(l,:)))';
        end
        x1 = x_i(j,1) - dt * D(1);
        x2 = x_i(j,2) - dt * D(2);
        x_i(j+1,:) = [x1 x2];
    end
    figure(4)
    plot(1:tf,x_i(:,1))
    hold on
    figure(5)
    plot(1:tf,x_i(:,2))
    hold on
    
    x_f(i,:) = x_i(end,:);
end
figure(6)
scatter(x_f(:,1),x_f(:,2))

%% Computing the optimal sigma based on cost function
C = 0;
for i = 1:1:n
    C = C+ norm(X(i,:)-x_f(i,:));
end
Cost = [Cost C];
end
figure
plot(0:0.01:0.5,Cost)
