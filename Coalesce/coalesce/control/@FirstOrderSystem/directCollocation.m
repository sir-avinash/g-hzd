function nlp = directCollocation(obj, nNodes, varargin)
%DIRECTCOLLOCATION Construct a trajectory optimization problem from system.
%
%	Syntax:
%		nlp = obj.directCollocation(nNodes)
%
% Required Input Arguments:
%		nNodes - (DOUBLE) The number of nodes used in the transcription
%
% Optional Input Arguments:
%		method - (CHAR) Integration method
%		modeSchedule - (CELL) Dynamic mode schedule for hybrid systems
%		periodic - (LOGICAL) Sets whether the boundary conditions should be constrained
%
% Copyright 2014 Mikhail S. Jones

	% Parse input arguments
	parser = inputParser;
	parser.addOptional('method', 'Trapezoidal');
	parser.addOptional('modeSchedule', obj.modes(1), ...
		@(x) ischar(validatestring(x, obj.modes)));
	parser.addOptional('periodic', false, ...
		@(x) validateattributes(x, {'logical'}, {'scalar'}));
	parser.parse(varargin{:});
	opts = parser.Results;

	% Number of states, inputs and modes in schedule
	nx = numel(obj.states);
	nu = numel(obj.inputs);
	nm = numel(opts.modeSchedule);

	% Construct direct collocation optimization problem
	nlp = DirectCollocation(nNodes, 'Name', 'Optimal Control Problem');

	for im = 1:nm
		% Current mode
		m = opts.modeSchedule{im};

		% Add time variable
		t = nlp.addTime;

		% Add input variables
		for iu = 1:nu
			u(iu,1) = nlp.addInput(0, obj.inputLowerBounds(iu), obj.inputUpperBounds(iu), ...
				'Description', obj.inputs{iu}, ...
				'Length', nNodes);
		end % for

		% Add state variables
		for ix = 1:nx
			x(ix,1) = nlp.addState(0, -Inf, Inf, ...
				'Description', obj.states{ix}, ...
				'Length', nNodes);
		end % for

		% Evaluate state equations
		xdot = obj.stateEquation([], x, u, m);

		% Add state equation constraints
		for ix = 1:nx
			nlp.addPdeConstraint(x(ix), xdot(ix), t, ...
				'Method', opts.method, ...
				'Description', ['First Order Dynamics (' obj.states{ix} ')']);
		end % for
	end % for
end % directCollocation
