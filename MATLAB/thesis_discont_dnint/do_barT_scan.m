% Returns an array of barT and calculated Ts
function [barT_arr, Ts_xo_barT] = do_barT_scan(T)

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


Ts_xo_barT = [];
barT_arr = 0.05:0.01:1 ;
for (barT = barT_arr)
    
    %Ts_xo = get_Ts_min(barT, T);
    Ts_xo = get_Ts_min_inflation(barT, T);
    
    Ts_xo_barT = [Ts_xo_barT min(Ts_xo)];
     
end

end
