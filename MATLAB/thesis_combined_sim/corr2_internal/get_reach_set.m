function Xrange = get_reach_set_stepped(x_o, u_o, TBar)

global state_grid;

% Compute next sampling time
options = odeset();
[Tout, Xrange] = ode45(@F_dynamic,[0 TBar], x_o, options, u_o);

%figure(10);
%scatter(Xrange(:,1), Xrange(:,2));


% Inflate the trajectory (The indexes of the nearest neighbors)
% Comment out below to use the perfect reach set. 
r = 0.025;

sparse_Xrange = [];
sparse_Trange = [];
% Space out points before inflation


reach_set = [];

IDX = rangesearch(state_grid, Xrange, r);
for(i = 1:length(IDX))
    grid_idx = IDX(i);
    grid_idx = grid_idx{1};
    grid_points = state_grid(grid_idx, :);
    num_points = length(grid_points(:,1));
    reach_set = [reach_set; grid_points];
end


Xrange = reach_set;
end