% Inputs: barT and T(Total time)
function Ts_xo = get_Ts(barT, T)
 
global alpha;

global d_f;
global ctl;
global u1; global u2; global lambda;
global dddt_f;
global dddx_f;

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


tspan = 0:0.01:T-barT;


Ts_xo_buffer = [];
Ts_xo = [];
for(to = tspan)
    for(xo = [psi_1(to), psi_2(to)])
        
        uo = ctl(to,xo);
        Trange = to:0.1:to+barT;
        Xrange = (0:0.1:barT).*uo + xo;

        % Do inflation of reach set
        reachableSet = [Trange; Xrange];
        % Inflate the solution
        r = 0.25;
        Xrange = inflate_points(reachableSet, r);
      
        Trange = Xrange(:,1)';
        Xrange = Xrange(:,2)';

        
        %figure(1);
        %plot(Trange, Xrange);
        
        df     = d_f(Trange, Xrange);
        dddt   = dddt_f(Trange, Xrange);
        dddx   = dddx_f(Trange, Xrange);
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
        
        inner_gamma = -(-uo.*(psi1 - psi2).*(2*(psi1 - psi2).*(u - uo) - (rho1 - rho2).*(dddx.*(psi1 - psi2) + f1 - f2)) + (f1 - f2).*(psi1 - psi2).^2.*(u - uo) + (rho1 - rho2).*(2*df.*(rho1.*(f1 - f2) + (f1 - u).*(psi1 - psi2)) + (psi1 - psi2).^2.*(lam.*(dddt + f2dot) + (dddt - f1dot).*(lam - 1))))./(psi1 - psi2).^2;
        inner_alpha = (uo.*(psi1 - psi2).*((psi1 - psi2).*(f1 + f2 - 2*u) + (rho1 - rho2).*(dddx.*(psi1 - psi2) + f1 - f2)) + (psi1 - psi2).^2.*(f1dot.*rho2 - f2dot.*rho1 - 2*f1.*f2 + u.*(f1 - f2)) + (rho1 - rho2).*(2*df.*(rho1.*(f1 - f2) + (f1 - u).*(psi1 - psi2)) + (psi1 - psi2).^2.*(lam.*(dddt + f2dot) + (dddt - f1dot).*(lam - 1))))./(psi1 - psi2).^2;
        
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


end