function period = get_Ts_new(x_o, Mr, Ms, TBar)

global alpha;

if(Mr >= 0)
    Tr = TBar;
else
    Tr = min(TBar, -2*alpha(x_o)/Mr);
end


global V_sls_value;
global V;

rho = V_sls_value - V(x_o);
if(Ms <= 0)
    Ts = TBar;
else
    Ts = min(TBar, rho/Ms);
end

period = max(Tr, Ts);

end

