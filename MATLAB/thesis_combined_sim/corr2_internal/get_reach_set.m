function Xrange = get_reach_set_stepped(x_o, u_o, TBar)

global V;
global V_sls_value;
global state_grid;

% Compute next sampling time
options = odeset();
[Tout, Xrange] = ode45(@F_dynamic,[0 TBar], x_o, options, u_o);

%figure(10);
%scatter(Xrange(:,1), Xrange(:,2));


% Inflate the trajectory (The indexes of the nearest neighbors)
% Comment out below to use the perfect reach set. 
global r;
sparse_Xrange = [];
sparse_Trange = [];

reach_set = [];

% IDX = rangesearch(state_grid, Xrange, r);
% for(i = 1:length(IDX))
%     grid_idx = IDX(i);
%     grid_idx = grid_idx{1};
%     grid_points = state_grid(grid_idx, :);
%     num_points = length(grid_points(:,1));
%     reach_set = [reach_set; grid_points];
% end
for (i_x = 1:length(Xrange))
    x_i = Xrange(i_x,:);
    
    if(V(x_i') <= V_sls_value)
        
        %% Make a cirlce of radius r around the point
        N = 10; % 10 steps
        d_theta = (2*pi)/N;
        for(n = 0:N)
            theta = n*d_theta;
            dx  = r*cos(theta);
            dy  = r*sin(theta);
            x_r = [x_i(1) + dx, x_i(2) + dy];
            reach_set = [reach_set; x_r];
        end
    end
end

Xrange = reach_set;
end