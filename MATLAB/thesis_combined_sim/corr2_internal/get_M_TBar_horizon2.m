function [Mr, Ms,TBar] = get_M_TBar_horizon2(x_o, u_o)

global A;
global B;
global V;
global V_sls_value;
global ctl;

rho   = V_sls_value - V(x_o);
x_dot = A*x_o + B*u_o;

% Iterate through multiple values of TBar
global T_min;
global T_max;
global N;
delta = (T_max-T_min) / N;

[Xrange0, Trange0] = get_reach_set_stepped(x_o, u_o, T_max);

Ts_arr = zeros(N, N+1);
M_arr  = [];
for( n0 = 0:N-1)
   TBar0 = T_min + n0*delta;
   
   idx     = find((Trange0 < TBar0));
   subReach0 = Xrange0(idx, :);
   subTime0  = Trange0(idx,:);
   
%     figure(10);
%     scatter(subReach0(:,1), subReach0(:,2));  
   
   [M0_s, arg_M] = get_M(x_o, u_o, TBar0, subReach0, subTime0);
   
   Ts0     = get_Ts(x_o, M0_s, TBar0);
   Ts_arr(n0+1, 1) = Ts0; 
   M_arr = [M_arr; M0_s];
   
   %% Fill with expansion
   x_1 = arg_M';
   %x_1 = x_f0;
   
   u_1 = ctl(x_1);
   [Xrange1, Trange1] = get_reach_set_stepped(x_1, u_1, T_max);
   for(n1 = 0:N-1)
      TBar1 = T_min + n1*delta;
      
      idx = find(Trange1 < TBar1);
      subReach1 =  Xrange1(idx,:);
      subTime1  =  Xrange1(idx,:);
      
%       figure(10);
%       scatter(subReach1(:,1), subReach1(:,2));
%       hold on;
      
      M1_s  = get_M(x_1, u_1, TBar1, subReach1, subTime1);
      Ts1 = get_Ts(x_1, M1_s, TBar1);
      
      Ts_arr(n0+1, n1+2) = Ts1;
   end
   
   
end

% Performance = c*Ts0 + (1-c)Ts1, c \in [0,1]
global ch;
P = zeros(N);
for(n = 1:N)
   Ts0 = Ts_arr(n,1);
   P(n, :) = ch*Ts0 + (1-ch).*Ts_arr(n, 2:end);
    
end
[Ts_max, max_lin_idx] = max(P,[],'all','linear');
[max_r_idx, max_c_idx] = ind2sub([N N], max_lin_idx);


Ms   = M_arr(max_r_idx);
TBar = Ts_arr(max_r_idx,1); 

% Find Mr
Mr = get_Mr(x_o, u_o, TBar);


end