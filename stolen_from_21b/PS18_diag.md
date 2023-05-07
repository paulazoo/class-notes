### Diagonalization:
__For all matrices with an eigenbasis__
_when n × n matrix has n linearly ind eigenvectors_

1. find eigenvalues and eigenvectors
2. $S=\textrm{eigenbasis matrix}=
\left[{\begin{array}{cc}
\textrm{eigenvector}_1 && \textrm{eigenvector}_2\\
\end{array}}\right]$
3. $D=S^{-1}AS=\textrm{eigenvalue matrix}=\left[{\begin{array}{cc}
\lambda_1 && 0 \\
0 && \lambda_2 \\
\end{array}}\right]$
4. So $A=SDS^{-1}$
    - and $A^{100}=SD^{100}S^{-1}$

E.g. for $x(t+1)=Ax(t)$, then $x(t)=A^t x(0)$
Applying diag. $x(t)=SD^{t}S^{-1} x(0)$

### Complex eigenvalues:
Can express $D^t=
\left[{\begin{array}{cc}
r_1^t e^{i\theta_1 t} && 0 \\
0 && r_2^t e^{i\theta_2 t} \\
\end{array}}\right]$
if $r$ is the same, $=r^t
\left[{\begin{array}{cc}
\mathrm{cos}(\theta_1 t)+i\mathrm{sin}(\theta_1 t) && 0 \\
0 && \mathrm{cos}(\theta_2 t)+i\mathrm{sin}(\theta_2 t) \\
\end{array}}\right]$

So if $r>1$, $D^t$ spiral toward $0$; if $r>1$, $D^t$ spiral to $\infty$

### Complex conjugates:
complex conjugate eigenvalues ($a\pm bi$) have complex conjugate eigenvectors

If for $a + bi$, eigenvector $=\left[{\begin{array}{c}
c+di \\
e+fi \\
\end{array}}\right]$
Then for $a - bi$, eigenvector $=\left[{\begin{array}{c}
c-di \\
e-fi \\
\end{array}}\right]$

### Similar matrices:
- same rank
- same trace
- same determinant
- same eigenvalues
- same char. polynomial
- same algs and geos
