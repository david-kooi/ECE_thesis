function xdot = f_ex1_2(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: f_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Flow map
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

% State: x = [x1 x2 u tau Ts Ts_min t]
x1     = x(1);
x2     = x(2);
u      = x(3);
tau    = x(4);
Ts     = x(5);
Ts_min = x(6);
t      = x(7);

global t2_arr;
if(t > 15)
    t2_arr = [t2_arr Ts];
end

xdot = [x2; u; 0; 1; 0; 0; 1];
end