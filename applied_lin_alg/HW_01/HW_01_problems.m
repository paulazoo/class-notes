%% 3a
% 3b checks

%% 3c
% end of 3c checks

%% 4a
% first set
x_k=[0;0;0];
i=1;
x_k1=x_k+( 1.*norm(A(i,:)).^-2.*(( b(i,1)-(A(i,:)*x_k) ).*A(i,:)') )
i=2;
x_k2=x_k1+( 1.*norm(A(i,:)).^-2.*(( b(i,1)-(A(i,:)*x_k1) ).*A(i,:)') )
i=3;
x_k3=x_k2+( 1.*norm(A(i,:)).^-2.*(( b(i,1)-(A(i,:)*x_k2) ).*A(i,:)') )

% second set
x_k=x_k3
% second set by code

for i = 1:1:length(b)
    disp(i)
    x_k=x_k+( 1.*norm(A(i,:)).^-2.*(( b(i,1)-(A(i,:)*x_k) ).*A(i,:)'))
    disp(norm((inv(A)*b) - (x_k)))
end

%% 4c

%% 7
A=[0.0003 1;...
    3 1];
b=[3;2];
disp(inv(A)*b)



