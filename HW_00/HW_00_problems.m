%% 1i
B=[11 -9 4; 10 -8 4; -14 12 -4];
B_T=B.';
disp(B_T*B)

%% 1ii
b=[-2; 4; 1];
b_T=b.';
disp(b_T*B)

%% 1iii
a=[1-3i; 1; -2];
c=[-2; 4; 1];
disp(a.'*c)
disp(a'*a)

%% 1iv
disp(norm(c))

%% 2
A=[3 4 4; -0.6 -4.8 -7.8; 1.5 0.4 -10.8];
x=A^(-1)*b;
disp(x)

%% 3i
disp(det(A))

%% 3ii
B=[11 -9 4; 10 -8 4; -14 12 -4];
disp(det(B))

%% 3iii
v1=B(:, 1);
v2=B(:, 2);
v3=B(:, 3);
v2_v3=[v2 v3];

c=[-1; 0.5];

disp(v1)
disp(v2_v3*c)

%% 3iv
disp(det(A))

%% 4i
disp(A^(-1))

%% 4ii
disp(A^(-1)*A)

%% 5a
disp((2-5i)*(5-2i))

%% 5b
z1=(2+5i);
z2=(2+5i);
disp(abs(z1/z2))

%% 5c
disp(3*conj(exp(2*z1)))

disp(3*exp(4)*(cos(10)-(sin(10)*i)))

%% 6ii


%% 7i
P=[4 2; 1 5];
[V, D]=eig(P);

%% 7ii
B=[11 -9 4; 10 -8 4; -14 12 -4];
[V, D]=eig(B)

%% 7iii
i=1
disp(B*V(:,i))
disp(D(i,i)*V(:,i))

%% 8ii
[U,~]=eig(P);
[V,D]=eig(B);
H=U^(-1)*P*U

%% 11v
grad_norm = norm([-42; 6]);
quiver(-2,1,-42/grad_norm,6/grad_norm)
hold on
x = -3:0.1:3;
y = -3:0.1:3;
[X,Y] = meshgrid(x,y);
Z = (17*(X.^2))+(26*X*Y)+(29*(Y.^2));
contour(X,Y,Z);
%% 12i
x=[2*pi:0.1:3*pi];
f=2*exp(-x/2).*sin(2*x);
figure(1);clf
plot(x,f)
% always label axes and provide titles:
xlabel('x')
ylabel('f')
title('f(x)=2e^{-x/2}sin(2x)')

%% 12ii
% Solve a linear equations $Ax=b$:
A=[3,4,4;-0.6,-4.8,-7.8;1.5,0.4,-10.8];
b=[-2; 4; 1];
fprintf(1,'determinant ofA:\n')
det(A)
fprintf(1,'solution using matrix inverse is:\n')
x2=inv(A)*b
fprintf(1,'checking that x is a solution; A*x1:\n')
A*x2
fprintf(1,'b:\n')
b
