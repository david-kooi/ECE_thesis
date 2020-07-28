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
global A;
global B;
global P;
global Q;
global K;
global V;
global V_sls_value;
global V_sls_boundary;
global u_applied;
global alpha;
global gamma;
global F;
global lam_Q_min;


global ctl;

global barT;
global Ts_min;



% State: x = [t x1 x2 tau u Ts]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);

u      = ctl([x1;x2]);

% Compute next sampling time
options = odeset();
[Tout, Xrange] = ode45(@F_dynamic,[0 barT], [x1;x2], options, u);
F_u = (A*Xrange' + B*u);

x1_reach = Xrange(:,1);
x2_reach = Xrange(:,2);
%alpha_val = alpha(x1_reach, x2_reach);
%gamma_val = gamma(x1_reach, x2_reach, x1_reach*0 + x1, x2_reach*0 + x2);

drho_dx1 = -2*x1_reach - 0.5*x2_reach;
drho_dx2 = -0.5*x1_reach - 2*x2_reach;
grad_rho =  [drho_dx1, drho_dx2];

V_val = V([x1;x2]);
inner_rho = -dot(grad_rho', F_u);
M = max(inner_rho);

rho = V_sls_value - V_val;
Ts_plus = max(Ts_min, min(barT, rho/M)) ;

xplus = [t; x1; x2; 0; u; Ts_plus];
end