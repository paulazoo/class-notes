function [Q, R]=QR_decomp(A, n)
Q=zeros(m,n);
R=zeros(n,n);

for j=1:1:n
    v=A(:, J);
    for i=1:1:j-1
        R(i,j)=Q(:,i)'*A(:,j);
        v=v-R(i,j)*Q(:,i);
    end
    R(j,j)=norm(v);
    Q(:,j)=v./R(j,j);
end
end