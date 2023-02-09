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

% code--
v1=[-0.8733; -0.217; 0.4361];

v=v1;
for i = 2:1:50
    v=A*v;
    v=v./norm(v);
    if i<6
        disp([num2str(i) 'th iteration:'])
        disp(v)
    end
end
e1=v;
disp('50th iteration:')
disp(e1)

lambda1 = (A*e1) ./ e1;
lambda1 = mean(lambda1(:));
disp('lambda for 50th iteration:')
disp(lambda1)
% code--

disp('from eig function:')
[V,D]=eig(A)
%% 1c e2
A_e2=A - (lambda1*e1*e1.')

v1=A_e2*v0

% code--
A_e2=[1.8275 -3.3436, -0.0296; 
    -3.3436, 6.13, 0.3235;
    -0.0296, 0.3235, 6.0426];
e2_v1=[-1.55; 3.11; 6.34];

v=e2_v1;
for i = 2:1:50
    v=A_e2*v;
    v=v./norm(v);
    if i<6
        disp([num2str(i) 'th iteration:'])
        disp(v)
    end
end
e2=v;
disp('e2 50th iteration:')
disp(e2)

lambda2 = (A_e2*e2) ./ e2;
lambda2 = mean(lambda2(:));
disp('lambda 2 for 50th iteration:')
disp(lambda2)
% code--

%% 1c e3
A_e3=A_e2 - (lambda2*e2*e2.')

v1=A_e3*v0

% code--
A_e3=[0.0496, -0.0665, 0.5389;
    -0.0665, 0.0895, -0.7243;
    0.5389, -0.7243, 5.8608];
e3_v1=[-4.13; 7.87; 7.16];

v=e3_v1;
for i = 2:1:50
    v=A_e3*v;
    v=v./norm(v);
    if i<6
        disp([num2str(i) 'th iteration:'])
        disp(v)
    end
end
e3=v;
disp('e3 50th iteration:')
disp(e3)

lambda3 = (A_e3*e3) ./ e3;
lambda3 = mean(lambda3(:));
disp('lambda 3 for 50th iteration:')
disp(lambda3)
% code--

%% 1d
[V,D]=eig(B)

B_e2=

e2_Bv1=B_e2*v0

% code--
B_e2=
v=[];
for i = 2:1:50
    v=B_e2*v;
    v=v./norm(v);
    if i<6
        disp([num2str(i) 'th iteration:'])
        disp(v)
    end
end
e2_B=v;
disp('50th iteration:')
disp(e2_B)

B_lambda2 = (B*e2_B) ./ e2_B;
B_lambda2 = mean(B_lambda2(:));
disp('lambda for 50th iteration:')
disp(B_lambda2)

%% 3b
