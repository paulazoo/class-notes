### Gram-Schmidt Process
Given linearly independent vectors $v_1, v_3, ...$, obtain an orthonomal unit basis for subspace V: $w_1, w_2, ...$

1. first $\hat{w_1}=\hat{v_1}$

2. find $w_k = v_k-(v_k\cdot \hat{w_1})\hat{w_1}... -(v_k\cdot \hat{w_{k-1}})\hat{w_{k-1}}$

3. normalize $\hat{w_k}$

__Note__:
If $T(x)=\mathrm{proj_V}(x)$,
then we can use $\hat{w_1}, \hat{w_2}, ...$ with the __vector on subspace projection__ operation ([PS12.md](./PS12.md)) to find $T(x) matrix$:

e.g. $\mathrm{proj_V}(e_1)=(e_1\cdot \hat{w_1})\hat{w_1}+(e_1\cdot \hat{w_2})\hat{w_2}+...$



