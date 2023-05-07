function Kaczmarz_example
%% solving linear equations using Kacmarz iterations example for a
%% *real* (non-complex) system of equations
%% APM120, Eli Tziperman, 202111

%% set up matrix equation (If you are using this code for HW, replace
%% the following two lines with the specified A,b):
A=[1.5 -3; -1 -5];   % standard case, angle smaller than 90 deg
b =[ 2; -3];
solve_using_Kaczmarz(A,b)
pause

A=[1.5 -3; -1 -0.5]; % 90 degree angle between lines
solve_using_Kaczmarz(A,b)
pause

A=[1.5 -3; -1.5 -0.5]; % larger than 90 degree angle between lines
solve_using_Kaczmarz(A,b)
pause


end % of function


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function solve_using_Kaczmarz(A,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

my_fprintf_array(A);my_fprintf_array(b);

%% number of equations:
[m,n]=size(A);
%% frequency of output during iterations:
nprint=1;
kmax=15;

%% Initial guess:
Xk=A(1,:)'*0.0;
X=nan(kmax,n);
X(1,:)=Xk;

fprintf(1,'Iterative solution:\n');
fprintf(1,'initial X(k)=      '); fprintf(1,'%g,', Xk); fprintf(1,'\n')
for k=0:kmax;
  i=mod(k,m)+1;
  Xkp1=Xk+(b(i)-A(i,:)*Xk)*A(i,:)'/norm(A(i,:))^2;
  if k==round(k/nprint)*nprint
    fprintf(1,'k=%d; i=%d; X(k)=      ',k,i); fprintf(1,'%g,',Xkp1); 
    fprintf(1,' error=%g; \n',norm(A\b-Xkp1))
  end
  %% save current iteration for plot:
  X(k+1,:)=Xk;

  Xk=Xkp1;

end;
fprintf(1,'backslash solution: '); fprintf(1,'%g,',A\b); fprintf(1,'\n');
fprintf(1,'minimum norm solution: '); fprintf(1,'%g,',pinv(A)*b); fprintf(1,'\n');

%% plot:
figure(1); clf
x=-0.2:0.01:3.1;
y1=-A(1,1)*x/A(1,2)+b(1)/A(1,2);
y2=-A(2,1)*x/A(2,2)+b(2)/A(2,2);
plot(x,y1,'r')
hold on
plot(x,y2,'g')
plot(X(:,1),X(:,2),'--xb')
grid()
hax=gca();
hax.YRuler.LineWidth=0.2;
axis('equal')

end % of function
