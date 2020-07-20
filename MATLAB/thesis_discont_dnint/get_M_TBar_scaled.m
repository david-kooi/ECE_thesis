function [M,TBar] = get_M_TBar_scaled(x_o, u_o)

global A;
global B;
global TBar_arr;
global V;

% Scale Tbar proportional to dynamics
x_dot = A*x_o + B*u_o;
TBar = get_TBar_scaled(x_dot);
TBar_arr = [TBar_arr TBar];

M = get_M(x_o, u_o, TBar);


end