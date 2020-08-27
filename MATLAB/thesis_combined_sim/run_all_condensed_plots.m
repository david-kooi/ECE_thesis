clear all;
close all;

%% Figure Parameters
% For monitor
% width       = 1000;
% height      = 400;
% font_size   = 50;
% marker_size = 20;
% line_width  = 4;

width       = 1000;
height      = 400;
font_size   = 18;
marker_size = 10;
line_width  = 2;

%% Initial Condition and Time Horizon
x1_o = -0.1;
x2_o = 0.3;
T = 10;
initialization_common(T, x1_o, x2_o);

%% Run Corollary 2 Scaled
% Tunable parameters
Ts_star = 0.25; % Determined through minT_calc_corr2.m
T_min   = Ts_star; 
T_max   = 2;
r       = 0.025;
N       = 10;
ch      = 0.6;
method  = 0; % 0: Scaled TBar
             % 1: 2-Step horizon TBar
         
% Uncomment to calculate T_s^*.
%minT_calc_corr2(0, T_min, T_max, r, N, cs, ch, method);
            
% Non-Linear cs = 150
cs      = 150;
global Ts_corr2;
global T_corr2;
T_corr2  = [];
Ts_corr2 = []; % Initialize global data
[t_corr2_cs150, j_corr2_cs150, x_corr2_cs150] = ...
    run_corr2_sim(Ts_star, T_min, T_max, r, N, cs, ch, method);
T_corr2_cs150    = T_corr2;
Ts_corr2_cs150   = Ts_corr2;

x1_corr2_cs150 = x_corr2_cs150(:,2);
x2_corr2_cs150 = x_corr2_cs150(:,3);
u_corr2_cs150  = x_corr2_cs150(:,4);
V_corr2_cs150  = get_V(x1_corr2_cs150, x2_corr2_cs150);

% Linear cs = 1
cs      = 1;
global Ts_corr2;
global T_corr2;
T_corr2  = [];
Ts_corr2 = []; % Initialize global data
[t_corr2_cs1, j_corr2_cs1, x_corr2_cs1] = ...
    run_corr2_sim(Ts_star, T_min, T_max, r, N, cs, ch, method);

T_corr2_cs1  = T_corr2;
Ts_corr2_cs1 = Ts_corr2;

x1_corr2_cs1 = x_corr2_cs1(:,2);
x2_corr2_cs1 = x_corr2_cs1(:,3);
u_corr2_cs1  = x_corr2_cs1(:,4);
V_corr2_cs1  = get_V(x1_corr2_cs1, x2_corr2_cs1);


Ts_avg_corr2_cs150 = mean(Ts_corr2_cs150);
Ts_avg_corr2_cs1   = mean(Ts_corr2_cs1);  

%% Plot Corollary 2 Scaled
% Print averages and minimum times
disp("Average Sample Periods");
fprintf('Corollary 2 cs=150: %f\n\n', Ts_avg_corr2_cs150);
fprintf('Corollary 2 cs=1: %f\n\n', Ts_avg_corr2_cs1);

disp("Minimum Sample Periods");
fprintf('Corollary 2 cs=150: %f\n\n', min(Ts_corr2_cs150));
fprintf('Corollary 2 cs=1: %f\n\n', min(Ts_corr2_cs1));

% V plot
figure(1);
color  = "g";
marker = 'o'; 
[modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size);
plotHarc(t_corr2_cs1,j_corr2_cs1,V_corr2_cs1, [], modF, modJ);
hold on;

color  = 'b';
marker = 's'; 
[modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size);
plotHarc(t_corr2_cs150,j_corr2_cs150,V_corr2_cs150, [], modF, modJ);
hold on;

h = zeros(2, 1);
h(1) = plot(NaN,NaN, 'b',  'MarkerFaceColor', 'b', 'Marker', 's', 'MarkerSize', marker_size);
h(2) = plot(NaN,NaN, 'g',  'MarkerFaceColor', 'g', 'Marker', 'o', 'MarkerSize', marker_size);
legend(h, '$c_s = 150$','$c_s = 1$', "Interpreter", "latex");


xlabel("t");
ylabel("V(x(t))");
set_figure_options(width, height, font_size);
hold on;
export_figure('corr2_scaled_V.eps');



% Corollary 2 Ts plot
figure(2);
color = 'b'; marker = 's';
plot_Ts(T_corr2_cs150, Ts_corr2_cs150, color, line_width, marker, marker_size);
hold on;

color = 'g'; marker = 'o';
plot_Ts(T_corr2_cs1, Ts_corr2_cs1, color, line_width, marker, marker_size);
xlabel("t");
ylabel("Sample Period");

