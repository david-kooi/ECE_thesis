function TBar = get_TBar_scaled(x_dot)
global max_x_dot;
global Ts_min;


% Normalize the norm
norm_x_dot = norm(x_dot);
x_dot_normalized = norm_x_dot/max_x_dot;

global cs;
T_max = 2;
T_min = Ts_min;
TBar = (T_max - T_min)*(1- x_dot_normalized).^cs + T_min;


%% Proportional  to x2
%max_Tbar = 0.64;
%getTBar = @(x) ((max_x2 - abs(x(2)))/max_x2)*max_Tbar + (1-(max_x2 - abs(x(2)))/max_x2)*(0.625);

%% Proportional to Norm of state
%T_max = 1;
%T_min = Ts_min;
%getTBar_scaled = @(x) ((max_x - norm(x))/max_x)*(T_max) + (1-(max_x - norm(x))/max_x)*(T_min);

%% Proportional to Norm of dynamics
% Old params
%T_max = 4;
%T_min = 0.7;

%T_max = 5;
%T_min = Ts_min;
%x_dot_o = norm(A*xo + B*ctl(xo));
%TBar = ((x_dot_o - norm(x_dot))/x_dot_o)*(T_max) + (1-(x_dot_o - norm(x_dot))/x_dot_o)*(T_min);
%TBar = ((max_x_dot - norm(x_dot))/max_x_dot)*(T_max) + (1-(max_x_dot - norm(x_dot))/max_x_dot)*(T_min);

%getTBar_scaled = @(x_dot) 



end