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
% sys = PendulumCartSystem(nLinks);
sys = PendulumCartSystemSymbolic(nLinks);
%%
A_xSet = assignOrbit();
% for m = 1:5:length(A_xSet)
for m = 11
folderDate = '17-07-24';	% 6 sec, 120 nodes
% folderDate = '17-07-26';	% 3 sec, 1200 nodes
% folderDate = '17-07-27';	% 6 sec, 1200 nodes
d = load(['OrbitLibrary_',folderDate,['_d',num2str(m)]]);
[tStar, xStar, uStar, mStar] = d.response.unpack;

% Loop through disturbance
% d_xSet = assignDeltaGrid();
d_xSet = assignDeltaGridReduced();
isSaveData = 1;

for n = 1:length(d_xSet)
% for n = 1;
	d_x = d_xSet(:,n);
% 	d_x = [-1, pi/6, -1, 0]';
	
	% Construct trajectory optimization phase object
	[nlp,xddot] = sys.directCollocation(120+1);
	
	% Decompose phase into states, inputs and duration
	x = nlp.phase.state;
	u = nlp.phase.input;
	t = nlp.phase.duration;
	
	% Set bounds
% 	x(1).lowerBound = -sys.xLim;
% 	x(1).upperBound = sys.xLim;
	
	% Set initial guess
	t.initialGuess = 2;
	for i = (1:nLinks) + 1
		x(i).initialGuess = 0;
	end % for
	
	% Add minimum time
	t.lowerBound = 6;
	t.upperBound = 6;
	
	% Add initial condition constraints
% 	L = zeros(2);
% 	L = [0 0; 0 0.5911];	% library fitting 2second period
	L = [0.0316    0.1084; 0.0000    0.0000]; % back stepping Q = 1, R = 1000

	H = [1 0 0 0; L(1,1) 0 L(1,2) 0; 0 0 1 0; L(2,1) 0 L(2,2) 0];
	d_x = H*d_x;
	
	nlp.addConstraint(0, d_x - x.initial, 0);
% 	nlp.addConstraint(0, xStar{1}(:,1) + d_x - x.initial, 0);

	% Add action interval constraints
	gamma = L*x([1, 3]).ind(ceil(nlp.nNodes/3));
% 	gamma = L*(x([1, 3]).ind(ceil(nlp.nNodes/3)) - xStar{1}([1, 3],end)) + xStar{1}([2, 4],end);
	nlp.addConstraint(0, gamma - x([2, 4]).ind(ceil(nlp.nNodes/3)), 0);
	
	% Add final condition constraints
	nlp.addConstraint(0, xStar{1}(:,end) - x.final, 0);
	
	% Add objective
    p_x = nlp.addVariable(zeros(4,1), -Inf(4,1), Inf(4,1), ...
    	'Description', 'State p', ...
			'Length', nlp.nNodes);
	nlp.addConstraint(xStar{1}(1,:), x(1) - p_x(1), xStar{1}(1,:));
	nlp.addConstraint(xStar{1}(2,:), x(2) - p_x(2), xStar{1}(2,:));
	nlp.addConstraint(xStar{1}(3,:), x(3) - p_x(3), xStar{1}(3,:));
	nlp.addConstraint(xStar{1}(4,:), x(4) - p_x(4), xStar{1}(4,:));
	
	p_u = nlp.addVariable(0, -Inf, Inf, ...
	'Description', 'State p', ...
		'Length', nlp.nNodes);
	nlp.addConstraint(uStar{1}, u - p_u, uStar{1});

% 	nlp.addObjective(t);
% 	nlp.addObjective(trapz(u^2, t));
% 	nlp.addObjective(trapz(u^2 + p_x'*p_x, t));
% 	nlp.addObjective(trapz(p_u'*p_u + p_x'*p_x, t));	
	nlp.addObjective(trapz(p_u'*p_u + p_x'*p_x +...
		10 * exp(-1*(x(1) + sys.xLim)) * x(1)^2 + ...
		10 * exp(1*(x(1) - sys.xLim)) * x(1)^2, t));

	
	% Construct optimizer interface object, export and solve
	optim = Ipopt(nlp);
	optim.export;
	optim.solve;
	
	%% Check if find proper solution
	if optim.info.status == 0 || 1
% 	if optim.info.status == 0
		
		% Construct time response object
		response = nlp.getResponse;
		disp(n)
		% Plot time response
		response.plot;
		movegui(gca,[2000,0])
		
		% Construct and play animation
		scene = PendulumCartScene(sys, response);
		Player(scene, [], [], []);
		movegui(gca,[500,0])
		
		if isSaveData % Save the data
		formatOut = 'yy-mm-dd';
		folderDate = datestr(now,formatOut);
		base_path = fileparts(mfilename('fullpath'));
		folder_path = [base_path,'/DataFiles/',folderDate,'/'];
		if ~exist(folder_path, 'dir')
			mkdir(folder_path);
			addpath(folder_path);
		end
		vers = ['_b',num2str(n),'_o',num2str(m)];
		xddot = squeeze(eval(xddot));
		J = eval(nlp.objective.expression);	% evaluate cost function
		save([folder_path,['Response_',folderDate,vers]],'response','xddot', 'J');
		end
		
	else
% 		load gong.mat;
% 		sound(y);
		disp('Cannot find optimal solution');
		disp('dx = ')
		disp(d_x);
	end
	
end		% for n
end		% for m

if isSaveData % Save the data
% save([folder_path,['D_xSet_',folderDate]],'d_xSet');
% save([folder_path,['D_aSet_',folderDate]],'A_xSet');
save([folder_path,['DataSet_',folderDate]],'A_xSet','d_xSet');
end