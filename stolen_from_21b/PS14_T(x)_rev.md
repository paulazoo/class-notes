### Generally, transformation matrix:
For $T(x)$, matrix $=[T(e_1), T(e_2), ...T(e_n)]$ where initial space $R^n$

Also, for any T matrix $A$, a basis is the columns where $\mathrm{rref}A$ has leading 1's
_bc answer $=\mathrm{span}\textrm{(leading 1's cols)}$_

### PS05 strategy:
1) find easy set of $\mathcal{B}$ vectors $v_1, v_2, ...v_n$ for $R^n$ and respective $T(v_1), T(v_2), ...T(v_n)$

2) $x=c_1v_1 + c_2v_2$,
$\left[{\begin{array}{cc}
v_1 & v_2 \\
\end{array}}\right]
\left[{\begin{array}{c}
c_1 \\
c_2
\end{array}}\right]=$
$\left[{\begin{array}{cc}
v_{1x} & v_{2x} \\
v_{1y} & v_{2y}
\end{array}}\right]
\left[{\begin{array}{c}
c_1 \\
c_2
\end{array}}\right]=
\left[{\begin{array}{c}
x_1 \\
x_2
\end{array}}\right]$

3) use Gauss-Jordan with $[v_1, v_2]$ on right and $[x_1; x_2]$ on left to find $c_1, c_2$ in terms of $x$

4) $T(x)=T(c_1v_1+c_2v_2)=c_1[T(v_1)] + c_2[T(v_2)]$
$=\left[{\begin{array}{c}
c_1*T(v_1)_x + c_2*T(v_2)_x \\
c_1*T(v_1)_y + c_2*T(v_2)_y \\
\end{array}}\right]$

6) plug in and simplify in terms of $x_1$ and $x_2$ for both to make one big matrix $\left[{\begin{array}{c}
T(x)=k_1x+k_2y \\
T(y)=k_3x+k_4y \\
\end{array}}\right]$

7) take out $\left[{\begin{array}{c}
x_1 \\
y \textrm{ (aka }x_2) \\
\end{array}}\right]$ to make a 4x4 final $T$ matrix

### PS08 strategy:
1. $\mathcal{B}$ matrix $=\left[{\begin{array}{cc}
|T(v_1)|_\mathcal{B} & |T(v_2)|_\mathcal{B}\\
\end{array}}\right]$
where $T(v_1)=c_1 v_1 + c_2 v_2$
and $ = \left[{\begin{array}{c}
c_1 \\
c_2 \\
\end{array}}\right]$

2. So $\mathcal{B}=\left[{\begin{array}{cc}
c_{1T(v_1)} & c_{1T(v_2)}\\
c_{2T(v_1)} & c_{2T(v_2)}\\
\end{array}}\right]$

3. $S$ matrix $=\left[{\begin{array}{cc}
v_1 & v_2\\
\end{array}}\right]$

4. Standard transformation matrix $=S\mathcal{B}S^{-1}$
