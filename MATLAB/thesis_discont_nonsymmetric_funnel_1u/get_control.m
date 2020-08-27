function get_control()

global psi_1;
global psi_1_dot;
global psi_2;
global psi_2_dot;
global V;
global rho_1;
global rho_2;

global ctl;
global u1; global u2; 
global lambda;
global d_f; 
global dddt_f;
global dddx_f;



%% Control Options
%d_f = @(t,x) 1./(psi_1(t) - psi_2(t));
%dddt_f = @(t,x) -(psi_1_dot(t) - psi_2_dot(t))./(psi_1(t) - psi_2(t)).^2;
%dddx_f = @(t,x) 0; 

% Constant d
d_f = @(t,x) 0.4;
dddt_f = @(t,x) 0;
dddx_f = @(t,x) 0; 

% Vaninishing d
% d_f = @(t,x) 1./(t+0.1) +0.1;
% dddt_f = @(t,x) - 1./(t.^2);
% dddx_f = @(t,x) 0; 

% d as funnel distance
% df = @(t,x) psi_1(t) - psi_2(t);
% dddt_f = @(t,x) psi_1_dot(t) - psi_2_dot(t);
% dddx_f = @(t,x) 0; 


% d as derivative of funnel distance
%df = @(t,x) (1/2)*(psi_1_dot(t) - psi_2_dot(t)).^2;
%dddt = @(t,x) (psi_1_dot(t) - psi_2_dot(t))*(psi_1_ddot(t) - psi_2_ddot(t));
%dddx = @(t,x) 0; 


% Constant d
%df      = @(t,x) 0.25; 
%dddt_f     = @(t,x) 0;
%dddx_f     = @(t,x) 0;


u1        = @(t,x) psi_1_dot(t) - d_f(t,x);
u2        = @(t,x) psi_2_dot(t) + d_f(t,x);
lambda    = @(t,x) (psi_1(t) - x)/(psi_1(t) - psi_2(t));
ctl       = @(t,x)  (1-lambda(t,x)) * u1(t,x) + lambda(t,x)*u2(t,x);


end