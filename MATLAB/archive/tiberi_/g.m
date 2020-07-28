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
global V_arr;
global V;
global t_arr;

% State: x = [x1 x2 u tau Ts Ts_min t]
x1     = x(1);
x2     = x(2);
u      = x(3);
tau    = x(4);
Ts     = x(5);
Ts_min = x(6);
t      = x(7);

k1 = 1;
k2 = 1;


%% Self Triggering Calculation
L_fu = 1;
L_kx = 1;

delta = 0.5;
L = L_fu*L_kx;

u   = -k1*x1 - k2*x2;
%if(u < 0.01 && u > 0)
%    u = 0.01;
%elseif(u > -0.01 && u < 0)
%    u = -0.01;
%end
    
norm_f = sqrt(x2^2 + u^2);
if(norm_f < 0.01)
    norm_f = 0.01;
end


Ts_plus = 1/(2*L)*log(1+(2*delta)/norm_f);


V_arr = [V_arr V([x1;x2])];
t_arr = [t_arr t];


% State: x = [x1  x2  u tau   Ts      Ts_min  t]
xplus      = [x1; x2; u; 0; Ts_plus; Ts_min; t];
end