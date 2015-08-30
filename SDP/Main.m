close all; clear all; clc;
% SEDUMI  Self-Dual-Minimization/ Optimization over self-dual homogeneous
%         cones.
%
% >  X = SEDUMI(A,b,c) yields an optimal solution to the linear program
%      MINIMIZE c'*x SUCH THAT A*x = b, x >= 0
%      x is a vector of decision variables.
%      If size(A,2)==length(b), then it solves the linear program
%      MINIMIZE c'*x SUCH THAT A'*x = b, x >= 0
%
% >  [X,Y,INFO] = SEDUMI(A,b,c) also yields a vector of dual multipliers Y,
%      and a structure INFO, with the fields INFO.pinf, INFO.dinf and
%      INFO.numerr.


n = 3;
d = 2;
% max bt*y
% s.t. -At*y >= -c
m = nchoosek(n+d,d);
dm = 1/2*(m^2+m)-nchoosek(n+2*d,n);

F = zeros(m,m);
F(1,1) = -1;    F1 = F; % lamda
F = zeros(m,m);
F(1,5) = 1; F(2,2) = -2; F(5,1) = 1; F2 = F; % c1
F = zeros(m,m);
F(2,3) = 1; F(3,2) = 1; F(1,6) = -1; F(6,1) = -1; F3 = F; % c2
F = zeros(m,m);
F(3,3) = -2; F(7,1) = 1; F(1,7) = 1;             F4 = F;  % c3
F = zeros(m,m);
F(4,2) = 1; F(2,4) = 1; F(1,8) = -1; F(8,1) = -1; F5 = F; % c4
F = zeros(m,m);
F(4,3) = 1; F(3,4) = 1; F(1,9) = -1; F(9,1) = -1; F6 = F; % c5
F = zeros(m,m);
F(4,4) = -2; F(1,10) = 1; F(10,1) = 1;            F7 = F; % c6
F = zeros(m,m);
F(5,3) = -1; F(3,5) = -1; F(6,2) = 1; F(2,6) = 1; F8 = F; % c7
F = zeros(m,m);
F(6,3) = 1; F(3,6) = 1; F(7,2) = -1; F(2,7) = -1; F9 = F; % c8
F = zeros(m,m);
F(5,4) = 1; F(4,5) = 1; F(8,2) = -1; F(2,8) = -1; F10 = F;% c9
F = zeros(m,m);
F(9,2) = 1; F(2,9) = 1; F(6,4) = -1; F(4,6) = -1; F11 = F;% c10
F = zeros(m,m);
F(10,6) = -1; F(6,10) = -1; F(9,8) = 1; F(8,9) = 1;F12 = F;% c11
F = zeros(m,m);
F(10,2) = 1; F(2,10) = 1; F(4,8) = -1; F(8,4) = -1;F13 = F;% c12
F = zeros(m,m);
F(6,4) = -1; F(4,6) = -1; F(8,3) = 1; F(3,8) = 1; F14 = F; % c13
F = zeros(m,m);
F(4,7) = -1; F(7,4) = -1; F(9,3) = 1; F(3,9) = 1; F15 = F; % c14
F = zeros(m,m);
F(9,4) = -1; F(4,9) = -1; F(10,3) = 1; F(3,10) =1; F16 = F;% c15
F = zeros(m,m);
F(7,5) = 1; F(5,7) = 1; F(6,6) = -2; F17 = F;              % c16
F = zeros(m,m);
F(9,5) = 1; F(5,9) = 1; F(6,8) = -1; F(8,6) = -1; F18 = F; % c17
F = zeros(m,m);
F(10,5) = 1; F(5,10) = 1; F(8,8) = -2;            F19 = F; % c18
F = zeros(m,m);
F(9,6) = -1; F(6,9) = -1; F(7,8) = 1; F(8,7) = 1; F20 = F; % c19
F = zeros(m,m);
F(10,7) = 1; F(7,10) = 1; F(9,9) = -2;            F21 = F; % c20

F = zeros(m,m);
F(2:4,1) = 1/2; F(1,2:4) = 1/2; F(6,4) = -2; F(4,6) = -2;F(5,5) = 1;...
    F(7,7) = 1;F(10,10) = 1; F0 = F;

At = -[vec(F1) vec(F2) vec(F3) vec(F4) vec(F5) vec(F6) vec(F7) vec(F8) vec(F9) ...
    vec(F10) vec(F11) vec(F12) vec(F13) vec(F14) vec(F15) vec(F16) vec(F17) vec(F18) vec(F19) vec(F20) vec(F21)]; 
ct = vec(F0);
bt = [1; zeros(dm,1)];

[x,y,info] = sedumi(At,bt,ct);
y
% [x,y,info] = sedumi(A,b,c)


