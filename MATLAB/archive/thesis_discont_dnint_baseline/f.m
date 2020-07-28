function xdot = f(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: f_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Flow map
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
global sigma;
global gam_arr;
global sigma_alpha_arr;
global t_arr;
global V_arr;

% State: x = [t x1 x2 tau u Ts x1_p x2_p]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);
x1_p = x(7);
x2_p = x(8);

e = [x1_p; x2_p] - [x1;x2];
gam_arr = [gam_arr; [t, gamma([x1;x2],e)]] ;
sigma_alpha_arr = [sigma_alpha_arr; [t, sigma*alpha([x1;x2])]];
V_arr = [V_arr V([x1;x2])];
t_arr = [t_arr t];

state_dot = A*[x1;x2] + B*u;


xdot = [1; state_dot; 1; 0; 0; 0; 0];
end