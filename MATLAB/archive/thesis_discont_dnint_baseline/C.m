function [value] = C(x) 
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: C_ex1_2.m
%--------------------------------------------------------------------------
% Description: Flow set
% Return 0 if outside of C, and 1 if inside C
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

global c;
global sigma;
global alpha;
global gamma;
global V;
global V_sls_value;

% State: x = [t x1 x2 tau u Ts x1_p x2_p]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);
x1_p = x(7);
x2_p = x(8);

e = [x1_p - x1; x2_p - x2];
g = gamma([x1;x2],e);
a = alpha([x1;x2]);
V_dot = -a + g;

%if(g < sigma*a) % From Paper
%if(norm(e) < sigma*norm([x1;x2])) % From paper
%if(V_dot < c*V_sls_value)
if(V([x1;x2]) < V_sls_value)
    value = 1;
else
    value = 0;
end

end