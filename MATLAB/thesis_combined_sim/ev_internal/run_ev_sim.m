
function [t_ev, j_ev, x_ev] = run_ev_sim(in_epsilon)

global ctl;
global gam_arr;
global sigma_alpha_arr;
global Ts_arr;
global T_arr;
global t_arr;
global V_arr;

gam_arr = [];
sigma_alpha_arr = [];
Ts_arr = [];
T_arr = [];

global epsilon;
epsilon = in_epsilon;

% initial conditions
global x1_o; global x2_o;
global x1_p; global x2_p;
x1_p = x1_o; x2_p = x2_o;

global first_jump;
first_jump = 1;
u_o = ctl([x1_o;x2_o]);
% State: x = [t x1   x2   tau  u    Ts]
x0 =         [0 x1_o x2_o  0   u_o  0];   % Tau starts at 1 to make sure control 
                                                     % Calculated from the start


%%
% simulation horizon
global T;
TSPAN=[0 T];
JSPAN = [0 10000];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.1);

% simulate
[t_ev,j_ev,x_ev] = HyEQsolver( @f_common,@g_ev,@C_ev,@D_ev,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');


