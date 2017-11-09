function point = fixedPoint(obj, varargin)
%FIXEDPOINT Finds the closest fixed point for the nonlinear hybrid system.
%
%	Syntax:
%		point = obj.fixedPoint(x0, u0, m0)
%
% Description:
%		Given a initial guess, a fixed point is found by solving the state
%		equations such that all derivatives equal zero.
%
% TODO:
% 	Find closest fixed point to current state
%		Allow user to specify which states are free and which are fixed
%
% Copyright 2014 Mikhail S. Jones

	% Number of states and inputs
	nx = numel(obj.states);
	nu = numel(obj.inputs);

	% Parse input arguments
	parser = inputParser;
	parser.addOptional('x0', zeros(nx,1), ...
		@(x) validateattributes(x, {'double'}, {'size', [nx 1]}));
	parser.addOptional('u0', zeros(nu, 1), ...
		@(x) validateattributes(x, {'double'}, {'size', [nu 1]}));
	parser.addOptional('m0', obj.modes{1}, ...
		@(x) ischar(validatestring(x, obj.modes)));
	parser.parse(varargin{:});
	opts = parser.Results;

	% Construct indexes for accessing states and control in objective
	xi = 1:nx;
	ui = nx + (1:nu);

	% Create objective function
	obj = @(y) obj.stateEquation([], y(xi), y(ui), opts.m0);

	% Set fsolve options
	options = optimset('Display', 'iter');

	% Find fixed point
	x = fsolve(obj, [opts.x0; opts.u0], options);

	% Create fixed point object
	point = Point(x(xi), x(ui), opts.m0);
end % fixedPoint

% % Create objective function
% % obj = @(x) sum(x(ui).^2);
% obj = @(x) sum((opts.x0 - obj.stateEquation(0, x(xi), x(ui), opts.m0)).^2);

% % Set fsolve options
% options = optimset('Display', 'iter');

% % Find fixed point
% x = fmincon(obj, [opts.x0; opts.u0], [], [], [], [], [], [], @nonlcon, options);

% % Create fixed point object
% point = Point(x(xi), x(ui), opts.m0);

% function [c, ceq] = nonlcon(x)
% 	c = [];
% 	ceq = obj.stateEquation(0, x(xi), x(ui), opts.m0);
% end % nonlcon
