function TBar = do_TBar_scaled_function(x_dot_normalized, c, T_max, T_min)

TBar = (T_max - T_min)*(1- x_dot_normalized).^c + T_min;
end