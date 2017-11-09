warning('off','MATLAB:dispatcher:pathWarning');	% Suppress Warnings: Warning: Duplicate directory name: C:\Program Files\MATLAB\R2016a_trial\toolbox\stateflow\stateflow
restoredefaultpath

%%
base_path = fileparts(mfilename('fullpath'));
addpath(...
		genpath(base_path), ...
		genpath([fileparts(base_path),'/Global Util'])...
		);
rmpath([base_path, '/archive'])
run([fileparts(base_path), '/Coalesce/startCoalesce']); 

%%
set(0,'defaulttextinterpreter','latex')