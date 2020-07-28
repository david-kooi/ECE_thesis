% Inputs: barT and T(Total time)
function Ts_xo = get_Ts_min(barT, T)
 
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


tspan = 0:0.01:T-barT;

Ts_xo_buffer = [];
Ts_xo = [];
    for(xo = V_sls_boundary) % For all x on bounary of sublevel set
        
        uo = ctl(xo);
        
        options = odeset();
        [Tout, Xrange] = ode45(@F_dynamic,[0 barT], xo, options, uo); 
        
        x1 = Xrange(:,1);
        x2 = Xrange(:,2);
        
        %figure(1);
        %plot(x1,x2);
        
        F_uo = (A*Xrange' + B*uo);
        
        % Gamma calc
        dg_dx1 = -0.25*x1 + 0.125*xo(1) - 0.5*xo(2);
        dg_dx2 = 0.5*xo(1) + 4*x2 - 2*xo(2);
        grad_gamma  = [dg_dx1, dg_dx2]';
        inner_gamma = dot(grad_gamma, F_uo);
        
        % Alpha calc
        da_dx1 = x1  + 0.5*x2;
        da_dx2 = 0.5*x1 + 3*x2;
        %da_dx1 = -2*lam_Q_min*x1;
        %da_dx2 = -2*lam_Q_min*x2;
        grad_alpha   = [da_dx1, da_dx2]';
        inner_alpha  = dot(grad_alpha, F_uo);
        
        
        M_gamma = max(inner_gamma);
        M_alpha = min(inner_alpha);
        
        M = M_alpha - M_gamma;
        
        if(M >= 0)
            Ts_xo_buffer = [Ts_xo_buffer barT];
        else
            alpha_f = alpha(xo);
            Ts_xo_buffer = [Ts_xo_buffer min(barT, -2*alpha_f/M)];
        end
    Ts_xo = [Ts_xo min(Ts_xo_buffer)];
    Ts_xo_buffer = [];
end


end