import sympy
from sympy import *
from sympy_utils.printing import *

x1, x2 = symbols("x1 x2")
bx1, bx2 = symbols("bx1 bx2")
x1_o, x2_o = symbols("x1o x2o")

k = x1 - 4*x2
k_o = x1_o - 4*x2_o 

x1_dot  = x2
x2_dot = -2*x1 + 3*x2 + k
k_dot  = x1_dot - 4*x2_dot

x1_ddot = x2_dot
x2_ddot = -2*x1_dot + 3*x2_dot + k_dot

k_ddot  = x1_ddot - 4*x2_ddot

# For reference
dh = k_o - k

phi1 = -k_dot 
phi1 = phi1.subs([(x1,x1_o), (x2,x2_o)])

phi2 = -0.5*k_ddot
phi2 = phi2.subs([(x1,bx1),(x2,bx2)])

print_octave("phi1", phi1)
print_octave("phi2", phi2)

