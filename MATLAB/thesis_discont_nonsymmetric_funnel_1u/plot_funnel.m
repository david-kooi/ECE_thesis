function plot_funnel()
global psi_1;
global psi_2;
global T;

tspan = 0:0.1:T;
figure();
plot(tspan, psi_1(tspan), 'k');
hold on;
plot(tspan, psi_2(tspan), 'k');

end