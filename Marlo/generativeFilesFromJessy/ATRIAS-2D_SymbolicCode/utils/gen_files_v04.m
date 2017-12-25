function gen_files_v04(path,SymbMatFile)
%
% Example call sequence from the utils directory  
% CWD=pwd; 
% cd utils
% gen_files_v04(CWD,'TempSymbolicDataRight')
%
if(nargin < 1)
    path = '..\ATRIAS-3D_SymbolicCode' ;
end
if nargin < 2
    % Load symbolic data
load([path '\Mat\TempSymbolicData']) ;
end
% Set various paths
% Relative Paths
m_path = [path '\autogen\m\'] ;
c_path = [path '\autogen\cpp\'] ;
% Absolute Paths
boost_path = 'C:\Program Files\boost\boost_1_36_0' ;
matlab_include_path = 'C:\Program Files\MATLAB\R2008a\extern\include' ;
matlab_link_path = 'C:\Program Files\MATLAB\R2008a\extern\lib\win32\microsoft' ;
mexversion_rc_path = 'C:\Program Files\MATLAB\R2008a\extern\include' ;

% Create directories if they do not exist
if(~exist(m_path, 'dir'))
    mkdir(m_path) ;
end
if(~exist(c_path, 'dir'))
    mkdir(c_path) ;
end
load(['..\Mat\',SymbMatFile])

% Usually writing these files can be at the same place where the symbolic
% variables are developed.
% Generate replacment lists for m and c files.
[c_list_q m_list_q] = gen_c_m_lists(q, 'q') ;
[c_list_dq m_list_dq] = gen_c_m_lists(dq, 'dq') ;

% Write m files
tic,write_fcn_m([m_path 'fcn_',Model,'_Atrias_D.m'],{'q', 'dq'},[m_list_q;m_list_dq],{D,'D'});toc
tic,write_fcn_m([m_path 'fcn_',Model,'_Atrias_Cdq.m'],{'q', 'dq'},[m_list_q;m_list_dq],{Cdq,'Cdq'});toc
tic,write_fcn_m([m_path 'fcn_',Model,'_Atrias_G.m'],{'q', 'dq'},[m_list_q;m_list_dq],{G,'G'});toc
tic,write_fcn_m([m_path 'fcn_',Model,'_Atrias_B.m'],{'q', 'dq'},[m_list_q;m_list_dq],{B,'B'});toc
%tic,write_fcn_m([m_path 'fcn_',Model,'_Atrias_tau_yaw.m'],{'q', 'dq'},[m_list_q;m_list_dq],{tau_yaw,'tau_yaw'});toc

% Write cpp files
tic,write_fcn_c([c_path 'fcn_',Model,'_Atrias_D.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{D,'D'});toc
tic,write_fcn_c([c_path 'fcn_',Model,'_Atrias_Cdq.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{Cdq,'Cdq'});toc
tic,write_fcn_c([c_path 'fcn_',Model,'_Atrias_G.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{G,'G'});toc
tic,write_fcn_c([c_path 'fcn_',Model,'_Atrias_B.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{B,'B'});toc
%tic,write_fcn_c([c_path 'fcn_',Model,'_Atrias_tau_yaw.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{tau_yaw,'tau_yaw'});toc

% Write Points Files
outputsPrimaryPointsVector = gen_points(PrimaryPointsVector, StringPrimaryPointsVector) ;
tic,write_fcn_m([m_path 'fcn_',Model,'_PrimaryPoints.m'],{'q'},[m_list_q],outputsPrimaryPointsVector) ;toc
tic,write_fcn_c([c_path 'fcn_',Model,'_PrimaryPoints.cpp'],{'q'},[c_list_q],outputsPrimaryPointsVector) ;toc

outputsComPointsVector = gen_points(ComPointsVector, StringComPointsVector) ;
tic,write_fcn_m([m_path 'fcn_',Model,'_ComPoints.m'],{'q'},[m_list_q],outputsComPointsVector) ;toc
tic,write_fcn_c([c_path 'fcn_',Model,'_ComPoints.cpp'],{'q'},[c_list_q],outputsComPointsVector) ;toc

outputsJacobians = gen_points(Jacobians, StringJacobians) ;
tic,write_fcn_m([m_path 'fcn_',Model,'_Jacobians.m'],{'q', 'dq'},[c_list_q;c_list_dq],outputsJacobians) ;toc
tic,write_fcn_c([c_path 'fcn_',Model,'_Jacobians.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],outputsJacobians) ;toc

outputsVelocities = gen_points(Velocities, StringVelocities) ;
tic,write_fcn_m([m_path 'fcn_',Model,'_Velocities.m'],{'q', 'dq'},[c_list_q;c_list_dq],outputsVelocities) ;toc
tic,write_fcn_c([c_path 'fcn_',Model,'_Velocities.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],outputsVelocities) ;toc

% Method 1
%genVCSoln(c_path, boost_path, matlab_include_path, matlab_link_path, mexversion_rc_path) ;

% Method 2
% Compile cpp files to mex
% ASSUMES mex -setup has been run and a compiler choosen.
filenames_cpp = dir([c_path,'*',Model,'*.cpp']) ;
for j=1:length(filenames_cpp)
    tic
    disp(['Compiling ' filenames_cpp(j).name]) ;
    eval_str = ['mex -I' '"' boost_path '"' ' ' c_path 'C' filenames_cpp(j).name(1:end-3) 'cxx' ' ' c_path filenames_cpp(j).name ' -outdir ' c_path] ;
    eval(eval_str) ;
    toc
end

% add all subdirectories to path
addpath(genpath(cd)) ;

end