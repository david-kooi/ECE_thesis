% Gets Ms for Theorem 1 sampling

function [M,arg_M] = get_M(x_o, u_o, TBar, Xrange, ~)

global A;
global B;
global V;

% If Xrange is not provided, compute a non-iterated reach set
if ~exist('Xrange','var') || isempty(Xrange)
    Xrange = get_reach_set(x_o, u_o, TBar);
end

F_u = (A*Xrange' + B*u_o);

x1_reach = Xrange(:,1);
x2_reach = Xrange(:,2);
%alpha_val = alpha(x1_reach, x2_reach);
%gamma_val = gamma(x1_reach, x2_reach, x1_reach*0 + x1, x2_reach*0 + x2);

drho_dx1 = -2*x1_reach - 0.5*x2_reach;
drho_dx2 = -0.5*x1_reach - 2*x2_reach;
grad_rho =  -[drho_dx1, drho_dx2];

V_val = V(x_o);
inner_rho = dot(grad_rho', F_u);
[M, arg_M_idx] = max(inner_rho);

arg_M = Xrange(arg_M_idx,:);
%plot(arg_M(1), arg_M(2), 'r*');
%hold on;

end