function [Xrange, Trange, x_f] = get_reach_set_stepped(x_o, u_o, TBar)

global max_norm;
global V;
global V_sls_value;

% Compute next sampling time
options = odeset();
[Tout, Xrange] = ode45(@F_dynamic,[0 TBar], x_o, options, u_o);
x_f = Xrange(end, 1:2);

% Inflate the trajectory (The indexes of the nearest neighbors)
% Comment out below to use the perfect reach set. 
global r;

sparse_Xrange = [Xrange(1,:)];
sparse_Trange = [Tout(1)];
% Space out points before inflation
x_i = Xrange(1,:);
for(i_x = 1:length(Xrange))
    
    if(i_x < length(Xrange))
        x_i_p1 = Xrange(i_x+1,:);
        t_i_p1 = Tout(i_x+1);
        
        x_norm = norm(x_i - x_i_p1);
        if(x_norm > r)
            new_x = Xrange(i_x,:);
            new_t = Tout(i_x);
            
            x_i = new_x;
            
            sparse_Xrange = [sparse_Xrange; new_x];
            sparse_Trange = [sparse_Trange; new_t];
        else
            % Continue
        end
    end
end

% Remove all points out of bounds
idx = find(vecnorm(Xrange') < max_norm);
Xrange = Xrange(idx,:);
Tout   = Tout(idx);


%% Inflation of solution
reach_set = [];
for (i_x = 1:length(Xrange))
    x_i = Xrange(i_x,:);
    t_i = Tout(i_x);
    
    if(V(x_i') <= V_sls_value)
        
        %% Make a cirlce of radius r around the point
        N = 10; % 10 steps 
        d_theta = (2*pi)/N;
        for(n = 0:N)
            theta = n*d_theta;
            dx  = r*cos(theta);
            dy  = r*sin(theta);
            x_r = [x_i(1) + dx, x_i(2) + dy];
            reach_set = [reach_set; [x_r, t_i]];
        end

    else
        
        % Ignore all x s.t V(x) > V_sls_value
    end
end


Xrange = reach_set(:,1:2); % Change the name to make reachable set adaptation easier.
Trange = reach_set(:,3);

%figure(10);
%scatter(Xrange(:,1), Xrange(:,2));

end