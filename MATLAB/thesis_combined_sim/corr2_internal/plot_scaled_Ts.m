T_max = 2;
T_min = 0.25;
x = linspace(0, 0.2,1000);
c = 150;
y = (T_max - T_min)*(1-x).^c + T_min;

%% Plot the results
% Figure Parameters
width       = 1000;
height      = 400;
font_size   = 50;
marker_size = 30;
line_width  = 4;

figure();
plot(x,y, 'k', 'LineWidth', line_width);
xlabel("$F_N(x_o)$", "interpreter", "latex");
ylabel("$\bar{T}$", "interpreter","latex");
set_figure_options(width, height, font_size);
export_figure('scaled_Ts_eq.eps');