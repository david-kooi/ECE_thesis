function period = get_Ts_new(x_o, Mr, Ms, TBar)
global alpha;

t  = x_o(1);
x1 = x_o(2);



if(Mr >= 0)
    Tr = TBar;
else
    Tr = min(TBar, -2*alpha(t, x1)/Mr);
end


global rho_1; global rho_2;
rho = rho_1(t,x1)*rho_2(t,x1);
if(Ms <= 0)
    Ts = TBar;
else
    Ts = min(TBar, rho/Ms);
end

period = max(Tr, Ts);

end

