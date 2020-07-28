function plot_Ts(T_arr, Ts_arr, color, line_width, marker, marker_size)

%T_arr = T_arr - T_arr(1);
stairs(T_arr, Ts_arr, color, "LineWidth", line_width);
hold on;
scatter(T_arr, Ts_arr, marker_size^2, color, marker, 'filled');
% Per: https://www.mathworks.com/matlabcentral/answers/454164-marker-size-difference-between-plot-and-scatter-function
% To have scatter marker same size as plot, the size is squared.

end