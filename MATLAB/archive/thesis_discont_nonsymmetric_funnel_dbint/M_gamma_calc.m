clear all;
close all;

%% Funnel Options
a = 2;
b = 1;
c = 3;
d = 0.5;
psi_1     = @(t) (-a.*t.^2 + b).*exp(-t);
psi_1_dot = @(t) -2*a.*t.*exp(-t) - (-a.*t.^2 + b).*exp(-t);
psi_1_ddot = @(t) 4*a.*t.*exp(-t) - 2*a.*exp(-t) - (a.*t.^2 - b).*exp(-t);
psi_2     = @(t) (-a - c.*t.^2).*exp(-t) - 0.05;
psi_2_dot = @(t) -2*c.*t.*exp(-t) - (-a - c.*t.^2).*exp(-t);
psi_2_ddot = @(t) 4*c.*t.*exp(-t) - 2*c.*exp(-t) - (a + c.*t.^2).*exp(-t);
V         = @(x)   x;
rho_1     = @(t,x) psi_1(t) - V(x);
rho_2     = @(t,x) V(x) - psi_2(t);


%% Control
d       = @(t,x) 0.25; 
dddt = 1;
dddx = 0;

u1      = @(t,x) psi_1_dot(t) - d(t,x);
u2      = @(t,x) psi_2_dot(t) + d(t,x);
lambda  = @(t,x) (psi_1(t) - x)/(psi_1(t) - psi_2(t));
ctl     = @(t,x)  (1-lambda(t,x)) * u1(t,x) + lambda(t,x)*u2(t,x);




alpha = @(t,x) psi_1_dot(t).*rho_2(t,x) - psi_2_dot(t).*rho_1(t,x) + ctl(t,x).*(rho_1(t,x) - rho_2(t,x));


barT = 1;
tspan = 0:0.01:20-barT;

figure(1);
plot(tspan, psi_1(tspan));
hold on
plot(tspan, psi_2(tspan));


Ts_xo = [];
Ts_xo_buffer = [];
for(to = tspan)
    for(xo = [psi_1(to), psi_2(to)])
        
        uo = ctl(to,xo);
        Trange = to:0.01:to+barT;
        Xrange = (0:0.01:barT).*uo + xo;
        
        %figure(1);
        %plot(Trange, Xrange);
        
        df     = d(Trange, Xrange);
        psi1   = psi_1(Trange);
        psi2   = psi_2(Trange);
        rho1   = rho_1(Trange, Xrange);
        rho2   = rho_2(Trange, Xrange);
        f1     = psi_1_dot(Trange);
        f1dot  = psi_1_ddot(Trange);
        f2     = psi_2_dot(Trange);
        f2dot  = psi_2_ddot(Trange);
        u      = ctl(Trange, Xrange);
        lam    = lambda(Trange, Xrange);
        x = Xrange;
               
        
        inner_gamma = ((psi1 - psi2).*(-uo.*((psi1 - psi2).*(uo.*(psi1 - psi2) + (df - f1).*(-psi2 + x) - (df + f2).*(psi1 - x)) + (psi1 + psi2 - 2*x).*(dddx.*(psi1 - psi2) + f1 - f2)) + (f1 - f2).*(uo.*(psi1 - psi2) + (df - f1).*(-psi2 + x) - (df + f2).*(psi1 - x))) - ((psi1 - psi2).*(-(dddt - f1dot).*(-psi2 + x) + (dddt + f2dot).*(psi1 - x)) + (2*df - f1 + f2).*(f1.*(psi1 - psi2) + (df - f1).*(-psi2 + x) - (df + f2).*(psi1 - x) + (f1 - f2).*(psi1 - x))).*(psi1 + psi2 - 2*x))./(psi1 - psi2).^2;     
        inner_alpha = (uo.*(2*(df - f1).*(-psi2 + x) - 2*(df + f2).*(psi1 - x) + (f1 + f2).*(psi1 - psi2) + (psi1 + psi2 - 2*x).*(dddx.*(psi1 - psi2) + f1 - f2)) - (f1 - f2).*((df - f1).*(-psi2 + x) - (df + f2).*(psi1 - x)) - (psi1 - psi2).*(2*f1.*f2 + f1dot.*(psi2 - x) + f2dot.*(psi1 - x)))./(psi1 - psi2);
        
        M_gamma = max(inner_gamma);
        M_alpha = min(inner_alpha);
        
        M = M_alpha - M_gamma;
        
        
        if(M >= 0)
            Ts_xo_buffer = [Ts_xo_buffer barT];
        else
            alpha_f = alpha(to,xo);
            Ts_xo_buffer = [Ts_xo_buffer min(barT, -2*alpha_f/M)];
        end
    end
    Ts_xo = [Ts_xo min(Ts_xo_buffer)];
    Ts_xo_buffer = [];
end


figure(2);
plot(Ts_xo);
title("Ts(x_o)")

figure(3);
plot(alpha(tspan, psi_2(tspan)));
title("\alpha(t,x)");

min_Ts_xo = min(Ts_xo)

