import sympy
from sympy import *

init_printing()

x_1, x_2, psi, psi_dot, A, t, gamma, u= symbols("x_1 x_2 psi psi_dot A t gamma u")

rho_dot = psi*psi_dot - x_1*x_2 + x_2*u

pretty_print(rho_dot)


f_psi = A*exp(-t) + gamma
f_psi_dot = -A*exp(-t)

f_x1 = x_1
f_x1_dot = x_2

f_rho =  (1/2)*f_psi**2 - (1/2)*x_1**2 - (1/2)*x_2**2
k0 = 1/f_rho
k1 = 1/f_rho

f_u   = -k0**2*f_x1 - k1*f_x1_dot

rho_dot = rho_dot.subs(psi, f_psi)
rho_dot = rho_dot.subs(psi_dot, f_psi_dot)
rho_dot = rho_dot.subs(u, f_u)

pretty_print(simplify(rho_dot))


