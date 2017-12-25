function [X0, q0, dq0, u_ff] = getDennisOptimizationData(DataFile)

%% 'DataFiveStep_22-May-2015v1noRobust'
% DennisOptimizationData = matfile(['H:\Research\Optimization\DataFiles\',DataFile,'.mat']);
DennisOptimizationData = matfile([DataFile,'.mat']);
% DennisOptimizationData = matfile('H:\Research\Optimization\coalesce-alpha_fromLaptop0521\DataFiles\DataFiveStep_22-May-2015v1noRobust.mat');
xdot = DennisOptimizationData.xdot1;
x = DennisOptimizationData.x1;
dqminus = xdot(end,:)';
dthetaminus = -[0 0 1 1/2 1/2 0 0]*dqminus;
alpha = DennisOptimizationData.alpha;
X0 = [dthetaminus reshape(alpha(:,3:6)',1,16)]';

q0 = x(1,:);
dq0 = xdot(1,:);
u_ff = DennisOptimizationData.u1;
