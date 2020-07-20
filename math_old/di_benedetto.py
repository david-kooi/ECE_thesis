import sympy
from sympy import *
from sympy_utils.printing import *

x1, x2, k1, k2 = symbols("x_1 x_2 k_1 k_2")

u = -k1*x1 - k2*x2
d2_d2t = k1*u - k1*k2*x2 - k2**2*u

print_math("d2_d2t", simplify(d2_d2t))
