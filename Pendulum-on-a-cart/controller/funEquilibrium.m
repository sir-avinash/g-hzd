function [response, sys, tStar, xStar, uStar] = funEquilibrium(x0, nNodes, L)
	%RUNUPRIGHT Runs n-link pendulum on a cart balance problem.
	%
	% Description:
	%   A n-link pendulum on a cart must perform a balancing maneuver
	%		consuming the least amount of energy as possible.
	%
	% Copyright 2013-2014 Mikhail S. Jones
	
	% Construct system model
	nLinks = 1;
	sys = PendulumCartSystemSymbolic(nLinks);
		
	% Construct trajectory optimization phase object
	nlp = sys.directCollocation(nNodes);
	
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
% 	t.lowerBound = 10^(-nLinks);
	t.lowerBound = 6;
	t.upperBound = 6;
	
	% Add objective
% 	nlp.addObjective(trapz(u^2 + x'*x, t));
% 	nlp.addObjective(t);
	nlp.addObjective(trapz(u'*u + x'*x +...
		10 * exp(-1*(x(1) + sys.xLim)) * x(1)^2 + ...
		10 * exp(1*(x(1) - sys.xLim)) * x(1)^2, t));
	
	nlp.addConstraint(0, x0 - x.initial, 0);
	
	% Add action interval constraints
% 	gamma = L*x([1, 3]).ind(ceil(nlp.nNodes/3));
% 	nlp.addConstraint(0, [pi/2;0] + gamma - x([2, 4]).ind(ceil(nlp.nNodes/3)), 0);
	
% 	gamma = L*x([1, 3]).ind(ceil(nlp.nNodes/3*2));
% 	nlp.addConstraint(0, [pi/2;0] + gamma - x([2, 4]).ind(ceil(nlp.nNodes/3*2)), 0);
	
	% Add final condition constraints
	nlp.addConstraint(0, x.final, 0);

	% Construct optimizer interface object, export and solve
	optim = Ipopt(nlp);
	optim.export;
	optim.solve;
	
	% Construct time response object
	response = nlp.getResponse;
	
	[tStar, xStar, uStar] = response.unpack;
	tStar = tStar{1}';
	uStar = uStar{1}';
	xStar = xStar{1}';
	
end % funEquilibrium
