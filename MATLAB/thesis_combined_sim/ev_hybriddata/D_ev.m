function inside = D(x) 
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: D_ex1_2.m
%--------------------------------------------------------------------------
% Description: Jump set
% Return 0 if outside of D, and 1 if inside D
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

global V;
global V_sls_value;
global epsilon;

global B;
global K;
global Q;
global P;

global x1_p;
global x2_p;


% State: x = [t x1 x2 tau u Ts x1_p x2_p]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);

x_p = [x1_p, x2_p]';
x_o = [x1;x2];

V_dot = -x_p'*Q*x_p + (1/2)*x_o'*P*B*K*(x_p-x_o);
V_val = V([x1;x2]);
if(V_val >= epsilon*V_sls_value && V_dot > 0)
    inside = 1;
else
    inside = 0;
end

global first_jump;
if(first_jump == 1)
    inside = 1;
    first_jump = 0;
end


end