function [alpha,theta_limits] = getDennisOptimizationData_Transition(DataFile)

%% 'DataFiveStep_22-May-2015v1noRobust'
% DennisOptimizationData = matfile(['H:\Research\Optimization\DataFiles\',DataFile,'.mat']);
DennisOptimizationData = matfile([DataFile,'.mat']);

alpha = DennisOptimizationData.alpha;
x = DennisOptimizationData.x1;

T = [0 0 1 1/2 1/2 0 0];
theta0 = T*x(1,:)';
thetaf = T*x(end,:)';
theta_limits = [theta0, thetaf];

