clear all;
close all;

%% Initial Condition and Time Horizon
x1_o = -0.1;
x2_o = 0.3;
T = 10;
initialization_common(T, x1_o, x2_o);

%% Run Corollary 2
% Tunable parameters
Ts_star = 0.25; % Determined through minT_calc_corr2.m
T_min   = Ts_star; 
T_max   = 2;
r       = 0.025;
N       = 10;
cs      = 150;
ch      = 0.5;
method  = 1; % 0: Scaled TBar
             % 1: 2-Step horizon TBar
         
% Uncomment to calculate T_s^*.
%minT_calc_corr2(0, T_min, T_max, r, N, cs, ch, method);
            
[t_corr2, j_corr2, x_corr2] = ...
    run_corr2_sim(Ts_star, T_min, T_max, r, N, cs, ch, method);

x1_corr2 = x_corr2(:,2);
x2_corr2 = x_corr2(:,3);
u_corr2  = x_corr2(:,4);
V_corr2  = get_V(x1_corr2, x2_corr2);

%Ts_corr2 = x_corr2(:,6);
global Ts_corr2;
Ts_avg_corr2 = mean(Ts_corr2);

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
Ts_avg_diben = mean(Ts_diben);

%% Print averages and minimum times
disp("Average Sample Periods");
fprintf('Corollary 2: %f\n\n', Ts_avg_corr2);
fprintf('Dibenedetto: %f\n\n', Ts_avg_diben);
fprintf('EventTriggered: %f\n\n', Ts_avg_ev);

disp("Minimum Sample Periods");
fprintf('Corollary 2: %f\n\n', min(Ts_corr2));
fprintf('Dibenedetto: %f\n\n', min(Ts_diben));
fprintf('EventTriggered: %f\n\n', min(Ts_ev));

%% Plot the results
% Figure Parameters
width       = 1000;
height      = 400;
font_size   = 50;
marker_size = 30;
line_width  = 4;

% Individual plots

%% Corollary 2
% Corollary 2 V plot
color  = 'b';
marker = 's'; 
[modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size);

figure(1);
plotHarc(t_corr2,j_corr2,V_corr2, [], modF, modJ);
xlabel("Time(s)");
ylabel("V(x)");
set_figure_options(width, height, font_size);
export_figure('.eps');


% Corollary 2 Ts plot
figure(2);
global T_corr2; global Ts_corr2;
plot_Ts(T_corr2, Ts_corr2, color, line_width, marker, marker_size);
xlabel("Time(s)");
ylabel("Sample Period (s)");
set_figure_options(width, height, font_size);
export_figure('corr2_Ts_horizon_c_0_5.eps');


%% DiBenedetto
% DiBenedetto V plot
color  = 'm';
marker = 'd'; 
[modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size);

figure(3);
plotHarc(t_diben,j_diben,V_diben, [], modF, modJ);
xlabel("Time(s)");
ylabel("V(x)");
set_figure_options(width, height, font_size);
export_figure('diben_V.eps');

% DiBenedetto Ts Plot
figure(4);
global T_diben; global Ts_diben;
plot_Ts(T_diben, Ts_diben, color, line_width, marker, marker_size);
xlabel("Time(s)");
ylabel("Sample Period (s)");
set_figure_options(width, height, font_size);
export_figure('diben_Ts.eps');

%% Event Triggered
% Event Triggered V plot
color  = 'k';
marker = 'o'; 
[modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size);

figure(5);
plotHarc(t_ev,j_ev,V_ev, [], modF, modJ);
xlabel("Time(s)");
ylabel("V(x)");
set_figure_options(width, height, font_size);
export_figure('ev_V.eps');

% Event Triggered Ts Plot
figure(6);
plot_Ts(T_ev, Ts_ev, color, line_width, marker, marker_size);
xlabel("Time(s)");
ylabel("Sample Period (s)");
set_figure_options(width, height, font_size);
export_figure("ev_Ts.eps");

%% Plot a comparison of Ts 
figure(7);
diben_color = 'm';
diben_marker = 'd';
plot_Ts(T_diben, Ts_diben, diben_color, line_width, diben_marker, marker_size);
hold on;

ev_color = 'k';
ev_marker = 'o';
plot_Ts(T_ev, Ts_ev, ev_color, line_width, ev_marker, marker_size);

corr2_color = 'b';
corr2_marker = 's';
plot_Ts(T_corr2, Ts_corr2, corr2_color, line_width, corr2_marker, marker_size);

xlabel("Time(s)");
ylabel("Sample Period (s)");
set_figure_options(width, height, font_size);
export_figure("Ts_comparison.eps");

h = zeros(3, 1);
h(1) = plot(NaN,NaN, corr2_color,  'MarkerFaceColor', corr2_color, 'Marker', corr2_marker, 'MarkerSize', marker_size);
h(2) = plot(NaN,NaN, diben_color,  'MarkerFaceColor', diben_color, 'Marker', diben_marker, 'MarkerSize', marker_size);
h(3) = plot(NaN,NaN, ev_color,  'MarkerFaceColor', ev_color, 'Marker', ev_marker, 'MarkerSize', marker_size);
legend(h, 'Corollary 2','[DiBenedetto, Theorem 4.3]','Event Triggered');
