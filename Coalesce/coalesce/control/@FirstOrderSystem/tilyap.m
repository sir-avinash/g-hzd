function P = tilyap(obj, point, varargin)
%TILYAP Time Invariant Lyapunov.
%
% Syntax:
%		P = obj.tilyap(point, Q)
%
% Required Input Arguments:
%		point - (POINT) Fixed point for the dynamical system
%
% Optional Input Arguments:
%		Q - (DOUBLE)
%
% Copyright 2014 Mikhail S. Jones

	% Number of states and inputs
	nx = numel(obj.states);
	nu = numel(obj.inputs);

	% Parse input arguments
	parser = inputParser;
	parser.addRequired('point', ...
		@(x) validateattributes(x, {'Point'}, {'numel', 1}));
	parser.addOptional('Q', eye(nx), ...
		@(x) validateattributes(x, {'double'}, {'size', [nx nx]}));
	parser.parse(point, varargin{:});
	opts = parser.Results;

	% Unpack trajectories from time point object
	[x0, u0, m0] = point.unpack;

	% Check the Q matrix is positive definite
	if any(eig(opts.Q) <= 0)
		error('Q state cost matrix must be positive definite.');
	end % if

	% Check the Q matrix is symmetric
	if ~isequal(opts.Q, opts.Q.')
		error('Q state cost matrix must be symmetric.');
	end % if

	% Linearize dynamics
	[AFcn, BFcn, CFcn, DFcn] = obj.linearize;

	% Check if it is actually a fixed point
	xdot0 = obj.stateEquation([], x0, u0, m0);
	if any(abs(xdot0) > 1e-6)
		warning('Specified operating point does not appear to be a fixed point.');
	end % if

	% Evaluate linearized dynamics at fixed point
	A = AFcn(x0, u0, m0);
	B = BFcn(x0, u0, m0);

	% Solve continuous-time Lyapunov equations
	P = lyap(A', opts.Q);

	% % Lyapunov function candidate
	% V = x0'*P*x0

	% % Lyapunov function candidate derivative
	% Vdot = x'*P*f(x) + f(x)'*P*x;
	% Vdot = x'*Q*x + 2*x'*P*G(x)*x;
end % tilyap
