%% 1a
A=[ -5.868, -7.551, 0.158;
-7.551, 3.83, 0.426;
0.158, 0.426, 6.038];

B=[ 4.828, 2.053, -0.002;
-4.651, 3.21, -7.63;
-1.889, -11.09, -4.038];

v0=[1;1;1];

v1=A*v0;
v1=v1./norm(v1);
disp('v1:')
disp(v1)

disp('from eig function:')
[V,D]=eig(A)
%% 1c e2
e1=[0.8772; 0.4792; -0.0214];
lambda1=-10.0004;
disp(lambda1*e1*e1.')
A_e2=A - (lambda1*e1*e1.')

v1=A_e2*v0;
disp(norm(v1))
v1=v1./norm(v1)

%% 1c e3
e2=[-0.4714; 0.8689; 0.1507];
lambda2=8.0001;
disp(lambda2*e2*e2.')
A_e3=A_e2 - (lambda2*e2*e2.')

v1=A_e3*v0
disp(norm(v1))
v1=v1./norm(v1)

%% 1d
[V, D] = eig(B)
e1=V(:,1);

max_idx = 3;
e_1p=0.8740;
b_p=B(max_idx, :);

B_e2=B - ( (e1*b_p) ./ e_1p)

% 1st iteration
v1=B_e2*v0
norm(v1)
v1=v1./norm(v1)


%% 3b

