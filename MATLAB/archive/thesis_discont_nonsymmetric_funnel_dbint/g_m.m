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
global psi_1_dot; global psi_1_ddot;
global psi_2; global psi_2_ddot;
global psi_2_dot;
global V;
global rho_1;
global rho_2;
global u1; global u2; global lambda;
global df;
global dphi_dt; global dphi_dx;


% State: x = [t x1 tau u Ts]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);

u      = ctl(t, [x1;x2]);

phidx = dphi_dx(t, [x1;x2]);
phidt = dphi_dt(t, [x1;x2]);


% Compute next sampling time
barT = 1;
Trange = t:0.1:t+barT;
Xrange = (0:0.1:barT).*u + x1;

psi1   = psi_1(Trange);
psi2   = psi_2(Trange);
rho1   = rho_1(Trange, Xrange);
rho2   = rho_2(Trange, Xrange);
f1     = psi_1_dot(Trange);
f1_dot = psi_1_ddot(Trange);
f2     = psi_2_dot(Trange);
f2_dot = psi_2_ddot(Trange);


inner_rho = -(f1.*rho2 - f2.*rho1 + u.*(rho1 - rho2));
M = max(inner_rho);

rho = rho_1(t,x1)*rho_2(t,x1);
Ts_plus = max(0.0041, min(barT, rho/M)) ;

xplus = [t; x1; u; 0; u; Ts_plus];
end