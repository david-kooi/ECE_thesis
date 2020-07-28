function minT_calc_corr2(Ts_star, T_min, T_max, r, N, cs, ch, method)
initialization_corr2(T_min, T_max, r, N, cs, ch, method);

global A;
global B;
global P;
global alpha;

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

end






