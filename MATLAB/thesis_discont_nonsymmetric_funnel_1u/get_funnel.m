

function get_funnel()




%get_funnel_1();
%get_funnel_2();
get_funnel_3();
%get_funnel_4();

% Set alpha function with the funnel functions
global ctl;
global psi_1;
global psi_1_dot;
global psi_1_ddot;
global psi_2;
global psi_2_dot;
global psi_2_ddot;
global V;
global rho_1;
global rho_2;

global alpha;
alpha = @(t,x) (psi_1_dot(t) - ctl(t,x)).*rho_2(t,x) + (ctl(t,x) - psi_2_dot(t)).*rho_1(t,x) + ctl(t,x).*(rho_1(t,x) -rho_2(t,x));

end

function get_funnel_1()
global df;
global ctl;
global psi_1;
global psi_1_dot;
global psi_1_ddot;
global psi_2;
global psi_2_dot;
global psi_2_ddot;
global V;
global rho_1;
global rho_2;

%% Funnel Options
a = 2;
b = 1;
c = 3;
d = 0.5;
epsilon = 0.1;

psi_1      = @(t) (-a.*t.^2 + b).*exp(-t);
psi_1_dot  = @(t) -2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t);
psi_1_ddot = @(t) 4*a.*t.*exp(-t) - 2*a.*exp(-t) - (a.*t.^2 - b).*exp(-t);
psi_2      = @(t) (-a - c.*t.^2).*exp(-t) - epsilon;
psi_2_dot  = @(t) -2*c.*t.*exp(-t) - (-a - c.*t.^2).*exp(-t);
psi_2_ddot = @(t) 4*c.*t.*exp(-t) - 2*c.*exp(-t) - (a + c.*t.^2).*exp(-t);


V         = @(x)   x;
rho_1     = @(t,x) psi_1(t) - V(x);
rho_2     = @(t,x) V(x) - psi_2(t);
end

function get_funnel_2()
global df;
global ctl;
global psi_1;
global psi_1_dot;
global psi_1_ddot;
global psi_2;
global psi_2_dot;
global psi_2_ddot;
global V;
global rho_1;
global rho_2;

%% Funnel Options
a = 4;
b = 2;
c = 0.5;
d = 6;
f = -0.5;

epsilon = 0.05;

psi_1      = @(t) (-a.*t.^2 + b).*exp(-t);
psi_1_dot  = @(t) -2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t);
psi_1_ddot = @(t) 4*a.*t.*exp(-t) - 2*a.*exp(-t) - (a.*t.^2 - b).*exp(-t);
psi_2      = @(t) (-c - d.*(-f + t).^2).*exp(-t) -epsilon;
psi_2_dot  = @(t) -d.*(-2*f + 2*t).*exp(-t) - (-c - d.*(-f + t).^2).*exp(-t);
psi_2_ddot = @(t) 2*d.*(-2*f + 2*t).*exp(-t) - 2*d.*exp(-t) - (c + d.*(-f + t).^2).*exp(-t);


V         = @(x)   x;
rho_1     = @(t,x) psi_1(t) - V(x);
rho_2     = @(t,x) V(x) - psi_2(t);
end


function get_funnel_3()
global df;
global ctl;
global psi_1;
global psi_1_dot;
global psi_1_ddot;
global psi_2;
global psi_2_dot;
global psi_2_ddot;
global V;
global rho_1;
global rho_2;

%% Funnel Options
a = 4;
b = 2;
c = 3.5;
d = 0.1;

epsilon = 0;

psi_1      = @(t) (-a.*t.^2 + b).*exp(-t)+0.1;
psi_1_dot  = @(t) -2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t);
psi_1_ddot = @(t) 4*a.*t.*exp(-t) - 2*a.*exp(-t) - (a.*t.^2 - b).*exp(-t);
psi_2      = @(t) (-c - exp(-t)).*exp(-d.*t)-epsilon;
psi_2_dot  = @(t) -d.*(-c - exp(-t)).*exp(-d.*t) + exp(-t).*exp(-d.*t);
psi_2_ddot = @(t) d.^2.*(-c - exp(-t)).*exp(-d.*t) - 2*d.*exp(-t).*exp(-d.*t) - exp(-t).*exp(-d.*t);


V         = @(x)   x;
rho_1     = @(t,x) psi_1(t) - V(x);
rho_2     = @(t,x) V(x) - psi_2(t);
end

function get_funnel_4()
global df;
global ctl;
global psi_1;
global psi_1_dot;
global psi_1_ddot;
global psi_2;
global psi_2_dot;
global psi_2_ddot;
global V;
global rho_1;
global rho_2;

%% Funnel Options
a = -3;
b = 0;
c = 0;
d = -1;
f = -0.5;

epsilon = 0;

psi_1      = @(t) (a.*t.^2 + b.*t).*exp(-t)+1;
psi_1_dot  = @(t) (2*a.*t + b).*exp(-t) - (a.*t.^2 + b.*t).*exp(-t);
psi_1_ddot = @(t) 2*a.*exp(-t) + (-2*a.*t - b).*exp(-t) - (2*a.*t + b).*exp(-t) - (-a.*t.^2 - b.*t).*exp(-t);
psi_2      = @(t) (d.*t.^2 + f.*t).*exp(-t) - 1;
psi_2_dot  = @(t) (2*d.*t + f).*exp(-t) - (d.*t.^2 + f.*t).*exp(-t);
psi_2_ddot = @(t) 2*d.*exp(-t) + (-2*d.*t - f).*exp(-t) - (2*d.*t + f).*exp(-t) - (-d.*t.^2 - f.*t).*exp(-t);


V         = @(x)   x;
rho_1     = @(t,x) psi_1(t) - V(x);
rho_2     = @(t,x) V(x) - psi_2(t);
end


