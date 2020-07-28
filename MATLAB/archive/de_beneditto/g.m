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
global psi_0;
global psi_1;
global ST;


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

u   = -k1*x1 - k2*x2;

A = [0,1; 0, 0];
B = [0; 1];
K = [k1, k2];
A_hat = A-B*K;
P = lyap(A_hat, eye(2));

%% Self Triggering Calculation
La_3 = 0.1; % Lipschitz constants of Lyanunov fn
La_4 = 10;

M1 = abs(k1*x2-k1*k2*x1 - k2^2*x2);


cvx_begin
variable z(2);

M2 = k1*k2*z(2) - k1*(k1*z(1) + k2*z(2)) + k2^2*(k1*z(1) + k2*z(2));
maximize(M2);
norm(z) < quad_form([x1;x2], P);
cvx_end

M2 = abs(M2);
v = 0.1;
cvx_begin
variable Ts_plus;

maximize(Ts_plus);
M1*Ts_plus + M2*square(Ts_plus) < v/(La_3*La_4);

cvx_end


if(Ts_plus < 1)
    Ts_plus = 1;
end
    
% State: x = [x1  x2  u tau   Ts      Ts_min  t]
xplus      = [x1; x2; u; 0;   Ts_plus; Ts_min; t];
end