function [t_diben, j_diben, x_diben] = run_diben_sim(v)

initialization_diben(v);

global ctl;

% initial conditions
global x1_o; global x2_o;


u_o  = ctl([x1_o;x2_o]);
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
[t_diben,j_diben,x_diben] = HyEQsolver( @f_common,@g_diben,@C_diben,@D_diben,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');


end