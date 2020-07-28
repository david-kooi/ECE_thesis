function initialization_diben(in_v)

global v;
v = in_v;

global lam_P_min;
global lam_P_max;
global lam_Q_min;

global a1; global a2; global a2_inv;
global a3; 
global a4;

global M1; global M2;

a1 = @(c) lam_P_min*c^2;
a2 = @(c) lam_P_max*c^2;
a2_inv = @(c) sqrt(c/lam_P_max);
a3 = @(c) lam_Q_min*c^2;
a4 = @(c) lam_P_max*c;

% M1 is function, updated every sample time
M1 = @(x) abs(-4*x(1) - 5*x(2));
M2 = @(x_o) get_M2(x_o);



end