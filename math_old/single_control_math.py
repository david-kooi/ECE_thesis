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

# M_alpha when x = psi1 or x = psi2
M_alpha = (psi1-psi2)*(dd_dt + u_o*dd_dx) + (f1 - f2)*d

# M_gamma when x = psi1
M_gamma1 = (f2 - f1)*(u-u_o) + du_dt*(psi2-psi1) + u_o*du_dx*(psi2-psi1)

# M_gamma when x = psi2
M_gamma2 = (f2 - f1)*(u_o-u) + du_dt*(psi1-psi2) + u_o*du_dx*(psi1-psi2)



# Substitutions
#rho_dot = rho_dot.subs([(rho1, rho1_f), (rho2, rho2_f)])


print_math("rho_dot", rho_dot)
print_octave("M_alpha", simplify(M_alpha))
print_octave("M_gamma1", simplify(M_gamma1))
print_octave("M_gamma2", simplify(M_gamma2))
        
