% Gets Mr 

function [Mr,arg_M] = get_Mr(xo, u_o, TBar, Xrange)

global A;
global B;

% If Xrange is not provided, compute a non-iterated reach set
if ~exist('Xrange','var') || isempty(Xrange)
    Xrange = get_reach_set(xo, u_o, TBar);
end

F_u = (A*Xrange' + B*u_o);

x1_reach = Xrange(:,1);
x2_reach = Xrange(:,2);

% Gamma calc
dg_dx1 = -0.25*x1_reach + 0.125*xo(1) - 0.5*xo(2);
dg_dx2 = 0.5*xo(1) + 4*x2_reach - 2*xo(2);
grad_gamma  = [dg_dx1, dg_dx2]';
inner_gamma = dot(grad_gamma, F_u);

% Alpha calc
da_dx1 = x1_reach  + 0.5*x2_reach;
da_dx2 = 0.5*x1_reach + 3*x2_reach;
%da_dx1 = -2*lam_Q_min*x1;
%da_dx2 = -2*lam_Q_min*x2;
grad_alpha   = [da_dx1, da_dx2]';
inner_alpha  = dot(grad_alpha, F_u);


M_gamma = max(inner_gamma);
M_alpha = min(inner_alpha);

Mr = M_alpha - M_gamma;



end