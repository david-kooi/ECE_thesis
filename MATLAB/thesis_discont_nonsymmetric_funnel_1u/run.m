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
% State: x = [t x1 tau u Ts]
x0 =         [0 0 1 0 0];         % Tau starts at 1 to make sure control 
                                     % Calculated from the start
global df;
global ctl;
global u1; global u2; global lambda;


global psi_1;
global psi_1_dot;
global psi_2;
global psi_2_dot;
global V;
global rho_1;
global rho_2;

% Minimum Time and barT
global Ts_min;
global barT;
Ts_min = 0.56;
barT   = 1.75;

get_funnel();
get_control();


%%
% simulation horizon
TSPAN=[0 40];
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

 set(gca, 'FontName', 'Times New Roman');
% % plot solution
 figure() % position
 
modF{1} = 'k';
modJ{1} = 'k';
modJ{2} = 'Marker';
modJ{3} = '*';
 subplot(2,1,1), plotHarc(t,j,x(:,2), [], modF, modJ);
  set(gca, 'FontName', 'Times New Roman');
 hold on;
 plot(t, psi_1(t), "r");
 hold on
 plot(t, psi_2(t), "b");
 xlabel("Time (s)");
 ylabel("x");


 subplot(2,1,2), plotHarc(t,j,x(:,5), [], modF, modJ);
 set(gca, 'FontName', 'Times New Roman');
 grid on
 ylabel('Sample Period(s)');
 xlabel("Time(s)");
 hold on;

h = zeros(3, 1);
h(1) = plot(NaN,NaN,'r');
h(2) = plot(NaN,NaN,'b');
h(3) = plot(NaN,NaN,'k');
legend(h, '\psi_1','\psi_2','x');
set(gca, 'FontName', 'Times New Roman');


%figure(2);
%plot(t,df(t));
%hold on;

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
