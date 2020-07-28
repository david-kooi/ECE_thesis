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

global x1_0;
global x2_0;

x1_0 = 1;
x2_0 = 0;

% initial conditions
% State: x = [x1     x2    u tau Ts Ts_min t]
x0 =         [x1_0, x2_0 , 0, 1, 0,  0.1, 0]; % Tau starts at 1 to make sure control 
                                    % Calculated from the start
                                    
global k1;
global k2;
k1 = 1;
k2 = 1;


global A;
global A_inv;
global B;
global K;
A = [0 1; 0 0];
B = [0; 1];
K = [k1, k2];
A_inv = pinv(A);


A_hat = A-B*K;
P = lyap(A_hat, eye(2));
l_max = max(eig(P));

global gamma;
gamma = 1/(2*l_max);

global V;
V = @(x) x'*P*x;

global V_arr;
V_arr = [];

global u_arr;
u_arr = [];
                
global t_arr;
t_arr = [];

global t2_arr;
t2_arr = [];
                            
% simulation horizon
TSPAN=[0 30];
JSPAN = [0 100];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.1);

% simulate
[t,j,x] = HyEQsolver( @f,@g,@C,@D,...
    x0,TSPAN,JSPAN,rule,options,'ode23t');

% plot solution
figure(1) % position
clf
subplot(2,1,1), plotHarc(t,j,x(:,1));
ylabel('x1');
xlabel('t');
subplot(2,1,2);
stairs(t,x(:,3)');
grid on
ylabel('u')
xlabel('t');
hold on

% plot V
figure(2);
plot(t_arr, V_arr);
xlabel('t');
ylabel('V(x)');

Ts_mean = mean(x(:,5))
Ts2_mean = mean(t2_arr)

