function [Mr, Ms,TBar] = get_M_TBar_horizon2(x_o, u_o)

global A;
global B;
global V;
global V_sls_value;
global ctl;
global ch;

rho   = V_sls_value - V(x_o);
x_dot = A*x_o + B*u_o;

% Iterate through multiple values of TBar
global T_min;
global T_max;
global N;
delta = (T_max-T_min) / N;

[Xrange0, Trange0] = get_reach_set_stepped(x_o, u_o, T_max);

Ts_arr = zeros(N, N+1);
J_arr  = [];
for( n0 = 0:N-1)
   TBar0 = T_min + n0*delta;
   J_n = 0;
   
   idx     = find((Trange0 < TBar0));
   subReach0 = Xrange0(idx, :);
   subTime0  = Trange0(idx,:);
   
    % figure(10);
    % scatter(subReach0(:,1), subReach0(:,2));  
   
   % New computation with max{Tr, Ts}
   [M0_s, arg_M] = get_M(x_o, u_o, TBar0, subReach0, subTime0);
   M0_r = get_Mr(x_o, u_o, TBar0, subReach0);
 
   T0 = get_Ts_new(x_o, M0_r, M0_s, TBar0); 
   
   %% Fill with expansion
   %x_1 = arg_M';
   options = odeset();
   [Tout, sol] = ode45(@F_dynamic,[0 T0], x_o, options, u_o);
   x_1 = sol(end, 1:2)';
   
   u_1 = ctl(x_1);
   [Xrange1, Trange1] = get_reach_set_stepped(x_1, u_1, T_max);
   for(n1 = 0:N-1)
      TBar1 = T_min + n1*delta;
      
      idx = find(Trange1 < TBar1);
      subReach1 =  Xrange1(idx,:);
      subTime1  =  Xrange1(idx,:);
      
      % figure(10);
      % scatter(subReach1(:,1), subReach1(:,2));
      % hold on;

      [M1_s, arg_M] = get_M(x_1, u_1, TBar1, subReach1, subTime1);
      M1_r = get_Mr(x_1, u_1, TBar1, subReach1);
      T1 = get_Ts_new(x_1, M1_r, M1_s, TBar1);

      J = ch*T0 + (1-ch).*T1;
      if(J > J_n)
         J_n = J;
      end
   end

J_arr = [J_arr, J_n];
end

[max_J, idx_J] = max(J_arr);

TBar = T_min + (idx_J-1)*delta;
Mr = get_Mr(x_o, u_o, TBar);
Ms = get_M(x_o, u_o, TBar);

end