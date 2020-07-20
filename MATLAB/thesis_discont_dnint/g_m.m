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
global state_grid;


global ctl;

global TBar_arr;
global norm_Fxo_arr;
global getTBar_scaled;
global Ts_min;


% State: x = [t x1 x2 tau u Ts]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);

x_o    = [x1;x2];
u_o      = ctl(x_o);
norm_F_xo = norm(A*x_o + B*u_o);
norm_Fxo_arr = [norm_Fxo_arr norm_F_xo];


%[M, TBar] = get_M_TBar_scaled(x_o, u_o);
%[M, TBar] = get_M_TBar_horizon(x_o, u_o);
[M, TBar] = get_M_TBar_horizon2(x_o, u_o);
TBar_arr = [TBar_arr TBar];


Ts_plus = get_Ts(x_o, M, TBar);

xplus = [t; x1; x2; 0; u_o; Ts_plus];
end