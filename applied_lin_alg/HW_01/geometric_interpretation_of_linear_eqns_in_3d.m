function geometric_interpretation_of_linear_eqns_in_3d
%% plot three intersecting semi-transparent planes in 3d
%% representing three equations.
%% Eli Tziperman, APM120, 201512

clear all; 
% set default font size on plots:
set(0,'defaulttextfontsize',14); set(0,'defaultaxesfontsize',14);

%% solve equations: unique solution
A=[5 3 -2;2 4 -1;1 3 3];
b=[6;-2;-1];
X=A\b;
view_angles=[30,40];min_max_axes=nan;
title_text='row interpretation, unique solution';
disp(title_text);my_fprintf_array(A);my_fprintf_array(b);my_fprintf_array(X);
plot_row_interpretation(A,b,X,title_text,view_angles,min_max_axes)
view_angles=[20,10];
title_text='column interpretation, unique solution';
disp(title_text);
plot_column_interpretation(A,b,X,title_text,view_angles,min_max_axes)

pause
%% solve equations: no solution
A=[5 2.5 -2;2 1 -1;1 0.5 3];
b=[6;-2;-1];
X=pinv(A)*b; % minimum residual norm (r=A*X-b) solution, see later in course
view_angles=[30,40];min_max_axes=[0 6; -2 2;-1 1];
title_text='row interpretation, no solution';
disp(title_text);my_fprintf_array(A);my_fprintf_array(b);my_fprintf_array(X);
plot_row_interpretation(A,b,X,title_text,view_angles,min_max_axes)
view_angles=[-40,50];
title_text='column interpretation, no solution';
disp(title_text);
plot_column_interpretation(A,b,X,title_text,view_angles,min_max_axes)

pause
%% solve equations: many solutions, #1
A=[5 2.5 -2;2 1 -1;1 0.5 3]
X=[1; 2; 3]
b=A*X
view_angles=[30,40];min_max_axes=[-5 10;0 12;-4 12];
title_text='row interpretation, many solutions 1';
disp(title_text);my_fprintf_array(A);my_fprintf_array(b);my_fprintf_array(X);
plot_row_interpretation(A,b,X,title_text,view_angles,min_max_axes)
view_angles=[30,15];
title_text='column interpretation, many solutions 1';
disp(title_text);
plot_column_interpretation(A,b,X,title_text,view_angles,min_max_axes)

pause
%% solve equations: many solutions, #2
A=[5 2.5 -2;2 1 -1;1 0.5 3]
%b=same as last one.
X=pinv(A)*b

view_angles=[30,40];min_max_axes=[-5 10;0 12;-4 12];
title_text='row interpretation, many solutions 2';
disp(title_text);my_fprintf_array(A);my_fprintf_array(b);my_fprintf_array(X);
plot_row_interpretation(A,b,X,title_text,view_angles,min_max_axes)
view_angles=[30,15];
title_text='column interpretation, many solutions 2';
disp(title_text);
plot_column_interpretation(A,b,X,title_text,view_angles,min_max_axes)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_row_interpretation(A,b,X,title_text,view_angles,min_max_axes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot row interpretation: solution is the intersection of
%% three planes:
figure(1); clf

%% set edge location of a square patch representing the planes:
x=[-5,-5,5,5];
y=[5,-5,-5,5];
%% height of surfaces of each of the planes represented by rows of
%% A above (x,y) plane:
z1=(b(1)-A(1,2)*y-A(1,1)*x)/A(1,3);
z2=(b(2)-A(2,2)*y-A(2,1)*x)/A(2,3);
z3=(b(3)-A(3,2)*y-A(3,1)*x)/A(3,3);

% plot first plane:
p1=patch(x(:),y(:),z1(:),'red');
set(p1,'facealpha',0.2); set(p1,'edgealpha',0.2)
view(3);
xlabel('x')
ylabel('y')
zlabel('z')
title(title_text)
hold on
grid on
pause

% plot second plane:
figure(1);
p2=patch(x(:),y(:),z2(:),'green');
set(p2,'facealpha',0.2); set(p2,'edgealpha',0.2)
pause

% plot third plane:
figure(1);
p3=patch(x(:),y(:),z3(:),'blue');
set(p3,'facealpha',0.2); set(p3,'edgealpha',0.2)

% plot location of solution:
plot3(X(1),X(2),X(3),'x','markersize',14,'linewidth',3)

% set view angle manually to best view the solution:
view(view_angles);
pause

if 0
  %% save as **png** (saving as pdf is not as good in this case):
  filename=strrep(title_text,',','');
  filename=strrep(filename,' ','_');
  set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [6 6 ]);
  set(gcf, 'PaperPosition', [0 0 6 6 ]); % [left, bottom, width, height];
  saveas(gcf,sprintf(['Figures/' filename '.png'])); 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_column_interpretation(A,b,X,title_text,view_angles,min_max_axes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot column interpretation: solution creates a triangle of vectors:
figure(2); clf

scale=1;

X0=[0,0,0]; X1=X(1)*A(:,1);
quiver3(X0(1),X0(2),X0(3),X1(1),X1(2),X1(3),scale,'color','red','linewidth',2);
hold on
xlabel('x')
ylabel('y')
zlabel('z')
title(title_text)
grid on
pause

X0=X(1)*A(:,1); X1=X(2)*A(:,2);
figure(2);
quiver3(X0(1),X0(2),X0(3),X1(1),X1(2),X1(3),scale,'color','green','linewidth',2);
pause

X0=X(1)*A(:,1)+X(2)*A(:,2); X1=X(3)*A(:,3);
figure(2);
quiver3(X0(1),X0(2),X0(3),X1(1),X1(2),X1(3),scale,'color','blue','linewidth',2);
pause

X0=[0,0,0]; X1=b;
figure(2);
quiver3(X0(1),X0(2),X0(3),X1(1),X1(2),X1(3),scale,'color','black','linewidth',4);

% set view angle manually to best view the solution:
view(view_angles);
if ~isnan(min_max_axes);
  xlim([min_max_axes(1,1),min_max_axes(1,2)]);
  ylim([min_max_axes(2,1),min_max_axes(2,2)]);
  zlim([min_max_axes(3,1),min_max_axes(3,2)]);
end
if 0
  %% save as pdf:
  filename=strrep(title_text,',','');
  filename=strrep(filename,' ','_');
  set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [6 6 ]);
  set(gcf, 'PaperPosition', [0 0 6 6 ]); % [left, bottom, width, height];
  saveas(gcf,sprintf(['Figures/' filename '.pdf']));
end
