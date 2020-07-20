clear all;
close all;


global d_f;
global ctl;
global u1; global u2; global lambda;
global dddt_f;
global dddx_f;

global df;
global ctl;
global psi_1;
global psi_1_dot;
global psi_1_ddot;
global psi_2;
global psi_2_dot;
global psi_2_ddot;
global V;
global rho_1;
global rho_2;

get_funnel();
get_control();

global alpha;
alpha = @(t,x) psi_1_dot(t).*rho_2(t,x) - psi_2_dot(t).*rho_1(t,x) + ctl(t,x).*(rho_1(t,x) - rho_2(t,x));



tspan = 0:0.01:40;

figure(1);
plot(tspan, psi_1(tspan));
hold on
plot(tspan, psi_2(tspan));


[barT_arr, Ts_xo_barT] = do_barT_scan(40);
figure();
plot(barT_arr, Ts_xo_barT);
xlabel("$\bar{T}$", 'interpreter','latex')
ylabel("$T^*_s$",'interpreter','latex' );
set(gca, 'FontName', 'Times New Roman');


%[Ts_arr] = get_Ts(1, 40);
%min(Ts_arr)
% 
% figure();
% plot(Ts_arr);
% title("Ts(x_o)")




figure(3);
plot(alpha(tspan, psi_2(tspan)));
title("\alpha(t,x)");







