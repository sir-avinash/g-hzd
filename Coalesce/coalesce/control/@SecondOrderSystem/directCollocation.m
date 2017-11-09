function [nlp,xddot1,xddot2,xddot3,xddot4,xddot5] = directCollocation(obj, nNodes, varargin)
%DIRECTCOLLOCATION Construct a trajectory optimization problem from system.
%
% Copyright 2014 Mikhail S. Jones

	% Parse input arguments
	parser = inputParser;
	parser.addOptional('method', 'Trapezoidal');
	parser.addOptional('modeSchedule', obj.modes(1));
	parser.addOptional('periodic', false, ...
		@(x) validateattributes(x, {'logical'}, {'scalar'}));
	parser.parse(varargin{:});
	opts = parser.Results;

	% Number of states, inputs and modes in schedule
	nx = numel(obj.states);
	nu = numel(obj.inputs);
	nm = numel(opts.modeSchedule);

	% Construct direct collocation optimization problem
	nlp = DirectCollocation(nNodes, ...
		'Name', 'Optimal Control Problem');

	for im = 1:nm
		% Current mode
		m = opts.modeSchedule{im};

		% Add time
		t = nlp.addTime;

		% Add input variables
		for iu = 1:nu
			u(iu,1) = nlp.addInput(0, obj.inputLowerBounds(iu), obj.inputUpperBounds(iu), ...
				'Description', obj.inputs{iu}, ...
				'Length', nNodes);
		end % for

		% Add state variables
		for ix = 1:nx/2
			x(ix,1) = nlp.addState(0, -Inf, Inf, ...
				'Description', obj.states{ix}, ...
				'Length', nNodes);
		end % for
		for ix = 1:nx/2
			xdot(ix,1) = nlp.addState(0, -Inf, Inf, ...
			'Description', obj.states{ix+nx/2}, ...
			'Length', nNodes);
		end % for

		% Compute collocated second order equations of motion
		[M, f] = obj.secondOrderStateEquation([], x, xdot, u, m);
        
		% Add slack variables
%     xddot = nlp.addVariable(zeros(numel(f), 1), -Inf(numel(f), 1), Inf(numel(f), 1), ...
%     	'Description', 'State Slack', ...
% 			'Length', nNodes);

        if im == 1
            xddot1 = nlp.addVariable(zeros(numel(f), 1), -Inf(numel(f), 1), Inf(numel(f), 1), ...
                'Description', 'State Slack', ...
                    'Length', nNodes);
                xddot = xddot1;
        elseif im == 2
            xddot2 = nlp.addVariable(zeros(numel(f), 1), -Inf(numel(f), 1), Inf(numel(f), 1), ...
                'Description', 'State Slack', ...
                    'Length', nNodes);
                xddot = xddot2;
        elseif im == 3
            xddot3 = nlp.addVariable(zeros(numel(f), 1), -Inf(numel(f), 1), Inf(numel(f), 1), ...
                'Description', 'State Slack', ...
                    'Length', nNodes);
                xddot = xddot3;
        elseif im == 4
            xddot4 = nlp.addVariable(zeros(numel(f), 1), -Inf(numel(f), 1), Inf(numel(f), 1), ...
                'Description', 'State Slack', ...
                    'Length', nNodes);
                xddot = xddot4;
        elseif im == 5
            xddot5 = nlp.addVariable(zeros(numel(f), 1), -Inf(numel(f), 1), Inf(numel(f), 1), ...
                'Description', 'State Slack', ...
                    'Length', nNodes);
                xddot = xddot5;
        else
            disp('Wrong Input')
        end

		% Enforce dynamic constraints
		if ~isempty(obj.constraintEquation(x, xdot, m))
			% Dynamic constraint Jacobian
			[g, G, Gq] = obj.constraintEquation(x, xdot, m);

			% Create Lagrange multiplier variables
			lambda = nlp.addVariable(zeros(numel(g), 1), -Inf(numel(g), 1), Inf(numel(g), 1), ...
    		'Description', 'Lagrange Multiplier', ...
				'Length', nNodes);
			nlp.phase(end).lambda = lambda;

			% Modify second order system
			f = f + G.'*lambda;

			% Position level constraint
			% nlp.addConstraint(0, g, 0, ...
			% 	'Description', 'Position Level');

			% Velocity level constraint
			% nlp.addConstraint(0, G*xdot, 0, ...
			% 	'Description', 'Velocity Level');

			% Acceleration level constraint
			nlp.addConstraint(0, G*xddot + Gq, 0, ...
				'Description', 'Acceleration Level');
		end % if

	  % Add slack variable defect constraints
    nlp.addConstraint(0, M*xddot - f, 0, ...
    	'Description', 'State Slack');

		% Add state equation constraints
        for ix = 1:(nx)/2
            
			% First order
			nlp.addPdeConstraint(x(ix), xdot(ix), t, ...
				'Method', opts.method, ...
				'Description', ['First Order Dynamics (' obj.states{ix} ')']);

			% Second order
%         end
%         for ix = 1:numel(f)
%         for ix = 1:nx/2
			nlp.addPdeConstraint(xdot(ix), xddot(ix), t, ...
				'Method', opts.method, ...
				'Description', ['Second Order Dynamics (' obj.states{ix} ')']);
        end % for

		% Link phases
		% TODO

	end % for
end % directCollocation
