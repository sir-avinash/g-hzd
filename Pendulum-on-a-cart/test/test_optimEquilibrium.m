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
	
	% Loop through disturbance
% 	d_xSet = assignDelta();
	d_xSet = [1 deg2rad(0) 0 0]';
	for n = 1:size(d_xSet,2)
% 	n = 1;
	d_x = d_xSet(:,n);
	
	% Construct trajectory optimization phase object
	nlp = sys.directCollocation(200);
	
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
		x(i).initialGuess = pi/2;
	end % for
	
	% Add minimum time
	t.lowerBound = 10^(-nLinks);
	t.upperBound = 2;
	
	% Add minimum time objective
	nlp.addObjective(trapz(u^2, t));
	
	% Add initial condition constraints	
	nlp.addConstraint(0, 0 + d_x(1)    - x(1).initial, 0);
	nlp.addConstraint(0, pi/2 + d_x(2) - x(2).initial, 0);
	nlp.addConstraint(0, 0 + d_x(3)    - x(3).initial, 0);
	nlp.addConstraint(0, 0 + d_x(4)    - x(4).initial, 0);
	
	
	% Add final condition constraints
	nlp.addConstraint(0, 0 - x(1).final, 0);
	nlp.addConstraint(0, pi/2 - x(2).final, 0);
	nlp.addConstraint(0, 0 - x(3).final, 0);
	nlp.addConstraint(0, 0 - x(4).final, 0);
	
	% Construct optimizer interface object, export and solve
	optim = Ipopt(nlp);
	optim.export;
	optim.solve;
	
	% Construct time response object
	response = nlp.getResponse;
	
	% Plot time response
	response.plot;
	
	% Construct and play animation
	scene = PendulumCartScene(sys, response);
	Player(scene);
	
	% Save the data
	formatOut = 'yy-mm-dd';
	folderDate = datestr(now,formatOut);
	base_path = fileparts(mfilename('fullpath'));
	folder_path = [base_path,'/DataFiles/',folderDate,'/'];
	if ~exist(folder_path, 'dir')
	   mkdir(folder_path);
	   addpath(folder_path);
	end
	vers = ['_d',num2str(n)];
	save([folder_path,['Response',date,vers]],'response');
	end
% end % runSwing
