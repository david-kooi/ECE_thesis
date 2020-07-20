from sympy import *
from sympy_utils.printing import *


psi1, psi2, f1, f2, f1_dot, f2_dot = symbols("psi_1(t) psi_2(t) psi_1_dot(t) psi_2_dot(t) f1_dot f2_dot")
x, d, dd_dt, dd_dx= symbols("x df dd_dt dd_dx")
u_o, lam = symbols("u_o lambda")

f1_o, f2_o, d_o, lam_o = symbols("f1_o f2_o d_o lambda_o")

rho1 = psi1 - x
rho2 = x - psi2

lam_f = (psi1-x)/(psi1-psi2) 

u     = lam*(f2+d) + (1-lam)*(f1-d)

dlam_dt = ( (f1-u)*(psi1-psi2) + (psi1-x)*(f1-f2))/(psi1-psi2)**2
dlam_dx = -1/(psi1-psi2)


du_dt = dlam_dt*(f2-f1+2*d) + lam*(f2_dot + dd_dt) + (1-lam)*(f1_dot - dd_dt) 
du_dx = dlam_dx*(f2-f1)+dd_dx 



# Gamma
gamma   = (rho1 - rho2)*(u_o - u)
dgam_dt = (f1-f2)*(u_o-u) - du_dt*(rho1 - rho2)
dgam_dx = (psi2 - psi1)*(u_o - u) - du_dx*(rho1 - rho2)

inner_gamma = dgam_dt + dgam_dx*u_o
inner_gamma = inner_gamma.subs([(lam, lam_f)]) 

# Alpha
alpha = f1*rho2 - f2*rho1 + u*(rho1-rho2)

dalpha_dt = f1_dot*rho2 - 2*f1*f2 - f2_dot*rho1 + u*(f1-f2)
dalpha_dx = f1 + f2 + du_dx*(rho1 - rho2) - 2*u

inner_alpha = dalpha_dt + dalpha_dx*u_o
inner_alpha = inner_alpha.subs([(lam, lam_f)]) 


print_octave("du_dt", simplify(du_dt))
print_octave("du_dx", simplify(du_dx))
print_math("dgam_dt", simplify(dgam_dt))
print_math("dgam_dx", simplify(dgam_dx))
print_octave("inner_gamma", simplify(inner_gamma))
print_octave("inner_alpha", simplify(inner_alpha))



