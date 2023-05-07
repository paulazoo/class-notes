
__Find eigenvalues:__
1. $Av_1=\lambda v_1$
$Av_1=\lambda Iv_1$
$Av_1-\lambda Iv_1=0$
$(A-\lambda I)v_1=0$
- $A-\lambda I=\left[{\begin{array}{cc}
a-\lambda & b \\
c & d-\lambda \\
\end{array}}\right]$

2. when $A-\lambda I$ transforms to 0, so $\mathrm{det}(A-\lambda I)=0$
so solve for $\mathrm{det}(A-\lambda I)=0$
- $(\lambda-3)(\lambda+2)=0$ means eigenvalues of $+3, -2$
_Note: complex eigenvalues usually mean rotation_

__Find eigenvectors:__
3. Plug in $\lambda$ and solve $\left[{\begin{array}{cc}
a-\lambda & b \\
c & d-\lambda \\
\end{array}}\right]\left[{\begin{array}{c}
x \\
y \\
\end{array}}\right]=\left[{\begin{array}{c}
0 \\
0 \\
\end{array}}\right]$
- _aka: the $\lambda \textrm{ eigenspace}=\mathrm{ker}(A-\lambda I)$_
- when solving by inspection, helpful to first look at $\mathrm{rank}(A-\lambda I)$
    - remember $\mathrm{rank}+\mathrm{null}=\mathrm{dim}(\textrm{input})$

__For 2x2 eigenvalues:__
$\mathrm{det}(A-\lambda I)=\lambda^2-(a+d)\lambda+(ad-bc)=0$
eigenvalues $=\frac{a+d}{2}\pm \sqrt{(\frac{a+d}{2})^2-(ad-bc)}$

__For triangular matrices:__
eigenvalues are just diagonal

__Trace:__
sum of diagonal = sum of eigenvalues

__Determinant:__
$\mathrm{det}=$ product of eigenvalues

__Multiplicity:__
algebraic: $(\lambda-3)(\lambda+2)(\lambda+2)=0$ then 3 alg = 1, -2 alg = 2
geometric: $\mathrm{dim}(\lambda \textrm{ eigenspace})=\mathrm{dim}(\mathrm{ker}(A-\lambda I))$
geo $\leq$ alg

__Eigenbasis:__
when n × n matrix has n distinct eigenvalues
- all eigenvalues have alg = 1, geo = 1
- all eigenvectors are linearly ind
- sum of the geos is n

