%% 1ai
F=[ -6, 47, -42, -66, 35, 21, 9, 2;
89, -64, 4, 56, 20, 11, -59, -57];

[M, N] = size(F);
F_prime = F - mean(F,2);
disp('Covariance Matrix:')
C=F_prime * F_prime.'
[U, lambda]=eig(C);
disp('Principal Components:')
for i = 1:1:length(U)
    disp(U(:, i))
end


%% 1aii
disp('Expansion Matrix:')
T=U.' * F
for i = 1:1:length(U)
    disp('For PC:')
    disp(U(:, i))
    disp(['% variance explained = ' num2str(lambda(i,i)/sum(lambda(:)))])
end

%% 3
A=[-10,-9,8;-0,4,3];
