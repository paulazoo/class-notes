clear all; close all
X=[3,6,1,0,5,5,4,4,3,4,6,3,2,5,4,8,6,8, 9,8,3,6, 1,4,7,2,9,1,4,2,9,1,5;
9,1,5,7,5,5,2,2,2,0,2,4,1,2,9,8,8,10,1,3,4,6,10,7,2,7,4,9,4,6,8,9,4];
y=[2,3,1,1,3,3,3,3,1,3,3,1,1,3,2,2,2, 2,3,3,1,2, 1,2,3,1,2,1,1,1,2,1,3];
x1=[0:0.1:10];
x2=[0:0.1:10];
[X1, X2]=meshgrid(x1, x2);
Xtest = [X1(:).'; X2(:).'];
%%
arch = [3 3 3 3 3 3 3];
%% Create network: specify number of neurons in each layer:
rng(1234);
clear net2
% [e.g., [2 6 2] would create 3 hidden layers with 2,6,2 neurons in each]
net2 = feedforwardnet(arch); % 2 hidden layers with 5 neurons each. sure.
disp('net2 = patternnet([6 6]);');

% don't divide data into training, testing, validation.
net2.divideFcn='';

% Train network:
net2 = train(net2,X,y);
disp('net2 = train(net2,X,y);');
view(net2);

ytest2=net2(Xtest);

figure; hold on
contourf(x1, x2, reshape(ytest2, size(X1)) )
colorbar
hold off

%% Create network: specify number of neurons in each layer:
rng(2023);
clear net2
% [e.g., [2 6 2] would create 3 hidden layers with 2,6,2 neurons in each]
net2 = feedforwardnet(arch); % 2 hidden layers with 5 neurons each. sure.
disp('net2 = patternnet([6 6]);');

% don't divide data into training, testing, validation.
net2.divideFcn='';

% Train network:
net2 = train(net2,X,y);
disp('net2 = train(net2,X,y);');
view(net2);

ytest2=net2(Xtest);

figure; hold on
contourf(x1, x2, reshape(ytest2, size(X1)) )
colorbar
hold off

%% Create network: specify number of neurons in each layer:
rng(3456);
clear net2
% [e.g., [2 6 2] would create 3 hidden layers with 2,6,2 neurons in each]
net2 = feedforwardnet(arch); % 2 hidden layers with 5 neurons each. sure.
disp('net2 = patternnet([6 6]);');

% don't divide data into training, testing, validation.
net2.divideFcn='';

% Train network:
net2 = train(net2,X,y);
disp('net2 = train(net2,X,y);');
view(net2);

ytest2=net2(Xtest);

figure; hold on
contourf(x1, x2, reshape(ytest2, size(X1)) )
colorbar
hold off