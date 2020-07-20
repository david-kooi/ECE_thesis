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
x0 =         [0 -0.5];                % Tau starts at 1 to make sure control 
                                     % Calculated from the start

global ctl;


%% Funnel Options
a = 2;
b = 1;
c = 3;
d = 0.5;
psi_1     = @(t) (-a.*t.^2 + b).*exp(-t);
psi_1_dot = @(t) -2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t);
psi_1_ddot = @(t) 4*a.*t.*exp(-t) - 2*a.*exp(-t) - (a.*t.^2 - b).*exp(-t);
psi_2     = @(t) (-a - c.*t.^2).*exp(-t);
psi_2_dot = @(t) -2*c.*t.*exp(-t) - (-a - c.*t.^2).*exp(-t);
psi_2_ddot = @(t) 4*c.*t.*exp(-t) - 2*c.*exp(-t) - (a + c.*t.^2).*exp(-t);
V         = @(x)   x;
rho_1     = @(t,x) psi_1(t) - V(x);
rho_2     = @(t,x) V(x) - psi_2(t);
%rho_dot = @(t,x) -x.^2.*((-a - c.*t.^2).^2.*(-0.5*x.^2 + 0.5*(-a.*t.^2 + b).^2.*exp(-2*t)).*exp(-2*t) + (0.5*x.^2 - 0.5*(-a - c.*t.^2).^2.*exp(-2*t)).*(-a.*t.^2 + b).^2.*exp(-2*t)).*(-1.0*x.^2 + 0.5*(-a - c.*t.^2).^2.*exp(-2*t) + 0.5*(-a.*t.^2 + b).^2.*exp(-2*t))./(-x.^2.*(-a - c.*t.^2).^2.*(d + 1).*(-0.5*x.^2 + 0.5*(-a.*t.^2 + b).^2.*exp(-2*t)).*exp(-2*t) + (-x.^2 + (d + 1).*(-a.*t.^2 + b).^2.*exp(-2*t)).*(0.5*x.^2 - 0.5*(-a - c.*t.^2).^2.*exp(-2*t))) + (-a - c.*t.^2).*(0.5*x.^2 - 0.5*(-a - c.*t.^2).^2.*exp(-2*t)).*(-2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t)).*exp(-t) + (-0.5*x.^2 + 0.5*(-a.*t.^2 + b).^2.*exp(-2*t)).*(-a.*t.^2 + b).*(-2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t)).*exp(-t);
%%

%% Control
d   = @(t,x) 1;
u1      = @(t,x) psi_2_dot(t) + d(t,x);
u2      = @(t,x) psi_1_dot(t) - d(t,x);
lambda  = @(t,x) (psi_1(t) - x)/(psi_1(t) - psi_2(t));
ctl     = @(t,x)  (1-lambda(t,x)) * u2(t,x) + lambda(t,x)*u1(t,x);


%%
% simulation horizon
TSPAN=[0 10];
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
plot(t, psi_1(t));
hold on
plot(t, psi_2(t));
%plot(t, A1(t,x1_arr));
plot(t, x1_arr);

figure(2);
plot(t,lambda(t,x1_arr));
hold on;

figure(3);
plot(t,u_arr);
%plot(t, u_arr);

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


%% System
function [g1, g2] = g(x)
    g1 = x(2); g2 = 1;
end

function [dVdx1, dVdx2] = gradV(x)
    dVdx1 = x(1);
    dVdx2 = x(2);
end
