function val = get_M2(x_o)

global V;
global state_grid;

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