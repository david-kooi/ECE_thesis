function initialization()

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
global lam_P_min;
global lam_P_max;
global lam_Q_min;
global M1;
global M2;
global state_grid;

global delta;
global a1; global a2; global a2_inv;
global a3; 
global a4;


global ctl;

% Lyapunov function
A = [0, 1; -2, 3];
B = [0; 1];
K = [1, -4];
%A_c = A-B*K;

ctl = @(x) K*x;


Q = [0.5, 0.25; 0.25, 1.5];
P = [1, 0.25; 0.25, 1];
lam_P_max = max(eig(P));
lam_P_min = min(eig(P));
lam_Q_min = min(eig(Q));

a1 = @(c) lam_P_min*c^2;
a2 = @(c) lam_P_max*c^2;
a2_inv = @(c) sqrt(c/lam_P_max);
a3 = @(c) lam_Q_min*c^2;
a4 = @(c) lam_P_max*c;


V = @(x) x'*P*x;
V_sls_value = 0.1;

% Get the subevel set and it's boundary
x1 = linspace(-0.5,0.5,100);
x2 = linspace(-0.5,0.5,100);
[X1,X2] = meshgrid(x1,x2);
x1 = X1(:); x2 = X2(:);
x = [x1, x2]';
state_grid = [x1,x2];

global sls;
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
plot3(sls(1,j),sls(2,j),sls(2,j)*0 + V_sls_value);
xlabel("x_1"); ylabel("x_2");
hold on;

delta = max(vecnorm(sls(1:2,:)));


% M1 is function, updated every sample time
M1 = @(x) abs(-4*x(1) - 5*x(2));

% M2 is constant (Should be function, but then we need to compute sls 
% At each sample point. Doable, but going to try worst case first.

% Worst case M2
%phi2 = 2.5*sls(1,:) + 0.5*sls(2,:);
%max_phi2 = max(abs(phi2));
%M2 = @(x) max_phi2;

M2 = @(x_o) get_M2(x_o);


end