% ------------------
% University of California Santa Cruz
% Hybrid Systems Lab
% Masters Thesis 2020
% David Kooi
% ------------------

function [t_corr2, j_corr2, x_corr2] = run_corr2_sim(Ts_star, T_min, T_max, r, N, cs, ch, method)
global ctl;

global x1_o; global x2_o;
global T;

global Ts_min;
Ts_min = Ts_star;
initialization_corr2(T_min, T_max, r, N, cs, ch, method);

u_o  = ctl([x1_o;x2_o]);
% State: x = [t x1   x2   tau  u    Ts]
x0 =         [0 x1_o x2_o  0   u_o  0];   % Tau starts at 1 to make sure control 
                                          % Calculated from the start

% simulation horizon
TSPAN=[0 T];
JSPAN = [0 10000];

%% Simulate
% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.1);

% simulate
[t_corr2, j_corr2, x_corr2] = HyEQsolver( @f_common,@g_corr2,@C_corr2,@D_corr2,x0,TSPAN,JSPAN,rule,options,'ode23t');

end