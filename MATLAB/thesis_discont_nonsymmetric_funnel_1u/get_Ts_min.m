function get_Ts_min(run, T)

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

global alpha;
alpha = @(t,x) psi_1_dot(t).*rho_2(t,x) - psi_2_dot(t).*rho_1(t,x) + ctl(t,x).*(rho_1(t,x) - rho_2(t,x));


if(run)
    tspan = 0:0.01:T;
    
    [barT_arr, Ts_xo_barT] = do_barT_scan(T);
    
    
    %% Plot the results
    % Figure Parameters
%     width       = 1000;
%     height      = 500;
%     font_size   = 50;
%     marker_size = 30;
%     line_width  = 2;

% Laptop 
    width       = 1000;
    height      = 500;
    font_size   = 18;
    marker_size = 10;
    line_width  = 2;
    
    figure(4);
    plot(barT_arr, Ts_xo_barT, "k", "LineWidth", line_width);
    set_figure_options(width, height, font_size);
    xlabel("$\bar{T}$", 'interpreter','latex')
    ylabel("$T_2$",'interpreter','latex' );
    export_figure('funnel_Ts_calc.eps');
    hold on

    
else
    % Do nothing
end

%figure(3);
%plot(alpha(tspan, psi_2(tspan)));
%title("\alpha(t,x)");
end






