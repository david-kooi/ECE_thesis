from sympy import *
from sympy_utils.printing import *

t, x = symbols("t x")
z = Matrix([x,t])

d, f1, f2 = symbols("d f_1 f_2")
rho1, rho2, delta_psi, delta_f = symbols("rho1 rho2 Delta_psi Delta_f")
f1_h, f2_h = symbols("f1_h f2_h")

psi1 = Function("psi_1")(t)
psi2 = Function("psi_2")(t)


lam = (x-psi2)/(psi1 - psi2)
u1 = f1_h - d 
u2 = f2_h + d

u  = lam*u1 + (1-lam)*u2

alpha1 = (x - psi2)*d
alpha2 = (psi1 - x)*d

alpha = lam*alpha1 + (1-lam)*alpha2
grad_alpha = derive_by_array(alpha, z)

f = Matrix([u, 1])

alpha_dot_f = grad_alpha[0][0]*u + grad_alpha[1][0] 



#grad_alpha = grad_alpha.subs([(psi1.diff(t),f1)])
#grad_alpha = grad_alpha.subs([(psi2.diff(t),f2)])
#grad_alpha = grad_alpha.subs([(psi1-psi2,delta_psi)])
#grad_alpha = grad_alpha.subs([(psi1-x,rho1)])
#grad_alpha = grad_alpha.subs([(x-psi2,rho2)])
#grad_alpha = grad_alpha.subs([(f1-f2,delta_f)])

alpha_dot_f = alpha_dot_f.subs([(psi1.diff(t),f1)])
alpha_dot_f = alpha_dot_f.subs([(psi2.diff(t),f2)])
alpha_dot_f = alpha_dot_f.subs([(psi1-psi2,delta_psi)])
alpha_dot_f = alpha_dot_f.subs([(psi1-x,rho1)])
alpha_dot_f = alpha_dot_f.subs([(x-psi2,rho2)])
alpha_dot_f = alpha_dot_f.subs([(f1-f2,delta_f)])

d_alpha_dx = simplify(grad_alpha[0][0])
d_alpha_dt = simplify(grad_alpha[1][0])
grad_alpha = Matrix([d_alpha_dx, d_alpha_dt])



print_math("alpha", alpha)
print_math("alpha_dot_f", simplify(alpha_dot_f))
#print_math("grad_alpha", simplify(grad_alpha))



