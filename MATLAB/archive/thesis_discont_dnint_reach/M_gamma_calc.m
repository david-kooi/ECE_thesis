clear all;
close all;


global A;
global B;
global P;
global alpha;

initialization();

tspan = 0:0.01:40;


[barT_arr, Ts_xo_barT] = do_barT_scan(1);
figure();
plot(barT_arr, Ts_xo_barT);
xlabel("$\bar{T}$", 'interpreter','latex')
ylabel("$T^*_s$",'interpreter','latex' );

%[Ts_arr] = get_Ts(1, 40);
%min(Ts_arr)
% 
% figure();
% plot(Ts_arr);
% title("Ts(x_o)")