set_figure_options(width, height, font_size);
export_figure('corr2_scaled_Ts.eps');


%% Run Corollary 2 Horizon
% Tunable parameters
Ts_star = 0.25; % Determined through minT_calc_corr2.m
T_min   = Ts_star; 
T_max   = 2;
r       = 0.025;
N       = 10;
cs      = 0;
method  = 1; % 0: Scaled TBar
             % 1: 2-Step horizon TBar
         
% Uncomment to calculate T_s^*.
%minT_calc_corr2(0, T_min, T_max, r, N, cs, ch, method);
            
% CH = 1
ch      = 1;
global Ts_corr2;
global T_corr2;
T_corr2  = [];
Ts_corr2 = []; % Initialize global data
[t_corr2_ch1, j_corr2_ch1, x_corr2_ch1] = ...
    run_corr2_sim(Ts_star, T_min, T_max, r, N, cs, ch, method);
T_corr2_ch1    = T_corr2;
Ts_corr2_ch1   = Ts_corr2;

x1_corr2_ch1 = x_corr2_ch1(:,2);
x2_corr2_ch1 = x_corr2_ch1(:,3);
u_corr2_ch1  = x_corr2_ch1(:,4);
V_corr2_ch1  = get_V(x1_corr2_ch1, x2_corr2_ch1);

% CH = 0.5
ch      = 0.6;
global Ts_corr2;
global T_corr2;
T_corr2  = [];
Ts_corr2 = []; % Initialize global data
[t_corr2_ch0_5, j_corr2_ch0_5, x_corr2_ch0_5] = ...
    run_corr2_sim(Ts_star, T_min, T_max, r, N, cs, ch, method);

T_corr2_ch0_5  = T_corr2;
Ts_corr2_ch0_5 = Ts_corr2;

x1_corr2_ch0_5 = x_corr2_ch0_5(:,2);
x2_corr2_ch0_5 = x_corr2_ch0_5(:,3);
u_corr2_ch0_5  = x_corr2_ch0_5(:,4);
V_corr2_ch0_5  = get_V(x1_corr2_ch0_5, x2_corr2_ch0_5);


Ts_avg_corr2_ch1     = mean(Ts_corr2_ch1);
Ts_avg_corr2_ch0_5   = mean(Ts_corr2_ch0_5);  

%% Plot Corollary 2 Horizon
% Print averages and minimum times
disp("Average Sample Periods");
fprintf('Corollary 2 ch=1: %f\n\n', Ts_avg_corr2_ch1);
fprintf('Corollary 2 ch=0.5: %f\n\n', Ts_avg_corr2_ch0_5);

disp("Minimum Sample Periods");
fprintf('Corollary 2 ch=1: %f\n\n', min(Ts_corr2_ch1));
fprintf('Corollary 2 ch=0.5: %f\n\n', min(Ts_corr2_ch0_5));

% V plot
figure(3);
color  = "g";
marker = 'o'; 
[modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size);
plotHarc(t_corr2_ch1,j_corr2_ch1,V_corr2_ch1, [], modF, modJ);
hold on;

color  = 'b';
marker = 's'; 
[modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size);
plotHarc(t_corr2_ch0_5,j_corr2_ch0_5,V_corr2_ch0_5, [], modF, modJ);
hold on;

h = zeros(2, 1);
h(1) = plot(NaN,NaN, 'g',  'MarkerFaceColor', 'g', 'Marker', 'o', 'MarkerSize', marker_size);
h(2) = plot(NaN,NaN, 'b',  'MarkerFaceColor', 'b', 'Marker', 's', 'MarkerSize', marker_size);
legend(h, '$c_h = 1$','$c_h = 0.5$', 'Interpreter', 'latex');

xlabel("t");
ylabel("V(x(t))");
set_figure_options(width, height, font_size);
hold on;
export_figure('corr2_horizon_V.eps');


% Corollary 2 Ts plot
figure(4);
color = 'g'; marker = 'o';
plot_Ts(T_corr2_ch1, Ts_corr2_ch1, color, line_width, marker, marker_size);
hold on;

color = 'b'; marker = 's';
plot_Ts(T_corr2_ch0_5, Ts_corr2_ch0_5, color, line_width, marker, marker_size);
xlabel("t");
ylabel("Sample Period");
set_figure_options(width, height, font_size);
export_figure('corr2_horizon_Ts.eps');




%% Run Event-Triggered Baseline
% Tunable parameters
epsilon = 0.9; % Margin before control update

[t_ev, j_ev, x_ev] = run_ev_sim(epsilon);

