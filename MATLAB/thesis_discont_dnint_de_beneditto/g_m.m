function xplus = g_m(x)
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
global A;
global B;
global P;
global Q;
global K;
global V;
global V_sls_value;
global V_sls_boundary;
global u_applied;
global alpha;
global gamma;
global F;
global lam_Q_min;


global ctl;

global barT;
global Ts_min;

global sls;
global M1; global M2;
global a1; global a2; global a2_inv;
global a3; 
global a4;
global delta;


% State: x = [t x1 x2 tau u Ts]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);

u      = ctl([x1;x2]);
xo = [x1;x2];

v = 0.85;
xo = [x1;x2];

I1 = a4(delta)*M1(xo);
I2 = a4(delta)*M2(xo);
I3 = v*a3(a2_inv(a1(delta)));

% Need to solve: I1*Ts + I2*Ts^2 - I3 <= 0
Trange = 0:0.001:2;
Ts_max = 0;
for(Ts = Trange)
    val = I1*Ts + I2*Ts^2 - I3;
    if(val <= 0)
        Ts_max = Ts;
    end
end
Ts_plus = Ts_max;

xplus = [t; x1; x2; 0; u; Ts_plus];
end