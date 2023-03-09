%% Example application of SVD-based polar decomposition to animation
%% Eli, 201904

set(0,'defaulttextfontsize',12);
set(0,'defaultaxesfontsize',12);

make_hard_copy=0; % 1 to make a pdf, 0 for an animation.
if make_hard_copy
  trange=0:1/7.0:1.001;
  N_animation_cycles=1;
  mycolors=jet(length(trange));
else
  trange=0:0.01:1;
  N_animation_cycles=10;
  mycolors=jet(length(trange));
end


%% build the transformation matrix:
%% rotation:
theta0=140*pi/180; 
R=[cos(theta0), -sin(theta0), 0; 
   sin(theta0),  cos(theta0), 0;
   0          ,   0        ,  1];
%% stretching
S=[2, 0, 0; 0, 0.5, 0; 0, 0, 1];
%% and translation:
T=[1, 0, -5; 0, 1, -0.5; 0, 0, 1]
M=T*R*S; % full transformation
A=R*S; % rotation and scaling only


%% Specify coordinates of points (vectors) along a smiley shape:
clear X
i=0;
for t=0:0.01:2*pi
  i=i+1;
  X(:,i)=2*[1 + cos(t); 1 + sin(t)];
  i=i+1;
  X(:,i)=[2 - cos(t/2); 2 - sin(t/2)];
  i=i+1;
  X(:,i)=[1 + cos(t)/10; 3 + sin(t)/10];
  i=i+1;
  X(:,i)=[3 + cos(t)/10; 3 + sin(t)/10];
end
N=length(X(1,:));
% remove mean:
X=X-mean(X')';
% scale:
X=X/3;
% add a 3rd coordinate of ones:
X=[X;ones(1,N)];


%% polar decomposition: A=STRETCH*ROTATE
[U,Sigma,V]=svd(A);
ROTATE=(U*V');
%% extract rotation angle:
theta=acos(ROTATE(1,1));
theta_degree=theta*180/pi;
STRETCH=(V*Sigma*V');


%% create animation sequences in two ways, (1) via polar decomposition
%% and (2) via the full transformation matrix:
I=eye(3);
figure(1); clf
h1=0; h2=0;
for loop_animations=1:N_animation_cycles
  it=0;
  for t=trange
    it=it+1;

    %% (1) via polar decomposition:
    subplot(1,2,1); 
    if make_hard_copy==0;
      if h1~=0; delete(h1); end
    end
    ROTATE_t=[cos(theta*t), -sin(theta*t), 0; 
              sin(theta*t), cos(theta*t), 0;
              0,            0,            1];
    %% linearly interpolate stretching, and gradual rotation:
    disp(size(ROTATE_t))
    disp(size(STRETCH))
    disp(size(T))
    disp(size(X))
    Y_A1=(t*T+(1-t)*I)*ROTATE_t*(t*STRETCH+(1-t)*I)*X;
    Y_A_final=M*X;

    %% plot transformed image:
    h1=plot(Y_A1(1,:),Y_A1(2,:),'.','color',mycolors(it,:),'MarkerSize',0.5);
    hold on
    h3=plot(Y_A_final(1,:),Y_A_final(2,:),'r.','MarkerSize',0.5);
    axis equal; grid on
    xlim([-6, 1]);
    ylim([-2, 1]);
    title('$(t T+(1-t)I)R(t\theta)(t S+(1-t)I)\mathbf{x}_i$','interpreter','LaTeX')


    %% (2) via interpolated full transformation matrix M:
    subplot(1,2,2);
    if make_hard_copy==0;
      if h2~=0; delete(h2); end
    end
    %% linearly interpolate the transformation matrix:
    Y_A2=(t*M+(1-t)*I)*X;
    
    %% plot Y:
    h2=plot(Y_A2(1,:),Y_A2(2,:),'.','color',mycolors(it,:),'MarkerSize',0.5);
    hold on
    h3=plot(Y_A_final(1,:),Y_A_final(2,:),'r.','MarkerSize',0.5);
    axis equal; grid on
    xlim([-6 1]);
    ylim([-2 1]);
    title('$(tM+(1-t) I){\bf x}_i$','interpreter','LaTeX')
    pause(0.02)
    if loop_animations==1 && t==0; pause; end
  end
end

if make_hard_copy
  %% save as pdf:
  set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [8 4]);
  set(gcf, 'PaperPosition', [0 0 8 4]); % [left, bottom, width, height];
  saveas(gcf,sprintf('Figure-polar-decomposition-animation.pdf'));
end
