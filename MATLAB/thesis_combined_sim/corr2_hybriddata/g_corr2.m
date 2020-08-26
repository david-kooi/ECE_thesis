% ------------------
% University of California Santa Cruz
% Hybrid Systems Lab
% Masters Thesis 2020
% David Kooi
% ------------------

function xplus = g_corr2(x)
%% Jump Dynamics
global A;
global B;
global ctl;

% State: x = [t x1 x2 tau u Ts]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);

x_o          = [x1;x2];
u_o          = ctl(x_o);

global TBar_method;
if(TBar_method == 0)
    [Mr, Ms, TBar] = get_M_TBar_scaled(x_o, u_o);
else
%    [Mr, Ms, TBar] = get_M_TBar_horizon2(x_o, u_o);
    [Mr, Ms, TBar] = get_M_TBar_horizon2_new(x_o, u_o);
end

% Old sampling function
%Ts_plus = get_Ts(x_o, Ms, TBar);
Ts_plus = get_Ts_new(x_o, Mr, Ms, TBar);


xplus   = [t; x1; x2; 0; u_o; Ts_plus];

%% Data Recording
global T_corr2;
global Ts_corr2;
T_corr2 = [T_corr2 t];
Ts_corr2 = [Ts_corr2 Ts_plus];

global TBar_arr;
global norm_Fxo_arr;
norm_F_xo    = norm(A*x_o + B*u_o);
norm_Fxo_arr = [norm_Fxo_arr norm_F_xo];
TBar_arr = [TBar_arr TBar];


end