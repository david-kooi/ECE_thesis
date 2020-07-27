x = linspace(0.01, 1, 100);

T_max = 2;
T_min = 0.25;
c = 0.5;
TBar = do_TBar_scaled_function(x, c, T_max, T_min);
plot(x, TBar);
set(gca, 'FontName', 'Times New Roman');
xlabel("$||F_N(x_o)||$", 'interpreter','latex');
ylabel("$\bar{T}(x_o)$", 'interpreter','latex')