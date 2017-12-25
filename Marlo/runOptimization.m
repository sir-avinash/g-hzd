% RUNWALK Runs the walking optimization on ATRIAS system.
%
% Copyright 2013-2014 Mikhail S. Jones

% Clean up the workspace
clear all;

for mm = 0	% step height
% 	for nn = 0.4*[0.2 0.6 1 1.4 1.8] % step length
	for nn = 0.2 % step length
		
		% == Params Panel ==
		SaveData = 1;
		height = round(mm*100)/100;	% round up for file saving
		stepLength = round(nn*100)/100;
		vers = ['_day_l0',num2str(stepLength*100),'h0',num2str(height*100)];
		
		lb0 = -1e-8;	% equality constraint bound
		ub0 =  1e-8;
		
		tic
		
		% Construct system model
		sys = AtriasSystem;
		
		% Friction coefficient (ground)
		kf = 0.4;
		
		% Relabeling matrix
		R = [1 0 0 0 0 0 0;
			0 1 0 0 0 0 0;
			0 0 1 0 0 0 0;
			0 0 0 0 0 1 0;
			0 0 0 0 0 0 1;
			0 0 0 1 0 0 0;
			0 0 0 0 1 0 0;];
		
		nNodes = 20;
		
		% Construct trajectory optimization phase object
		[nlp,xddot1] = sys.directCollocation_diffNodes(nNodes, ... % Number of nodes
			'method', 'trapezoidal', ... % Integration method (implicit euler, explicit euler, trapezoidal (default))
			'modeSchedule', {'ss'},'periodic', true);
		
		% Decompose phase into states, inputs and duration
		Phase2States4
		
		% Set initial solution
		load('InitialDataOneStep_21-Sep-2016_day_l030h00')
		nlp.initialGuess = NLPsolution;
		% InitialGuess4 %(if no initial mat)
		
		% Joint hard stop limits
		JointConstraint4
		
		% ==Impact map for phase 1==
		[D, ~] = sys.secondOrderStateEquation(0, x1.final, xdot1.final, u1.final, '');
		[g, G, ~] = sys.constraintEquation(x1.final, xdot1.final, 'ds');
		G = G(3:4,:);
		M = [D, -G.'; G, zeros(2)];
		f = [D*xdot1.final; zeros(2,1)];
		dxe1 = nlp.addVariable(zeros(7,1), -Inf(7,1), Inf(7,1));
		Fe1 = nlp.addVariable(zeros(2,1), -Inf(2,1), Inf(2,1), ...
			'Description', 'Impact Forces');
		nlp.addConstraint(lb0, M*[dxe1; Fe1] - f, ub0);
		
		if 1 % Periodic gait
			% Add connected constraint, phase 1 to 1
			p = R*x1.final - x1.initial;
			nlp.addConstraint(lb0, p(3:7), ub0); % Match everything except x position
			nlp.addConstraint(lb0, R*dxe1 - xdot1.initial, ub0); % Match velocities with impact
		end
		
		% Friction Cone
		FrictionCone4
		
		% Add Objective
		nlp.clearObjective.addObjective(trapz(u1'*u1, t1)/stepLength);
		
		% Construct optimizer interface object, export and solve
		optim = Ipopt(nlp);
		optim.export;
		ConstrucTime = toc;
		
		tic;
		optim.solve;
		
		% Construct time response object
		response = nlp.getResponse;
		
		% Plot time response
		response.plot;
		
		% Construct and play animation
		interval = 0.5;
		Length = -10:interval:100;
		Height = zeros(1,length(Length));
		shape = 'linear';
		scene = AtriasScene(sys, response);
		Player(scene, Length, Height, shape);
		
		IterTime = toc;
		
		disp(['Construct Time = ',num2str(ConstrucTime)])
		disp(['Iter Timer = ',num2str(IterTime)])
		disp(['Average Speed = ',num2str(eval((stepLength)/(t1)))])
		disp(['Step Length = ', num2str(eval(g1_final(3)))])
		disp(['Time = ', num2str(eval(t1))])
		disp(['Impact = ', num2str(eval(Fe1(2)))])
		
		%% Save alpha data
		if SaveData
			% Save solution
			NLPsolution = nlp.solution;
			InitialDataOneStep = ['InitialDataOneStep_',date,vers];
			base_path = fileparts(fileparts(fileparts(mfilename('fullpath'))));
			save([base_path,'\DDAcontroller\DataFiles\',InitialDataOneStep],'NLPsolution');
			save([base_path,'\DDAcontroller\DataFiles\',['Response',date,vers]],'response');
			
			%  Save for trajectory fitting
			DataOneStep = ['DataOneStep_',date,vers];
			filename = [base_path,'\DDAcontroller\DataFiles\',DataOneStep];
			saveData2(x1,xdot1,xddot1,t1,u1,filename);
		end
	end % for loop n
end % for loop m