x1_ev = x_ev(:,2);
x2_ev = x_ev(:,3);
u_ev  = x_ev(:,4);
V_ev  = get_V(x1_ev, x2_ev);

global T_ev; global Ts_ev;
% Some data conditioning
T_ev = [T_ev(2:end) T_ev(end) + Ts_ev(end)];
Ts_ev = [Ts_ev(2:end) Ts_ev(end)];
T_ev = T_ev - T_ev(1);
Ts_avg_ev = mean(Ts_ev);

%% Run Di benedetto
% Tunable parameters
v = 0.85;
[t_diben, j_diben, x_diben] = run_diben_sim(v);

x1_diben = x_diben(:,2);
x2_diben = x_diben(:,3);
u_diben  = x_diben(:,4);
V_diben  = get_V(x1_diben, x2_diben);

%Ts_diben = x_diben(:,6);
global Ts_diben;
global T_diben;
Ts_avg_diben = mean(Ts_diben);

%% Print averages and minimum times
disp("Average Sample Periods");
fprintf('Dibenedetto: %f\n\n', Ts_avg_diben);
fprintf('EventTriggered: %f\n\n', Ts_avg_ev);

disp("Minimum Sample Periods");
fprintf('Dibenedetto: %f\n\n', min(Ts_diben));
fprintf('EventTriggered: %f\n\n', min(Ts_ev));

%% Plot the results

%% Plot a comparison of V 
figure(7);
ev_color = 'k';
ev_marker = 'o';
[modF, modJ] = get_hybrid_plot_mods(ev_color, line_width, ev_marker, marker_size);
plotHarc(t_ev,j_ev,V_ev, [], modF, modJ);
hold on;

diben_color = 'm';
diben_marker = 'd';
[modF, modJ] = get_hybrid_plot_mods(diben_color, line_width, diben_marker, marker_size);
plotHarc(t_diben,j_diben,V_diben, [], modF, modJ);
hold on;

corr2_horizon_color = 'b';
corr2_horizon_marker = 's';
[modF, modJ] = get_hybrid_plot_mods(corr2_horizon_color, line_width, corr2_horizon_marker, marker_size);
plotHarc(t_corr2_ch0_5,j_corr2_ch0_5,V_corr2_ch0_5, [], modF, modJ);
hold on;

corr2_scaled_color = 'g';
corr2_scaled_marker = '>';
[modF, modJ] = get_hybrid_plot_mods(corr2_scaled_color, line_width, corr2_scaled_marker, marker_size);
plotHarc(t_corr2_cs150,j_corr2_cs150,V_corr2_cs150, [], modF, modJ);
hold on;

xlabel("t");
ylabel("V(x(t))");
hold on;

h = zeros(4, 1);
h(1) = plot(NaN,NaN, corr2_horizon_color,  'MarkerFaceColor', corr2_horizon_color, 'Marker', corr2_horizon_marker, 'MarkerSize', marker_size);
h(2) = plot(NaN,NaN, corr2_scaled_color,  'MarkerFaceColor', corr2_scaled_color, 'Marker', corr2_scaled_marker, 'MarkerSize', marker_size);
h(3) = plot(NaN,NaN, diben_color,  'MarkerFaceColor', diben_color, 'Marker', diben_marker, 'MarkerSize', marker_size);
h(4) = plot(NaN,NaN, ev_color,  'MarkerFaceColor', ev_color, 'Marker', ev_marker, 'MarkerSize', marker_size);
legend(h, 'Theorem 5, $c_h = 0.5$', 'Theorem 5, $c_s=150$', '[15, Theorem 4.3]','Event Triggered', "Interpreter", "latex");

set_figure_options(width, height, font_size);
export_figure('V_comparison.eps');


%% Plot a comparison of Ts
figure(8);
diben_color = 'm';
diben_marker = 'd';
plot_Ts(T_diben, Ts_diben, diben_color, line_width, diben_marker, marker_size);
hold on;

ev_color = 'k';
ev_marker = 'o';
plot_Ts(T_ev, Ts_ev, ev_color, line_width, ev_marker, marker_size);

corr2_horizon_color = 'b';
corr2_horizon_marker = 's';
plot_Ts(T_corr2_ch0_5, Ts_corr2_ch0_5, corr2_horizon_color, line_width, corr2_horizon_marker, marker_size);

corr2_scaled_color = 'g';
corr2_scaled_marker = '>';
plot_Ts(T_corr2_cs150, Ts_corr2_cs150, corr2_scaled_color, line_width, corr2_scaled_marker, marker_size);
hold on;


xlabel("t");
ylabel("Sample Period");
set_figure_options(width, height, font_size);
export_figure("Ts_comparison.eps");

