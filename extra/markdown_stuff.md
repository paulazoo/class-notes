# General:
To preview: cmd+k, then v

# LaTeX stuff:
$inline$
$$newline$$

dot product: $A \cdot B$
cross product (only in $R^3$ or greater): $A \times B$

$\infty$

$\left[{\begin{array}{cc}
1 & 2 \\
3 & 4 \\
\end{array}}\right]$


## ES230
of M x N dimensions where M is the number of input neurons and N is the number of output neurons

$
T_{N \times M}
\left[{\begin{array}{cc}
\textrm{input neuron 1's activation} \\
\textrm{input neuron 2} \\
... \\
\textrm{input neuron M} \\
\end{array}}\right]=
\left[{\begin{array}{cc}
\textrm{output neuron 1's target activity} \\
\textrm{output neuron 2} \\
... \\
\textrm{output neuron N} \\
\end{array}}\right]$

e.g. for M=4 neurons and N=3 neurons, a target function might be
$T=\left[{\begin{array}{cc}
0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 \\
1 & 0 & 0 & 0 \\
\end{array}}\right]$

