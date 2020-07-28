k1  = 1;
k2  = 1;
A = [0, 1; 0, 0];
B = [0; 1];
K = [k1, k2];

A_hat = A-B*K;
P = lyap(A_hat, eye(2));