
%% Funnel Options
a = 2;
b = 1;
c = 3;
d = 0.5;
psi_1     = @(t) (-a.*t.^2 + b).*exp(-t);
psi_1_dot = @(t) -2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t);
psi_1_ddot = @(t) 4*a.*t.*exp(-t) - 2*a.*exp(-t) - (a.*t.^2 - b).*exp(-t);
psi_2     = @(t) (-a - c.*t.^2).*exp(-t);
psi_2_dot = @(t) -2*c.*t.*exp(-t) - (-a - c.*t.^2).*exp(-t);
psi_2_ddot = @(t) 4*c.*t.*exp(-t) - 2*c.*exp(-t) - (a + c.*t.^2).*exp(-t);
V         = @(x)   x;
rho_1     = @(t,x) psi_1(t) - V(x);
rho_2     = @(t,x) V(x) - psi_2(t);


%% Control
d       = @(t,x) 1;
u1      = @(t,x) psi_2_dot(t) + d(t,x);
u2      = @(t,x) psi_1_dot(t) - d(t,x);
lambda  = @(t,x) (psi_1(t) - x)./(psi_1(t) - psi_2(t));
ctl     = @(t,x)  (1-lambda(t,x)).* u2(t,x) + lambda(t,x).*u1(t,x);

dddt = 0;
dddx = 0;

alpha = @(t,x) (psi_1_dot(t) - ctl(t,x)).*rho_2(t,x) + (ctl(t,x) - psi_2_dot(t)).*rho_1(t,x) + ctl(t,x).*(rho_1(t,x) -rho_2(t,x));


barT = 1;
tspan = 0:0.01:20-barT;

Ts_xo = [];
for(to = tspan)
    xo = psi_1(to);
    uo = ctl(to,xo);
    Trange = to:0.01:to+barT;
    Xrange = Trange.*uo + xo;
    
    df     = d(Trange, Xrange); 
    psi1   = psi_1(Trange);
    psi2   = psi_2(Trange);
    rho1   = rho_1(Trange, Xrange);
    rho2   = rho_2(Trange, Xrange);
    f1     = psi_1_dot(Trange);
    f1dot = psi_1_ddot(Trange);
    f2     = psi_2_dot(Trange);
    f2dot = psi_2_ddot(Trange);
    u      = ctl(Trange, Xrange);
    lam    = lambda(Trange, Xrange);
    
    inner_alpha = df.*(f1 - f2) + (dddt + dddx.*uo).*(psi1 - psi2);
    inner_gamma = (2*df.*(rho1.*(f1 - f2) + (f1 - u).*(psi1 - psi2)) + (psi1 - psi2).^2.*(lam.*(dddt + f2dot) + (dddt - f1dot).*(lam - 1)) + (psi1 - psi2).*(uo.*(dddx.*(psi1 - psi2) + f1 - f2) + (f1 - f2).*(u - uo)))./(psi1 - psi2);

    M_gamma = max(inner_gamma);
    M_alpha = min(inner_alpha);
    M = M_alpha - M_gamma;
    
    if(M >= 0)
        Ts_xo = [Ts_xo barT];
    else
        Ts_xo = [Ts_xo min(barT, -2*alpha(to, xo)/M)];
    end
end

min(Ts_xo)

