clc
A =[8 3; -8 9; 2 -1; -9 3]

% -------------------
Q(:,1)=A(:,1);
disp('Q1:')
disp(Q(:,1))

Q1_norm = norm(A(:,1))
Q(:,1)=A(:,1)/norm(A(:,1));
disp('Q1_hat:')
disp(Q(:,1))

A2_dot_Q1 = A(:,2)'*Q(:,1)
A2_dot_Q1_times_Q1 = A2_dot_Q1 .* Q(:,1)
Q(:,2)=A(:,2) - A2_dot_Q1_times_Q1;
disp('Q2:')
disp(Q(:,2))

Q2_norm = norm(Q(:,2))
Q(:,2)=Q(:,2)/norm(Q(:,2));
disp('Q2_hat:')
disp(Q(:,2))

R = Q.' * A

%% R x = Q.' b for lots RHS's for overdet
clc
Q
R
QT_b = Q.'*b
x=R\QT_b
