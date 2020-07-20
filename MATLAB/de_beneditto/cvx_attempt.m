k1 = 1;
k2 = 2;
x1_0 = 10;
x2_0 = 1;
x0 = [x1_0; x2_0];

P = [1.5, -0.5; -0.5, 1.0];
t_k = 0;

M1 = 1;

cvx_begin
variable x(2);

M2 = k1*k2*x(2) - k1*(k1*x(1) + k2*x(2)) + k2^2*(k1*x(1) + k2*x(2));
maximize(M2);
norm(x) < quad_form(x0, P);
cvx_end

M2 = abs(M2);


cvx_begin
variable Ts;

maximize(Ts);

M1*Ts + M2*square(Ts) < 10;

cvx_end