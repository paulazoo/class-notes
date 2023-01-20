### Eigenvectors and eigenvalues
For a transformation,
__eigenvectors__: vectors that are sent to scalar multiples of themselves ($\mathrm{span}$ of themselves)
__eigenvalues__: the scalar multiples

For eigenvector $v_1$ and eigenvalue $\lambda$ of transformation $A$:
$Av_1=\lambda v_1$

- if $Av_1=\lambda v_1$ and $Bv_1=\mu v_1$, then $ABv_1=\lambda \mu v_1$
- if $Av_1=\lambda v_1$ and $Av_2=\lambda v_2$, then $A(v_1 + v_2) = \lambda (v_1+v_2)$
    - (eigenspaces are closed under addition) 
- $A(kv_1)=k\lambda v_1$
    - (eigenspaces are closed under scalar multiplication)



__Patterns:__
- n x n matrices with odd n always have real eigenvalue
- n x n matrices with even n and $-\mathrm{det}$ always have real eigenvalue
- rotations usually have imaginary eigenvalues