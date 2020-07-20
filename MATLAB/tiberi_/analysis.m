x1 = linspace(0,2.5,50);
x2 = linspace(0,2.5,50);

[X1, X2] = meshgrid(x1,x2);


%% Funnel Options
alpha  = 3;
lambda = 0.1;

psi = lambda+alpha;

%% Control
u = @(x1,x2) min(-x1./(psi-x1).^2 -x2./(psi-x2),1);

%f_norm = @(x1,x2) sqrt(x1.^2 + u(x1,x2)^2);
%Z = surf(X1,X2,f_norm(X1,X2));

%%
f1 = @(x1,x2,t) x2;
Z  = surf(X1,X2,u(X1,X2));
[Fx1, Fx2] = gradient(u(X1,X2));
max(-Fx1(:))
max(-Fx2(:));


