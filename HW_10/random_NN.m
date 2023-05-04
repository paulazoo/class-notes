close('all')
X=[3,6,1,0,5,5,4,4,3,4,6,3,2,5,4,8,6,8, 9,8,3,6, 1,4,7,2,9,1,4,2,9,1,5;
9,1,5,7,5,5,2,2,2,0,2,4,1,2,9,8,8,10,1,3,4,6,10,7,2,7,4,9,4,6,8,9,4];
y=[2,3,1,1,3,3,3,3,1,3,3,1,1,3,2,2,2, 2,3,3,1,2, 1,2,3,1,2,1,1,1,2,1,3];

x1=[0:0.1:10];
x2=[0:0.1:10];

figure;clf
set(0,'defaulttextfontsize',16); set(0,'defaultaxesfontsize',16);
xlim([-1 11])
ylim([-1 11])
xlabel('x')
ylabel('y')
box on
for i=1:length(y)
  text(X(1,i),X(2,i),num2str(y(i)));
end
title('training data for value as func of (x,y)');

% for classification, need to turn labels into matrix format:
T=zeros(max(y),length(y)); for i=1:length(y); T(y(i),i)=1; end

% Create network: specify number of neurons in each layer:
rng(3456);
clear net1
% [e.g., [2 6 2] would create 3 hidden layers with 2,6,2 neurons in each]
net1 = feedforwardnet([3 3]); % 2 hidden layers with 3 neurons each. sure.
disp('net1 = feedforwardnet([3 3]);');

% don't divide data into training, testing, validation.
net1.divideFcn='';

% Train network:
net1 = train(net1,X,T);
disp('net1 = train(net1,X,T);');
view(net1);