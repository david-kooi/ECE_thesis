import sympy
from sympy import *
from sympy_utils.printing import *

epsilon, lam    = symbols("epsilon lambda")
x1, x2 = symbols("x1 x2")
x1_o, x2_o = symbols("xo1 xo2")

x = Matrix([x1,x2])
e = Matrix([x1_o-x1, x2_o-x2])

A = Matrix([[0,1],[-2,3]])
B = Matrix([0,1])
K = Matrix([1, -4]).transpose()
P = Matrix([[1, 0.25],[0.25, 1]])
Q = Matrix([[0.5, 0.25],[0.25,1.5]])

# Original Alpha
alpha  = x.transpose()*Q*x
dalpha_dx1 = alpha.diff(x1)
dalpha_dx2 = alpha.diff(x2)

# Alpha by limit
#alpha = -lam*(x1**2 + x2**2)

# Original Gamma
gamma = 0.5*x.transpose()*P*B*K*e
dgamma_dx1 = gamma.diff(x1)
dgamma_dx2 = gamma.diff(x2)

# Gamma by limit
gamma2 = 8*sqrt(x.dot(x))*sqrt(e.dot(e))
dgamma2_dx1 = gamma2.diff(x1)
dgamma2_dx2 = gamma2.diff(x2)

# Rho
V = x.transpose()*P*x
rho = - V
drho_dx1 = rho.diff(x1)
drho_dx2 = rho.diff(x2)


print_octave("alpha", alpha)
print_math("dalpha_dx1", dalpha_dx1)
print_math("dalpha_dx2", dalpha_dx2)

print_octave("gamma", gamma)
print_math("dgamma_dx1", dgamma_dx1)
print_math("dgamma_dx2", dgamma_dx2)

print_math("gamma2", gamma2)
print_math("dgamma2_dx1", dgamma2_dx1)
print_math("dgamma2_dx2", dgamma2_dx2)

print_octave("drho_dx1", drho_dx1)
print_octave("drho_dx2", drho_dx2)

