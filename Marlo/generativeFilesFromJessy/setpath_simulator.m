%%%% setpath_simulator
%%% Jessy Grizzle
% Modified by Brent April 17th, 2013 as a learning excercise.



% base_path=pwd;
base_path='D:\Documents\Folder\MARLO\simulation\BAG_ATRIAS-2D_Simulator_RigidGround_NewParameters_v03'; % Added this code to hardline base_path since I was getting error when debugging.
addpath([base_path,'/BezierFiles/ChingLong'])
addpath([base_path,'/BezierTools'])
addpath([base_path,'/FeedbackController'])
addpath([base_path,'/Graphics'])
addpath([base_path,'/ImpactModel'])
addpath([base_path,'/KinematicsVelocities'])  % geometric points on the robot, velocities
addpath([base_path,'/LagrangeModel'])  %Main model files 
addpath([base_path,'/Mat'])
addpath([base_path,'/MexedFiles'])
addpath([base_path,'/ModelParameters'])
addpath([base_path,'/ZeroDynamicsFiles'])

%addpath(genpath(cd))  % add all subdirectories to path

