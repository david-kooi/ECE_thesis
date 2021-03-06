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
global gam_arr;
global sigma_alpha_arr;
global V;
global Ts_arr;
global T_arr;
global t_arr;
global V_arr;

gam_arr = [];
sigma_alpha_arr = [];
Ts_arr = [];
T_arr = [];

initialization();


% initial conditions
x1_o = 0.2; x2_o = -0.2;% Original


%x1_o = 0.0; x2_o = 0.3; %

u_o = ctl([x1_o;x2_o]);
% State: x = [t x1   x2   tau  u    Ts x1_p x2_p]
x0 =         [0 x1_o x2_o  0   u_o  0  x1_o x2_o];   % Tau starts at 1 to make sure control 
                                                  % Calculated from the start



%%
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
mean(x(:,6))
%Ts_arr = x(:,6);


% Get Signal L2 norm
x_data = [x1_arr, x2_arr];
L2 = sqrt(trapz(vecnorm(x_data).^2));

% State plot
figure(11);
modF{1} = 'k';

modJ{1} = 'k';
modJ{2} = 'Marker';
modJ{3} = 'x';
modJ{4} = 'MarkerSize';
modJ{5} = 20;

plotHarc(t,j,x(:,2), [], modF, modJ);
xlabel("Time(s)");
ylabel("x_1");
set(gca, 'FontName', 'Times New Roman', 'FontSize', 25);
set(gcf,'Position',[100 100 500 200]);
hold on;

% Sample period plot
figure(12);
modF{1} = 'k';

modJ{1} = 'k';
modJ{2} = 'Marker';
modJ{3} = 'x';

T_arr = T_arr - T_arr(1);
T_arr =  [T_arr T_arr(end) + Ts_arr(end)];
Ts_arr = [Ts_arr Ts_arr(end)];
stairs(T_arr, Ts_arr, "k");
hold on;
scatter(T_arr, Ts_arr, 20,"xk");
% plotHarc(t,j,x(:,6), [0,j(end)], modF, modJ);
xlabel("Time(s)");
ylabel("Sample Period (s)");
set(gca, 'FontName', 'Times New Roman', 'FontSize', 30);
set(gcf,'Position',[100 100 500 200]);
hold on;





data.t = t;
data.j = j;
data.Ts_arr = Ts_arr;

% % plot solution
 figure() % position
 clf
 subplot(2,1,1), plotHarc(t,j,x(:,2));
 grid on;
 hold on;
 xlabel("Time (s)");
 ylabel("x_1");
 
 modF{1} = 'w';
 subplot(2,1,2), plotHarc(t,j,x(:,6), [0,j(end)], modF, {});
 grid on
 ylabel('Sample Period(s)');
 xlabel("Time(s)");

figure();
plot(gam_arr(:,1),gam_arr(:,2),'r');

hold on;
plot(sigma_alpha_arr(:,1),sigma_alpha_arr(:,2), 'b');
legend('|e(t)|', '\sigma|x(t)|');


% % plot hybrid arc
 figure(6)
 plotHybridArc(t,j,x(:,2));
 xlabel('j')
 ylabel('t')
 zlabel('x1')
 
 figure();
 plot(t_arr, V_arr);
 
figure(10);
hold on;
plot(x1_arr, x2_arr);
% for(i = 1:length(x1_arr(:)))
%     V_val = V([x1_arr(i);x2_arr(i)]);
%     scatter3(x1_arr(i),x2_arr(i), V_val);
%     %scatter(x1_arr(i), x2_arr(i));
%     hold on;
% end


 


