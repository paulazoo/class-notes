%% Example application of SVD-based polar decomposition of a
%% matrix (Strang p 367), demonstrating the stretching and rotation
%% of a geometric object. 
%% A = U*S*V^T=(U*S*U^T) * (U*V^T) = STRETCH * ROTATE
%%   = positive definite stretching * rotation.
%% Eli, 201702

clear all; figure(1); clf
set(0,'defaulttextfontsize',14);
set(0,'defaultaxesfontsize',14);
plot_A_eigenvectors=1;

%% build the matrix:
theta=70; Ra=[cosd(theta), -sind(theta); sind(theta), cosd(theta)];
theta=20; Rb=[cosd(theta), -sind(theta); sind(theta), cosd(theta)];
Sa=Rb*[1.2, 0; 0, 0.3]*Rb';
A=Sa*Ra;

%% prepare for plotting by calculating eigenvectors of S:
[U1,D1]=eig(Sa);
U1=real(U1);

%% polar decomposition: A=STRETCH*ROTATE
[U,S,V]=svd(A);
ROTATE=(U*V');
STRETCH=(U*S*U');
my_fprintf_array(A);
my_fprintf_array(U);
my_fprintf_array(S);
my_fprintf_array(V);
my_fprintf_array(ROTATE);
my_fprintf_array(STRETCH);

%% prepare to plot eigenvectors of A:
%[U1,D1]=eig(A);

%% Specify coordinates of points (vectors) at corners of a poligon:
Corners=[1, 7, 0,-1, 2
        -5, 2, 4, 0, 0];
%% draw lines, made of sets of points, between each two consecutive corners:
R=[0:0.01:1;0:0.01:1];
NR=length(R);
Ncorners=length(Corners(1,:));
start=1;
for j=1:Ncorners
  jm1=j-1;
  %% the first line is between the last and first corners:
  if j==1
    jm1=Ncorners;
  end
  X(:,start:start+NR-1)=Corners(:,jm1)+R.*(Corners(:,j)-Corners(:,jm1));
  start=start+length(R(1,:));
end
NX=length(X(1,:));

%% Transformation by A:
disp('Y_A(:,i)=A*X(:,i);')
for i=1:NX
  Y_A(:,i)=A*X(:,i);
end

%% Transformation by ROTATE:
disp('Y_ROTATE(:,i)=ROTATE*X(:,i);')
for i=1:NX
  Y_ROTATE(:,i)=ROTATE*X(:,i);
end

%% Transformation by STRETCH:
disp('Y_STRETCH(:,i)=STRETCH*X(:,i);')
for i=1:NX
  Y_STRETCH(:,i)=STRETCH*X(:,i);
end

%% Transformation by ROTATE & STRETCH:
disp('Y_ROTATE_STRETCH(:,i)=STRETCH*Y_ROTATE(:,i);')
for i=1:NX
  Y_ROTATE_STRETCH(:,i)=STRETCH*Y_ROTATE(:,i);
end

%% find ranges of x and y axes that can contain all shapes:
xmax=max([X(1,:),Y_A(1,:),Y_ROTATE(1,:),Y_STRETCH(1,:)]);
xmin=min([X(1,:),Y_A(1,:),Y_ROTATE(1,:),Y_STRETCH(1,:)]);
ymax=max([X(2,:),Y_A(2,:),Y_ROTATE(2,:),Y_STRETCH(2,:)]);
ymin=min([X(2,:),Y_A(2,:),Y_ROTATE(2,:),Y_STRETCH(2,:)]);

%% plot X:
subplot(2,3,1)
plot(X(1,:),X(2,:),'.')
xlim([xmin xmax]);
ylim([ymin ymax]);
hold on
if 0% plot_A_eigenvectors;
  plot(10*[0 U1(1,1)],10*[0,U1(2,1)],'-r','linewidth',2);
  plot(10*[0 U1(1,2)],10*[0,U1(2,2)],'-r','linewidth',2);
end
axis equal; grid on
title('original shape x_i')
pause

%% plot Y:
subplot(2,3,3)
plot(Y_A(1,:),Y_A(2,:),'.')
xlim([xmin xmax]);
ylim([ymin ymax]);
hold on
if 0 % plot_A_eigenvectors;
  plot(10*[0 U1(1,1)],10*[0,U1(2,1)],'-r','linewidth',2);
  plot(10*[0 U1(1,2)],10*[0,U1(2,2)],'-r','linewidth',2);
end
axis equal; grid on
title('A*x_i')
pause

%% plot Y_ROTATE:
subplot(2,3,4)
plot(Y_ROTATE(1,:),Y_ROTATE(2,:),'.')
xlim([xmin xmax]);
ylim([ymin ymax]);
hold on
if 0 % plot_A_eigenvectors;
  plot(10*[0 U1(1,1)],10*[0,U1(2,1)],'-r','linewidth',2);
  plot(10*[0 U1(1,2)],10*[0,U1(2,2)],'-r','linewidth',2);
end
axis equal; grid on
title('ROTATE*x_i')
pause

%% plot Y_STRETCH:
subplot(2,3,5)
plot(Y_STRETCH(1,:),Y_STRETCH(2,:),'.')
xlim([xmin xmax]);
ylim([ymin ymax]);
hold on
if plot_A_eigenvectors;
  plot(5*[0 U1(1,1)],5*[0,U1(2,1)],'-r','linewidth',2);
  plot(5*[0 U1(1,2)],5*[0,U1(2,2)],'-r','linewidth',2);
end
axis equal; grid on
title('STRETCH*x_i')
pause

%% plot Y_ROTATE_STRETCH:
subplot(2,3,6)
plot(Y_ROTATE_STRETCH(1,:),Y_ROTATE_STRETCH(2,:),'.')
xlim([xmin xmax]);
ylim([ymin ymax]);
hold on
if 0 % plot_A_eigenvectors;
  plot(10*[0 U1(1,1)],10*[0,U1(2,1)],'-r','linewidth',2);
  plot(10*[0 U1(1,2)],10*[0,U1(2,2)],'-r','linewidth',2);
end
axis equal; grid on
title(' STRETCH*ROTATE*x_i')

if 0
  %% save as pdf:
  set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [5 4]);
  set(gcf, 'PaperPosition', [0 0 5 4]); % [left, bottom, width, height];
  saveas(gcf,sprintf('Figures/Figure-polar-decomposition-geometric-interpretation.pdf'));
end
