x1_arr = x(:,2);
x2_arr = x(:,3);
u_arr  = x(:,4);
Ts_arr = x(:,6);
mean(Ts_arr)

% Get Signal L2 norm
x_data = [x1_arr, x2_arr];
L2 = sqrt(trapz(vecnorm(x_data).^2));

data.t = t;
data.j = j;
data.Ts_arr = Ts_arr;



% Plot state
figure(11);
modF{1} = 'm';

modJ{1} = 'm';
modJ{2} = 'Marker';
modJ{3} = '.';

plotHarc(t,j,x(:,2), [], modF, modJ);
xlabel("Time(s)");
ylabel("x_1");
set(gca, 'FontName', 'Times New Roman');
set(gcf,'Position',[100 100 500 200]);
hold on;

% Sample period plot
figure(12);
modF{1} = 'm';

modJ{1} = 'm';
modJ{2} = 'Marker';
modJ{3} = '.';


plotHarc(t,j,x(:,6), [0,j(end)], modF, modJ);
xlabel("Time(s)");
ylabel("Sample Period (s)");
set(gca, 'FontName', 'Times New Roman');
set(gcf,'Position',[100 100 500 200]);
hold on;


% % plot solution
 figure() % position
 clf
 subplot(2,1,1), plotHarc(t,j,x(:,2));
 hold on;
 xlabel("Time (s)");
 ylabel("x");
 subplot(2,1,2), plotHarc(t,j,x(:,6));
 grid on
 ylabel('Sample Period(s)');
 xlabel("Time(s)");
 
 figure(10);
 plot(x1_arr, x2_arr);

%figure(2);
%plot(t,df(t));
%hold on;

%figure(3);
%plot(t, u_arr);

%figure(4);
%bar(Ts_arr);


% figure(2);
% plot(t,psi(t,0));
% 
% 
% % plot hybrid arc
 figure(6)
 plotHybridArc(t,j,x(:,2));
 xlabel('j')
 ylabel('t')
 zlabel('x1')
