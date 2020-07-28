

function x_dot = F_dynamic(t,x,u_app)
global A;
global B;
global P;
global Q;
global K;

x_dot = A*x + B*u_app;
end