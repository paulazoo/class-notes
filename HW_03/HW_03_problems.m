%% 1b
A=[-0.7108,-2.995;1.336,-0.7892];
x0 = [-5; 2];

[V, D] = eig(A)
a_const = V^(-1)*x0

%% 1c
V*diag(exp(diag(D*2.0)))/V

expm(A*2.0)


%% 1d
[X,Y] = meshgrid(-10:1:10,-10:1:10);
X=X(:).';
Y=Y(:).';
gradient = A*[X;Y];
U = gradient(1,:)
V = gradient(2,:)

q = quiver(X,Y,U,V);

%% 1fi
t=2.0;
x2_sad=[-2; -2];

expm_A2 = expm(A*2.0)
x0_sad=expm_A2^(-1)*x2_sad

%% 2a
A=[ -64.0859, -22.6535;
177.346, 62.6859];

[V, D] = eig(A)

