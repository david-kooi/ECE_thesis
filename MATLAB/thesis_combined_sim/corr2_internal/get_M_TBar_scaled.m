function [Mr, Ms, TBar] = get_M_TBar_scaled(x_o, u_o)

global A;
global B;
global TBar_arr;

% Scale Tbar proportional to dynamics
x_dot = A*x_o + B*u_o;
TBar = get_TBar_scaled(x_dot);
TBar_arr = [TBar_arr TBar];

Ms = get_M(x_o, u_o, TBar);
Mr = get_Mr(x_o, u_o, TBar);

end