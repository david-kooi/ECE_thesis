function reach_set = inflate_points(Xrange, r)
    reach_set = [];
     for(x_i = Xrange)

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