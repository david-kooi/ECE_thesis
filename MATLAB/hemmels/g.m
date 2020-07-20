function xplus = g_ex1_2(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: g_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Jump map
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
global k1;
global k2;
global gamma;
global V;
global x1_0;
global x2_0;
global V_arr;
global A;
global A_inv;
global B;
global K;
global t_arr;

% State: x = [x1 x2 u tau Ts Ts_min t]
x1     = x(1);
x2     = x(2);
u      = x(3);
tau    = x(4);
Ts     = x(5);
Ts_min = x(6);
t      = x(7);

u   = -K*[x1;x2];

%% Self Triggering Calculation
T_max = 4;
delta = 0.1;
n = 0;
N_max = T_max / delta;

hc_min = 0;
hc_tmp = 0;
n_max  = 0; 

U = B*u;
T1 = expm(A*(delta));
T2 = expm(A*(-delta))
x_n = [x1;x2];

fun = @(tau) expm(A.*tau) * U;


for(n = 0:1:N_max)
    x_n = T1*x_n + A_inv*(eye(2) - T2)*U;
    
    %x_n = expm(A*n*delta)*[x1;x2] + integral(fun, 0, n*delta, 'ArrayValued', true);
    
    
    ex = exp(-gamma*(delta*n));
    v0 = V([x1;x2])*ex;
    v1 = V(x_n);
    hc_tmp = v1 - v0;
    if(hc_tmp <= 0)
        n_max = n;
    end
end

Ts_plus = max(Ts_min, n_max*delta);

V_arr = [V_arr V([x1;x2])];
t_arr = [t_arr t];

% State: x = [x1  x2  u tau   Ts      Ts_min  t]
xplus      = [x1; x2; u; 0; Ts_plus; Ts_min; t];
end