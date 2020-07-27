clear all;
close all;

initialization_common();


%% Run Corollary 2
% Tunable parameters
Ts_star = 0.25; % Determined through minT_calc_corr2.m
T_min   = Ts_star; 
T_max   = 2;
r       = 0.025;
N       = 10;
cs      = 1;
ch      = 0.5;
method  = 1; % 0: Scaled TBar
            % 1: 2-Step horizon TBar
           
[t_corr2, j_corr2, x_corr2] = ...
    run_corr2_sim(Ts_star, T_min, T_max, r, N, cs, ch, method);