function xplus = g_m(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: g_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Jump map
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
global ctl;
global psi_1;
global psi_1_dot;
global psi_2;
global psi_2_dot;
global V;
global rho_1;
global rho_2;
global u1; global u2; global lambda;
global df;

global barT;
global Ts_min;
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


% State: x = [t x1 tau u Ts]
t    = x(1);
x1   = x(2);
tau  = x(3);
u    = x(4);
Ts   = x(5);







%% Compute Mr
        % Setup initial conditions
        uo = ctl(t, x1);
        xo = x1;

        Trange = t:0.01:t+barT;
        Xrange = (0:0.01:barT).*uo + xo;
    
        reachableSet = [Trange; Xrange];
        % Inflate the solution
        r = 0.25;
        Xrange = inflate_points(reachableSet, r);
      
        Trange = Xrange(:,1)';
        Xrange = Xrange(:,2)';
%        figure(1);
%        plot(Trange, Xrange);
        
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

        Mr = M_alpha - M_gamma;
        



%% Compute Ms
inner_rho = -(f1.*rho2 - f2.*rho1 + u.*(rho1 - rho2));
Ms = max(inner_rho);

rho = rho_1(t,x1)*rho_2(t,x1);


% New sampling function
Ts_plus = get_Ts_new([t;xo], Mr, Ms, barT);

% Old sampling function
%Ts_plus = max(Ts_min, min(barT, rho/Ms));





xplus = [t; x1; 0; uo; Ts_plus];

global T_arr;
global Ts_arr;
T_arr = [T_arr t];
Ts_arr = [Ts_arr Ts_plus];
end