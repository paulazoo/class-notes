%% APM120 HW-00

% use large font size in plots for improved visibility:
set(0,'defaulttextfontsize',16); set(0,'defaultaxesfontsize',16);

%% Plot $f(x)=\cos(3x)$ vs $x$ for $x=(-2\pi,\pi)$:
x=[2*pi:0.1:3*pi];
f=2*exp(-x/2).*sin(2*x);
figure(1);clf
plot(x,f)
% always label axes and provide titles:
xlabel('x')
ylabel('f')
title('f(x)=2e^{-x/2}sin(2x)')

%% Solve a linear equations $Ax=b$:
A=[3,4,4;-0.6,-4.8,-7.8;1.5,0.4,-10.8];
b=[-2; 4; 1];
fprintf(1,'determinant ofA:\n')
det(A)
fprintf(1,'solution using matrix inverse is:\n')
x2=inv(A)*b
fprintf(1,'checking that x is a solution; A*x1:\n')
A*x1
fprintf(1,'b:\n')
b

%% Calculate the eigenvalues and vectors of $A$:
fprintf(1,'eigenvectors/ values of A:\n')
[V,D]=eig(A)

%% verify that V_1 is an eigenvector of A
fprintf(1,'A*v1:\n')
A*V(:,1),
fprintf(1,'lambda1*v1:\n')
D(1,1)*V(:,1)

%% verify that V_2 is an eigenvector of A
fprintf(1,'A*v2:\n')
A*V(:,2),
fprintf(1,'lambda2*v2:\n')
D(2,2)*V(:,2)
