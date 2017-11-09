clear
%RUNUPRIGHT Runs n-link pendulum on a cart balance problem.
%
% Description:
%   A n-link pendulum on a cart must perform a balancing maneuver
%		consuming the least amount of energy as possible.
%
% Copyright 2013-2014 Mikhail S. Jones

% Construct system model
nLinks = 1;
sys = PendulumCartSystem(nLinks);

% Loop through orbits
A_xSet = assignOrbit();
isSaveData = 1;

	for n = 1:length(A_xSet)
% for n = 11;
	
	% Construct trajectory optimization phase object
	nlp = sys.directCollocation(1200+1);
	
	% Decompose phase into states, inputs and duration
	x = nlp.phase.state;
	u = nlp.phase.input;
	t = nlp.phase.duration;
	
	% Set bounds
	x(1).lowerBound = -sys.xLim;
	x(1).upperBound = sys.xLim;
	
	% Set initial guess
	t.initialGuess = 2;
	for i = (1:nLinks) + 1
		x(i).initialGuess = 0;
	end % for
	
	% Add minimum time
	t.lowerBound = 6;
	t.upperBound = 6;
	
	% Define the orbit for xdot
% 	w = 3;
% 	orbit = A_xSet(n)*sin(2*pi*w*(0:nlp.nNodes - 1)/(nlp.nNodes - 1));
% 	nlp.addConstraint(orbit, x(1), orbit);
	
	w = 3;
	orbit = A_xSet(n)*cos(2*pi*w*(0:nlp.nNodes - 1)/(nlp.nNodes - 1));
	nlp.addConstraint(orbit, x(3), orbit);
	
	% Add orbit constraints
	nlp.addConstraint(0, x.initial - x.final, 0);

	% Add objective
	x_d = 0;
	nlp.addObjective(trapz(u^2 + (x-[x_d 0 0 0]')'*(x-[x_d 0 0 0]'), t));
% 	nlp.addObjective(trapz(u^2, t));

	% Construct optimizer interface object, export and solve
	optim = Ipopt(nlp);
	optim.export;
	optim.solve;
	
	%% Check if find proper solution
	if optim.info.status == 0 || 1
		
		% Construct time response object
		response = nlp.getResponse;
		
		% Plot time response
		response.plot;
		
		% Construct and play animation
		scene = PendulumCartScene(sys, response);
		Player(scene, [], [], []);
		movegui(gca,[2000,0])
		
		if isSaveData % Save the data
		formatOut = 'yy-mm-dd';
		folderDate = datestr(now,formatOut);
		base_path = fileparts(mfilename('fullpath'));
		folder_path = [base_path,'/DataFiles/',folderDate,'/'];
		if ~exist(folder_path, 'dir')
			mkdir(folder_path);
			addpath(folder_path);
		end
		vers = ['_d',num2str(n)];
		save([folder_path,['OrbitLibrary_',folderDate,vers]],'response');
		end
		
	else
% 		load gong.mat;
% 		sound(y);
		disp('Cannot find optimal solution');
		disp('dx = ')
		disp(d_x);
	end
	
end
% end % runSwing

if isSaveData % Save the data
save([folder_path,['Library_xSet_',folderDate]],'A_xSet');
end