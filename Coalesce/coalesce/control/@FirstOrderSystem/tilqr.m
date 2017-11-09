function controller = tilqr(obj, point, varargin)
%TILQR Time Invariant Linear Quadratic Regulator
%
% Syntax:
%		controller = obj.tilqr(point, Q, R, N)
%
% Required Input Arguments:
%		point - (POINT) Fixed point for the dynamical system
%
% Optional Input Arguments:
%		Q - (DOUBLE) LQR state cost
%		R - (DOUBLE) LQR input cost
%		N - (DOUBLE) LQR cost offset
%
% Description:
%		A time invariant linear quadratic regulator is constructed around the
%		provided system fixed point.
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
	parser.addOptional('R', eye(nu), ...
		@(x) validateattributes(x, {'double'}, {'size', [nu nu]}));
	parser.addOptional('N', zeros(nx, nu), ...
		@(x) validateattributes(x, {'double'}, {'size', [nx nu]}));
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

	% Check the R matrix is symmetric
	if ~isequal(opts.R, opts.R.')
		error('R input cost matrix must be symmetric.');
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

	% Solve the continuous-time algebraic Riccati equations
	[~, ~, k] = care(A, B, opts.Q, opts.R, opts.N);

	% Generate controller
	controller = @(t, x) u0 + k*(x0 - x);
end % tilqr
