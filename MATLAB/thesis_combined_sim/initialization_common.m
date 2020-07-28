function initialization_common(in_T, in_x1_o, in_x2_o)

%% Common Simulation Parameters
global x1_o; global x2_o;
global T;
x1_o = in_x1_o;
x2_o = in_x2_o;
T = in_T;

%% Data logging structures
global T_corr2; global Ts_corr2;
T_corr2 = []; Ts_corr2 = [];
global T_diben; global Ts_diben;
T_diben = []; Ts_diben = [];
global T_ev;    global Ts_ev;
T_ev = []; Ts_ev = [];


%% Linear Dynamics
global A;
global B;
global P;
global Q;
global K;
global V;
global ctl;
global lam_Q_min;
global lam_P_max;
global lam_P_min;
global delta;

A = [0, 1; -2, 3];
B = [0; 1];
K = [1, -4];

ctl = @(x) K*x;

Q = [0.5, 0.25; 0.25, 1.5];
P = [1, 0.25; 0.25, 1];
lam_Q_min = min(eig(Q));
lam_P_max = max(eig(P));
lam_P_min = min(eig(P));


%% Sublevel set configuration
global V_sls_value;
global V_sls_boundary;
V = @(x) x'*P*x;
V_sls_value = 0.1;

%% Get the subevel set and it's boundary
global state_grid;
x1 = linspace(-0.5,0.5,100);
x2 = linspace(-0.5,0.5,100);
[X1,X2] = meshgrid(x1,x2);
x1 = X1(:); x2 = X2(:);
state_grid = [x1,x2];

x = [x1, x2]';
sls = [];
for(x_vec = x)
   if(V(x_vec) <= V_sls_value)
    sls = [sls [x_vec; V(x_vec)]];
   end
end


%scatter3(sls(1,:)',sls(2,:)', sls(3,:)');
j = boundary(sls(1,:)', sls(2,:)');
V_sls_boundary = [sls(1,j)',sls(2,j)']';
figure(10);
%plot3(sls(1,j),sls(2,j),sls(2,j)*0 + V_sls_value);
plot(sls(1,j),sls(2,j));
xlabel("x_1"); ylabel("x_2");
hold on;

%% General data about sublevel set
global max_Tbar;
global max_x2;
global max_x;
global max_x_dot;
global max_norm;

Xrange = [sls(1,j); sls(2,j)];
max_x2    = max(abs(sls(2,j)));
max_x     = max(norm(sls(1:2,j)));
max_x_dot = max(norm((A*Xrange + B*ctl(Xrange))));
max_norm  = max(vecnorm(Xrange));
delta = max(vecnorm(sls(1:2,:))); % Technically a diben specific parameter, but
                                  % easier to define here

end