function Ts_plus = get_Ts(x_o, M, TBar)
global V_sls_value;
global V;
global Ts_min;

rho = V_sls_value - V(x_o);
Ts_plus = max(Ts_min, min(TBar, rho/M));
end