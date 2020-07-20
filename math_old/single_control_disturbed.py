from sympy import * 
from sympy_utils.printing import *

x, t = symbols("x t")
x_h, t_h = symbols("x_h t_h")

psi1, psi2 = symbols("psi1 psi2")
f1, f2, u, u_o = symbols("f1 f2 u_o")
f1_dot, f2_dot, df = symbols("f1_h f2_h df")
dd_dt, dd_dx = symbols("dddt dddx")

rho1 = psi1 - x
rho2 = x - psi2

lam = (x - psi1)/(psi1 - psi2)

u     = lam*(f2 + df) + (1-lam)*(f1 - df) 
alpha = f1*rho2 - f2*rho1 + u*(rho1-rho2) 
lamma = (rho1 - rho2)*(u_o - u)


dlam_dt = ((f1-u)*(psi1-psi2)+(psi1-x)*(f1-f2))/(psi1-psi2)**2
dlam_dx = -1/(psi1-psi2)

du_dt = dlam_dt*(f2 - f1) + 2*df) + lam*(f2_dot + dd_dt) + (1-lam)*(f1_dot -dd_dt)
du_dx = dlam_dx*(f2-f1) + dd_dx 

dalpha_dt = f1_dot*rho2 + f1*f2 - f2_dot*rho1 - f1*f2 + u*




print_math("rho_dot", simplify(rho_dot))
print_math("rho_dot_subs", simplify(rho_dot_subs))



