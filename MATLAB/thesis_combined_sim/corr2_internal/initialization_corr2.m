% ------------------
% University of California Santa Cruz
% Hybrid Systems Lab
% Masters Thesis 2020
% David Kooi
% ------------------

function initialization_corr2(in_T_min, in_T_max, in_r, in_N, in_cs, in_ch, in_TBar_method)

%% Tunable parameters
global T_min; global T_max; % Min, max times of reachable set
global r; % Radius of inflation for reachable set
global N; % Number of horizon steps for TBar Horizion 
global cs; % Scaling factor for scaled TBar
global ch; % Weight factor for horizion TBar
global TBar_method; % 0: Scaled TBar
                    % 1: 2-Step Horizion TBar

T_min = in_T_min; T_max = in_T_max;
r = in_r;
N = in_N;
cs = in_cs;
ch = in_ch;
TBar_method = in_TBar_method;

%% Robustness Functions
global Q;
global alpha;
global gamma;

% Matrix Form
alpha = @(x) x'*Q*x;
gamma = @(x,e) 0.5*x'*P*B*K*e;



end