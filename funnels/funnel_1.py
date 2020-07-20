import sympy
from sympy import *
from sympy_utils.printing import * 

a,b,c,t,d = symbols('a b c t d')
x = symbols("x")

# Funnels
psi_1 = (-a*t**2+b)*exp(-t)
psi_1_diff = psi_1.diff(t)
psi_1_diff2 = psi_1_diff.diff(t)

psi_2 = -(a+c*t**2)*exp(-t)
psi_2_diff = psi_2.diff(t)
psi_2_diff2 = psi_2_diff.diff(t)

# Rhos
rho_1   = 0.5*psi_1**2 - 0.5*x**2
rho_2   = 0.5*x**2 - 0.5*psi_2**2
rho     = rho_1*rho_2

# Control
num = rho_2*psi_1**2 + rho_1*psi_2**2
den = rho_2*(psi_1**2*(1+d) - x**2) + rho_1*(psi_2**2*(1+d)*-x**2)
gain = num/ den
ctl = -x *gain

rho_dot = psi_1*psi_1_diff * rho_1 + psi_2*psi_2_diff*rho_2 + x*ctl*(rho_1 - rho_2)


#print_math("psi_1", psi_1)
#print_math("psi_1_diff", psi_1_diff)
#print_math("psi_2", psi_2)
#print_math("psi_2_diff", psi_2_diff)

# Robustness Conditions
cond_1b = d*psi_2*psi_2_diff + psi_1**2
cond_2b = d*psi_1*psi_1_diff + psi_2**2

#print_math("cond_1b", simplify(cond_1b))
#print_math("cond_2b", simplify(cond_2b))


print_octave("psi_1", psi_1)
print_octave("psi_1_diff", psi_1_diff)
print_octave("psi_1_diff2", psi_1_diff2)
print_octave("psi_2", psi_2)
print_octave("psi_2_diff", psi_2_diff)
print_octave("psi_2_diff2", psi_2_diff2)


print_octave("gain", gain)
print_octave("ctl", ctl)
print_octave("rho_dot", rho_dot)


