function xplus = g_m(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: g_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Jump map
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
global ctl;
global psi_1;
global psi_1_dot;
global psi_2;
global psi_2_dot;
global V;
global rho_1;
global rho_2;
global u1; global u2; global lambda;
global df;

global barT;
global Ts_min;



% State: x = [t x1 tau u Ts]
t    = x(1);
x1   = x(2);
tau  = x(3);
u    = x(4);
Ts   = x(5);

u      = ctl(t, x1);

% Compute next sampling time

Trange = t:0.01:t+barT;
Xrange = (0:0.01:barT).*u + x1;

psi1   = psi_1(Trange);
psi2   = psi_2(Trange);
rho1   = rho_1(Trange, Xrange);
rho2   = rho_2(Trange, Xrange);
f1     = psi_1_dot(Trange);
f2     = psi_2_dot(Trange);

inner_rho = -(f1.*rho2 - f2.*rho1 + u.*(rho1 - rho2));
M = max(inner_rho);

rho = rho_1(t,x1)*rho_2(t,x1);
Ts_plus = max(Ts_min, min(barT, rho/M));

xplus = [t; x1; 0; u; Ts_plus];

global T_arr;
global Ts_arr;
T_arr = [T_arr t];
Ts_arr = [Ts_arr Ts_plus];
end