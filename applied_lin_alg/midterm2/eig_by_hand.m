%% find eigenvalues
clc
A=[12.6667   -8.1667;
   -8.1667   39.0000]

%-------------
a_plus_d=A(1,1)+A(2,2)
a_plus_d_over_2 = a_plus_d / 2
ad_minus_bc=A(1,1)*A(2,2) - (A(1,2)*A(2,1))
inside_sqrt = a_plus_d_over_2.^2 - (ad_minus_bc)
lambda1 = a_plus_d_over_2 + sqrt(inside_sqrt)
lambda2 = a_plus_d_over_2 - sqrt(inside_sqrt)

%% SVD find U (or V)
clc
find_eigvecs = A;
disp('For first eigval:')
find_eigvecs(1,1) = find_eigvecs(1,1) - lambda1;
find_eigvecs(2,2) = find_eigvecs(2,2) - lambda1;
disp(find_eigvecs)
eigvec1 = null(find_eigvecs)

disp('For second eigval:')
find_eigvecs = A;
find_eigvecs(1,1) = find_eigvecs(1,1) - lambda2;
find_eigvecs(2,2) = find_eigvecs(2,2) - lambda2;
disp(find_eigvecs)
eigvec2 = null(find_eigvecs)

disp('matrix calc?')
