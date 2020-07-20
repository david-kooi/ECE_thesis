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


global ctl;
global max_x2;
global max_x;
global max_x_dot;
global max_TBar;
global lambda_TBar;
global A;
global B;

initialization();

% initial conditions
x1_o = 0.2; x2_o = -0.2; % Original

%x1_o = 0; x2_o = 0.3;
xo = [x1_o; x2_o];



u_o  = ctl([x1_o;x2_o]);
% State: x = [t x1   x2   tau  u    Ts]
x0 =         [0 x1_o x2_o  0   u_o  0];   % Tau starts at 1 to make sure control 
                                          % Calculated from the start
                                          
                                          % Minimum Time and barT
                               

                                          

global Ts_min;
global getTBar_scaled;
global TBar_arr;
global norm_Fxo_arr;
norm_Fxo_arr = [];

Ts_min = 0.25;
%barT   = 0.625;
%barT = 0.28;

%
% simulation horizon
TSPAN=[0 30];
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
x2_arr = x(:,3);
u_arr  = x(:,4);
Ts_arr = x(:,6);
mean(Ts_arr)

% Get Signal L2 norm
x_data = [x1_arr, x2_arr];
L2 = sqrt(trapz(vecnorm(x_data).^2))

data.t = t;
data.j = j;
data.Ts_arr = Ts_arr;


figure(11);
modF{1} = 'b';

modJ{1} = 'b';
modJ{2} = 'Marker';
modJ{3} = '*';

plotHarc(t,j,x(:,2), [], modF, modJ);
xlabel("t(seconds)");
ylabel("x_1");
hold on;

% Sample period plot
figure(12);
modF{1} = 'b';

modJ{1} = 'b';
modJ{2} = 'Marker';
modJ{3} = '*';


plotHarc(t,j,x(:,6), [0,j(end)], modF, modJ);
xlabel("t(s)");
ylabel("Sample Period (s)");
hold on;



% % plot solution
 figure() % position
 clf
 subplot(2,1,1), plotHarc(t,j,x(:,2));
 hold on;
 xlabel("Time (s)");
 ylabel("x_1");
 subplot(2,1,2), plotHarc(t,j,x(:,6));
 grid on
 ylabel('Sample Period(s)');
 xlabel("Time(s)");
 
figure(10);
plot(x1_arr, x2_arr);

figure()
subplot(2,1,1);
plot(norm_Fxo_arr);
subplot(2,1,2);
plot(TBar_arr);

%figure(2);
%plot(t,df(t));
%hold on;

%figure(3);
%plot(t, u_arr);

%figure(4);
%bar(Ts_arr);


figure();
plot(TBar_arr);
title("$\bar{T}$");


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
