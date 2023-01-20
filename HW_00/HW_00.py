## APM120 HW-00
import numpy as np
from numpy import linalg
import scipy as scipy
import matplotlib.pyplot as plt
import matplotlib
from math import pi

## Plot $f(x)=\cos(3x)$ vs $x$ for $x=(-2\pi,\pi)$:
x=np.arange(-2*pi,pi,0.1);
f=np.cos(x);
plt.figure(1);plt.clf();
plt.plot(x,f)
# always label axes and provide titles:
plt.xlabel('x')
plt.ylabel('f')
plt.title('f(x)=cos(3x)')
plt.show();

## Solve a linear equations $Ax=b$:
A=np.array([[1,2,4],[-2,3,0],[-5,3,6]]);
b=np.array([3, 4, 1]);
print('determinant of A:')
print(np.linalg.det(A))
print('solution using matrix inverse is:')
x2=np.linalg.inv(A)@b; print("x2=np.linalg.inv(A)@b="); print(x2)
print('checking that x is a solution; A*x2:')
print(A@x2)
print('b:')
print(b)

## Calculate the eigenvalues and vectors of $A$:
print('eigenvectors/ values of A:\n')
D,V=np.linalg.eig(A); D=np.diag(D);
print("V="); print(V);print("D="); print(D);

# Reminder: MATLAB indexes from 1, Python from 0.
## verify that V_1 is an eigenvector of A
print('A*v1:\n')
print(A@V[:,0]),
print('lambda1*v1:\n')
print(D[0,0]*V[:,0])

## verify that V_2 is an eigenvector of A
print('A*v2:\n')
print(A@V[:,1]),
print('lambda2*v2:\n')
print(D[1,1]*V[:,1])
