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


% State: x = [t x1 x2 tau u Ts x1_p x2_p]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);
x1_p = x(7);
x2_p = x(8);




if(tau >= Ts)
    inside = 1;
else
    inside = 0;
end

end