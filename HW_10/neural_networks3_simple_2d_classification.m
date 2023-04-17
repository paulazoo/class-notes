%% Classifying 2d data using Neural networks in Matlab
%% Eli Tziperman, APM120, 201604

%% Specify data to be classified:
X=[2   7   0   7   4   3   9   1   8   4  10   6   4   5   2   3   5   8   3   4;
  10   6   7  10   8   1   3   4   4   1   1   7  10   8   0   0   2   4   6   9];
y=[3   3   1   3   3   1   2   1   2   1   2   3   3   3   1   1   2   2   1   3];

figure(1);clf
set(0,'defaulttextfontsize',16); set(0,'defaultaxesfontsize',16);
xlim([-1 11])
ylim([-1 11])
xlabel('x')
ylabel('y')
box on
for i=1:length(y)
  text(X(1,i),X(2,i),num2str(y(i)));
end
title('training data: Label as func of (x,y)');

% for classification, need to turn labels into matrix format:
T=zeros(max(y),length(y)); for i=1:length(y); T(y(i),i)=1; end; y=T;

%% Create network: specify number of neurons in each layer:
rng(3456);
clear net1
net1 = patternnet([3 3]);
disp('net1 = patternnet([3 3]);');
%% [e.g., [2 6 2] would create 3 hidden layers with 2,6,2 neurons in each]
net1.divideFcn=''; % don't divide data into training, testing, validation.

%% Train network:
net1 = train(net1,X,y);
disp('net1 = train(net1,X,y);');
view(net1);

%% use the trained network to classify a new point:
Xtest=[4 4]';
y1=net1(Xtest);
y1_label=vec2ind(y1);
disp('Xtest=[4 4]:');         disp(Xtest');
disp('y1=net1(Xtest):');      disp(y1');
disp('y1_label=vec2ind(y1):'); disp(y1_label);

pause
close all force
