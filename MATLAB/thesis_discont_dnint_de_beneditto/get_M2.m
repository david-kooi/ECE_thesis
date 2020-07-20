function val = get_M2(x_o)

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
global lam_P_min;
global lam_P_max;
global lam_Q_min;
global M1;
global M2;
global state_grid;

global delta;
global a1; global a2; global a2_inv;
global a3; 
global a4;

V_val = V(x_o);

sls_xo = [];
for(x_vec = state_grid')
   if(V(x_vec) <= V_val)
    sls_xo = [sls_xo [x_vec; V(x_vec)]];
   end
end

if(isempty(sls_xo))
    val = 0;
else
    phi2 = 2.5*sls_xo(1,:) + 0.5*sls_xo(2,:);
    val = max(phi2);
end


end