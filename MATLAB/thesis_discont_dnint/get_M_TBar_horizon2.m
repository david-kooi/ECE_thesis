function [M,TBar] = get_M_TBar_horizon(x_o, u_o)

global A;
global B;
global TBar_arr;
global V;
global Ts_min;
global V_sls_value;

rho = V_sls_value - V(x_o);
x_dot = A*x_o + B*u_o;

% Iterate through multiple values of TBar
T_max = 3;
T_min = 0.1;
%T_min = get_TBar_scaled(x_dot);


N = 1000;
delta = (T_max-T_min) / N;

[Xrange, Trange] = get_reach_set_stepped(x_o, u_o, T_max);



M_arr = [];
for( n = 0:N)
   TBar = T_min + n*delta;
   
   idx     = find((Trange < TBar));
   
   subReach = Xrange(idx, :);
   subTime  = Trange(idx,:);
   
   %figure(10);
   %scatter(subReach(:,1), subReach(:,2));
   
   M = get_M(x_o, u_o, TBar, subReach, subTime);
   %M = get_M(x_o, u_o, TBar);
   
   M_arr = [M_arr [M;TBar]];
end



% Minimize positive M
posM_idx = find(M_arr(1,:) > 0);
posM = M_arr(1,posM_idx);
[min_posM, min_posM_idx] = min(posM);

min_posM_dup_idx = find(M_arr(1,:) == min_posM); % Find best duplicate

[max_posM_TBar, max_posM_TBar_idx] = max(M_arr(2, min_posM_dup_idx));


M = min_posM;
TBar = max_posM_TBar;

Ts_plus = max(Ts_min, min(TBar, rho/M)) ;

%% Minimize M
%M_min = min(M_arr(1,:));
%M_min_idx = find(M_arr(1,:) == M_min);
%[TBar_max, TBar_max_idx] = max(M_arr(2,M_min_idx));

%M = M_arr(1,TBar_max_idx);
%TBar = TBar_max;


%% Maximize the sample time

% rho_M = rho./M_arr(1,:);
% Ts_arr = [M_arr(2,:); rho_M];
% 
% th1_min = min(Ts_arr, [], 1);
% Ts = [th1_min ; zeros(1,length(th1_min)) + Ts_min];
% [max_Ts, max_idx] = max(max(Ts));
% 
% M = M_arr(1,max_idx);
% TBar = M_arr(2,max_idx);






end