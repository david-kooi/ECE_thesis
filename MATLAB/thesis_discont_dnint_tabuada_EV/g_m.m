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
global sigma;


global ctl;

global barT;
global Ts_min;



% State: x = [t x1 x2 tau u Ts x1_p x2_p]
t    = x(1);
x1   = x(2);
x2   = x(3);
tau  = x(4);
u    = x(5);
Ts   = x(6);
x1_p = x(7);
x2_p = x(8);

x_o = [x1;x2];
u      = ctl([x1;x2]);

% Compute next sampling time
options = odeset();
[Tout, Xrange] = ode45(@F_dynamic,[0 barT], [x1;x2], options, u);

% gamma_eval = [];
% for(i = 1:length(Xrange(:,1)) )
%     x_t = Xrange(i,1:2)';
%     e = x_o - x_t;
%     gamma_eval = [gamma_eval gamma(x_t,e)]; 
% end
% 
% alpha_eval = sigma*alpha(Xrange(:,1)',Xrange(:,2)');
% diff = alpha_eval - gamma_eval;
% I = find(  0 <= diff );
% I = max(I);
% Ts_plus = max(Tout(I));

% Trigger law from paper
I = [];
for(i = 1:length(Xrange(:,1)) )
    x_t = Xrange(i,1:2)';
    e = x_o - x_t;
    if(norm(e) < sigma*norm(x_t))
       I = [I i]; 
    end
end
I = max(I);
Ts_plus = Tout(I);

xplus = [t; x1; x2; 0; u; Ts_plus; x1; x2];
end