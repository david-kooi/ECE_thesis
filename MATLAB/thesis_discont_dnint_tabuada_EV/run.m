%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: run_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
clc;
clear all;
close all;

% initial conditions
x1_o = 5; x2_o = 0;
% State: x = [t x1   x2   tau  u Ts x1_p x2_p]
x0 =         [0 x1_o x2_o  0   0  0 x1_o x2_o];   % Tau starts at 1 to make sure control 
                                     % Calculated from the start
global ctl;
global e_arr;
global sigma_x_norm;
e_arr = [];
sigma_x_norm = [];

% Minimum Time and barT
global Ts_min;
global barT;
Ts_min = 0.0237;
barT   = 1;

initialization();


%%
% simulation horizon
TSPAN=[0 10];
JSPAN = [0 10000];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.1);

% simulate
[t,j,x] = HyEQsolver( @f,@g_m,@C,@D,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');

x1_arr = x(:,2);
u_arr  = x(:,4);
Ts_arr = x(:,5);

% % plot solution
 figure() % position
 clf
 subplot(2,1,1), plotHarc(t,j,x(:,2));
 hold on;
 xlabel("Time (s)");
 ylabel("x");
 subplot(2,1,2), plotHarc(t,j,x(:,6));
 grid on
 ylabel('Sample Period(s)');
 xlabel("Time(s)");
 hold on
plot(t, 0*t + 0.0237);

figure();
plot(e_arr(:,1),e_arr(:,2),'r');

hold on;
plot(sigma_x_norm(:,1),sigma_x_norm(:,2), 'b');
legend('|e(t)|', '\sigma|x(t)|');

%figure(3);
%plot(t, u_arr);

%figure(4);
%bar(Ts_arr);





% 
% 
% figure(2);
% plot(t,psi(t,0));
% 
% 
% % plot hybrid arc
 figure(6)
 plotHybridArc(t,j,x(:,2));
 xlabel('j')
 ylabel('t')
 zlabel('x1')


%% System
function [g1, g2] = g(x)
    g1 = x(2); g2 = 1;
end

function [dVdx1, dVdx2] = gradV(x)
    dVdx1 = x(1);
    dVdx2 = x(2);
end
