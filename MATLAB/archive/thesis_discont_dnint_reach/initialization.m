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
global lam_Q_min;


global ctl;

ellipsoids_init();

% Lyapunov function
A = [0, 1; -2, 3];
B = [0; 1];
K = [1, -4];
%A_c = A-B*K;

ctl = @(x) K*x;


Q = [0.5, 0.25; 0.25, 1.5];
P = [1, 0.25; 0.25, 1];
lam_Q_min = min(eig(Q));

V = @(x) x'*P*x;
V_sls_value = 0.1;

% Get the subevel set and it's boundary
x1 = linspace(-0.5,0.5,100);
x2 = linspace(-0.5,0.5,100);
[X1,X2] = meshgrid(x1,x2);
x1 = X1(:); x2 = X2(:);
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
plot3(sls(1,j),sls(2,j),sls(2,j)*0 + V_sls_value);
xlabel("x_1"); ylabel("x_2");
hold on;

%alpha = @(x) lam_Q_min.*(x(1).^2 + x(2).^2);

% Matrix Form
alpha = @(x) x'*Q*x;
gamma = @(x,e) 0.5*x'*P*B*K*e;

% Explicit Form
%alpha = @(x1,x2) x1.*(0.5*x1 + 0.25*x2) + x2.*(0.25*x1 + 1.5*x2)
%gamma = @(x1,x2,xo1,xo2)  (-x1 + xo1).*(0.125*x1 + 0.5*x2) + (-0.5*x1 - 2.0*x2).*(-x2 + xo2);




end