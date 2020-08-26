%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: run_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
clc;
clear all;
close all;

% initial conditions
% State: x = [t x1 tau u Ts]
x0 =         [0 0 1 0 0];         % Tau starts at 1 to make sure control 
                                  % Calculated from the start
global df;
global ctl;
global u1; global u2; global lambda;

global psi_1;
global psi_1_dot;
global psi_2;
global psi_2_dot;
global V;
global rho_1;
global rho_2;

global T_arr;
global Ts_arr;

% Minimum Time and barT
global Ts_min;
global barT;
Ts_min = 0.56;
barT   = 1.75;

get_funnel();
get_control();


% simulation horizon
global T;
T=10; 
TSPAN=[0 T];
JSPAN = [0 10000];

plot_funnel();

% Set to 1 to run Ts_min calculation
% Set to 0 to not run 
get_Ts_min(1, T);

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.1);

% simulate
[t,j,x] = HyEQsolver( @f,@g_m,@C,@D,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');


x1_arr = x(:,2);
u_arr  = x(:,4);



%% Plot psi1, psi2, x1
% Figure Parameters

% For monitor
% width       = 1000;
% height      = 400;
% font_size   = 50;
% marker_size = 20;
% line_width  = 4;

% For laptop
width       = 1000;
height      = 400;
font_size   = 18;
marker_size = 8;
line_width  = 2;



color = 'b';
marker = 's';
[modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size);

figure(1);
plotHarc(t,j, x1_arr, [], modF, modJ);
hold on;
plot(t, psi_1(t), "k--", "LineWidth", line_width);
hold on
plot(t, psi_2(t), "k:", "LineWidth", line_width);
xlabel("Time(s)");
ylabel("x_1");
set_figure_options(width, height, font_size);
% Add legend
h = zeros(3, 1);
h(1) = plot(NaN,NaN,'bs', "LineWidth", line_width);
h(2) = plot(NaN,NaN,'k--', "LineWidth", line_width);
h(3) = plot(NaN,NaN,'k:', "LineWidth", line_width);
legend(h, 'x_1','\psi_1(t)','\psi_2(t)');


export_figure('funnel_x1.eps');

% Ts Plot
figure(2);
global T_arr; global Ts_arr;
plot_Ts(T_arr, Ts_arr, color, line_width, marker, marker_size);
xlabel("Time(s)");
ylabel("Sample Period (s)");
set_figure_options(width, height, font_size);
export_figure('funnel_Ts.eps');

fprintf('Average Sample Period: %f\n\n', mean(Ts_arr));
fprintf('Minimum Sample Period: %f\n\n', min(Ts_arr));


%% System
function [g1, g2] = g(x)
    g1 = x(2); g2 = 1;
end

function [dVdx1, dVdx2] = gradV(x)
    dVdx1 = x(1);
    dVdx2 = x(2);
end
