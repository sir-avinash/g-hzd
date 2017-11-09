function net = NNtraining(x,t, min_grad)

% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created Sat Aug 20 07:08:31 EDT 2016
%
% This script assumes these variables are defined:
%
%   s - input data.
%   y_array - target data.


% for element = 1:24
% for element = 1

% x = s;
% t = y_array(element,:);
% t = y_array;

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. NFTOOL falls back to this in low memory situations.
trainFcn = 'trainlm';  % Levenberg-Marquardt

% Create a Fitting Network
hiddenLayerSize = 5;
net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 100/100;
net.divideParam.valRatio = 0/100;
net.divideParam.testRatio = 0/100;
net.trainParam.epochs = 1e4;
net.trainParam.min_grad = min_grad;
net.trainParam.max_fail = 1e3;

% Train the Network
[net,tr] = train(net,x,t);

% View the Network
% view(net)

% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotfit(net,x,t)
% figure, plotregression(t,y)
% figure, ploterrhist(e)

%%
% Test the Network
% s_dense = 0:1e-3:1;
% y = net(s_dense);
% % e = gsubtract(t,y);
% % performance = perform(net,t,y)
% for element = 1:24
% % for element = 1
% figure(element)
% plot(x,t(element,:),'*-');hold on
% plot(s_dense,y(element,:));hold off
% % plot(x,t,'*-');hold on
% % plot(x,y);hold off
% % drawnow()
% % pause(1)
% end
