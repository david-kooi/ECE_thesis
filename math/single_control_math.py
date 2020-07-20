from sympy import *
from sympy_utils.printing import *

# Symbols
gamma, rho1, rho2, psi1, psi2, f1, f2, d, x= symbols("gamma rho_1 rho_2 psi_1 psi_2 f_1 f_2 d_f x")
f1_dot, f2_dot = symbols("f1_dot f2_dot")
u, u_o, lam = symbols("u u_o lam")

# Place holders
dd_dt, dd_dx = symbols("dd_dt dd_dx")

## Evaluated formulas
rho1_f = psi1 - x
rho2_f = x - psi2

lam_f = (psi1 - x)/(psi1 - psi2)
u_f = (1-lam)*(f1-d) + lam*(f2 + d)

# Symbolic formulas 
alpha = f1*rho2 - f2*rho1 + u*(rho1-rho2) 
gamma = u_o*(rho1 - rho2) - u*(rho1 - rho2) 
rho_dot = alpha + gamma 

dlam_dt = (f1 - u)/(psi1-psi2) + (rho1*(f1-f2))/(psi1-psi2)**2  
dlam_dx = -1/(psi1-psi2)
du_dt = dlam_dt*(f2 - f2 + 2*d) + lam*(f2_dot + dd_dt) + (1-lam)*(f1_dot - dd_dt) 
du_dx = dlam_dx*(f2-f1) + dd_dx

dalpha_dt = f1_dot*rho2 - 2*f1*f2 - f2_dot*rho1 + u*(f1 - f2) + du_dt*(rho1 - rho2)
dalpha_dx = f1 + f2 - 2*u + du_dx*(rho1-rho2)

dgamma_dt = (f1 - f2)*(u_o - u) - du_dt*(rho1 - rho2)
dgamma_dx = -2*(u_o - u) - (rho1 - rho2)*du_dx


inner_alpha = dalpha_dt + dalpha_dx*u_o
inner_gamma = dgamma_dt + dgamma_dx*u_o


print_octave("inner_alpha", simplify(inner_alpha))
print_octave("inner_gamma", simplify(inner_gamma))



        
