%% Funnel Options
a = 2;
b = 1;
c = 3;
d = 0.5;
psi_1     = @(t) (-a.*t.^2 + b).*exp(-t);
psi_1_dot = @(t) -2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t);
psi_2     = @(t) (-a - c.*t.^2).*exp(-t);
psi_2_dot = @(t) -2*c.*t.*exp(-t) - (-a - c.*t.^2).*exp(-t);

t = linspace(0,10,1000);

M_alpha = min(psi_1_dot(t) - psi_2_dot(t));
M_gamma = max(psi_2_dot(t) - psi_1_dot(t));

%plot(t, psi_1_dot(t) - psi_2_dot(t));
hold on 
%plot(t, psi_2_dot(t) - psi_1_dot(t));

M = M_alpha - M_gamma;
f = -2*(psi_1(t) - psi_2(t))/M;
T_s = min(f);