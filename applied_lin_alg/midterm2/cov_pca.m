%% Covariance PCA
clc
A =[6 -2 -1 -5 3 -1; ...
    -7 -8 10 4 2 -1]
N = 6;

%-------------
C = (1/N) .* A * A.'

%% Time series PCA
clc
U = [-0.2740 0.9617;
    0.9617 0.2740]

%------------
T=U'*A
T_norm1 = norm(T(1,:))
T_norm2 = norm(T(2,:))
T_normed = T;
T_normed(1,:)=T(1,:)/norm(T(1,:));
T_normed(2,:)=T(2,:)/norm(T(2,:))

%% Fraction of variance
clc
lambda1
lambda2
sum_lambdas = (lambda1 + lambda2)
disp('for PC1:')
disp(lambda1 / sum_lambdas)
disp('for PC2:')
disp(lambda2 / sum_lambdas)
