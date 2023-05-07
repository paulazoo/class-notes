%% SVD find sigma
clc
A=[8 -9;-8 3]

svd_AA=A*A.'

%-------------
a_plus_d=svd_AA(1,1)+svd_AA(2,2)
a_plus_d_over_2 = a_plus_d / 2
ad_minus_bc=svd_AA(1,1)*svd_AA(2,2) - (svd_AA(1,2)*svd_AA(2,1))
inside_sqrt = a_plus_d_over_2.^2 - (ad_minus_bc)
lambda1 = a_plus_d_over_2 + sqrt(inside_sqrt)
lambda2 = a_plus_d_over_2 - sqrt(inside_sqrt)
sigma = [lambda1 0; 0 lambda2].^(1/2)

%% SVD find U (or V)
clc
find_eigvecs = svd_AA;
disp('For first eigval:')
find_eigvecs(1,1) = find_eigvecs(1,1) - lambda1;
find_eigvecs(2,2) = find_eigvecs(2,2) - lambda1;
disp(find_eigvecs)
eigvec1 = null(find_eigvecs)

disp('For second eigval:')
find_eigvecs = svd_AA;
find_eigvecs(1,1) = find_eigvecs(1,1) - lambda2;
find_eigvecs(2,2) = find_eigvecs(2,2) - lambda2;
disp(find_eigvecs)
eigvec2 = null(find_eigvecs)

disp('matrix calc?')

%% SVD find V
clc
A_T = A.'

U = [eigvec1 eigvec2]

% ----------
V(:, 1) = A_T * U(:,1) / sigma(1,1);
V(:, 2) = A_T * U(:,2) / sigma(2,2)

%% or SVD find V
clc
A

V = [eigvec1 eigvec2]

% ----------
U(:, 1) = A * V(:,1) / sigma(1,1);
U(:, 2) = A * V(:,2) / sigma(2,2)

%% polar decomposition
R = U * V.'
S = V * sigma * V.'

%% SVD PCA
PCs = U
T = V
dimensional_T = sigma * V.'
lambda1
lambda2
sum_lambdas = (lambda1 + lambda2)
disp('for PC1:')
disp(lambda1 / sum_lambdas)
disp('for PC2:')
disp(lambda2 / sum_lambdas)



