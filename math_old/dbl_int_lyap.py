from sympy import *
from sympy_utils.printing import *

a, b, c = symbols("a b c")
x1, x2  = symbols("x_1 x_2")

x = Matrix([x1,x2])
Q = Matrix([[a,b],[b,c]])

V_dot = x.transpose()*Q*x

print_math("V_dot", V_dot)
