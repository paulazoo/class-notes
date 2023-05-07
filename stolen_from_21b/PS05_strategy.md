### General strategy for finding $T(x)$ and $T$ matrix:
1) find easy set of $\mathcal{B}$ vectors $v_1, v_2, ...v_n$ for $R^n$ and respective $T(v_1), T(v_2), ...T(v_n)$

2) $x=c_1v_1 + c_2v_2$, in other words $[v_{1x}, v_{2x}; v_{1y}, v_{2y}][c_1; c_2]=[x_1;x_2]$

3) use Gauss-Jordan with $[v_1, v_2]$ on right and $[x_1; x_2]$ on left to find $c_1, c_2$ in terms of $x$

4) $T(x)=T(c_1v_1+c_2v_2)=c_1T(v_1) + c_2T(v_2)$

5) plug in and simplify in terms of $x_1$ and $x_2$ for both to make one big matrix $[T(x_1); T(x_2)]$

6) take out $[x_1; x_2]$ to make a 4x4 final $T$ matrix