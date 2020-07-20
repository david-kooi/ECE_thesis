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

% initial conditions
% State: x = [t x1]
x0 =         [0 1];                % Tau starts at 1 to make sure control 
                                     % Calculated from the start


global V;                          
global psi;
global psi_dot;
global ctl;
alpha = 1;
lambda = 0;
delta  = 0.5;

V = @(x) 0.5*x(1)^2 + 0.5*x(2)^2


psi       = @(t,x) alpha*exp(-t) + lambda;
psi_dot   = @(t,x) -psi(t,x);
ctl         = @(t,x) - (psi(t,x).^2 / (1.5*psi(t,x).^2 - x.^2))*x;
rho       = @(t,x) 0.5*psi(t,x).^2 - 0.5*x.^2;
rho_dot   = @(t,x) -psi(t,x).^2 + x.*ctl(t,x);


% simulation horizon
TSPAN=[0 50];
JSPAN = [0 100];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.1);

% simulate
[t,j,x] = HyEQsolver( @f,@g,@C,@D,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');


x1_arr = x(:,2);
u_arr  = ctl(t,x1_arr);

clf;
figure(1);
%plot(t, x(:,2));
%hold on;
plot(t, u_arr);


figure(2);
hold on
plot(t,psi(t,x1_arr)); 
plot(t,-psi(t,x1_arr));
plot(t,x1_arr);
grid on;


figure(3);
hold on;
plot(t,rho(t,x1_arr));
%plot(t,rho_dot(t,x1_arr));
grid on



% % plot solution
% figure(1) % position
% clf
% subplot(2,1,1), plotHarc(t,j,x(:,2));
% subplot(2,1,2), plotHarc(t,j,x(:,3));
% grid on
% ylabel('x_1 position');
% 
% 
% figure(2);
% plot(t,psi(t,0));
% 
% 
% % plot hybrid arc
% figure(3)
% plotHybridArc(t,j,x)
% xlabel('j')
% ylabel('t')
% zlabel('x1')

