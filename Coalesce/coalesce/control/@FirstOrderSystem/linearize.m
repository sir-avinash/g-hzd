function [AFcn, BFcn, CFcn, DFcn] = linearize(obj)
%LINEARIZE Linearizes the nonlinear hybrid system.
%
% Description:
%		Converts the nonlinear hybrid input-output system with state equation
%		xdot(t) = f(t, x(t), u(t)) and output equation y(t) = h(t, x(t), u(t))
%		to a linear system with state equation xdot(t) = A(t)*x(t) + B(t)*u(t)
%		and output equation y(t) = C(t)*x(t) + D(t)*u(t). Where, A(t) is the
%		state matrix, B(t) is the input matrix, C(t) is the output matrix, and
%		D(t) is the feed-through matrix.
%
% Copyright 2014 Mikhail S. Jones

	% TODO: Split apart to allow numerical or symbolic versions
	
	% Derive a numerical approximation of the state matrix
	AFcn = @(x, u, m) fcnJacobian(@(x) obj.stateEquation([], x, u, m), x);

	% Derive a numerical approximation of the input matrix
	BFcn = @(x, u, m) fcnJacobian(@(u) obj.stateEquation([], x, u, m), u);

	% Derive a numerical approximation of the output matrix
	CFcn = @(x, u, m) fcnJacobian(@(x) obj.outputEquation([], x, u, m), x);

	% Derive a numerical approximation of the feed-through matrix
	DFcn = @(x, u, m) fcnJacobian(@(u) obj.outputEquation([], x, u, m), u);
end % linearize
