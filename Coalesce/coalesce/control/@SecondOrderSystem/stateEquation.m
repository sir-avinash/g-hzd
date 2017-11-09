function xdot = stateEquation(obj, t, x, u, m, Nstep, Perturb)
%STATEEQUATION The input-output system state equation.
%
% Description:
%		The nonlinear state equations are converted to the first order form
%		xdot(t) = f(t, x(t), u(t)). Constraints are handled at the acceleration
%		level (DAE Index-3). The second order system
%
%			M(x(t))*xddot(t) = f(x(t), xdot(t), t) + G(x(t))*lambda
%
%		is reformulated as
%
%			MStar(y(t), t)*ydot(t) = fStar(y(t), t)
%
% Copyright 2014 Mikhail S. Jones

	% Number of states and inputs
	nx = numel(obj.states);
	nu = numel(obj.inputs);

	% Break states up into first and second order pieces
	dx = x(nx/2+1:end);
	x = x(1:nx/2);

	% Evaluate second order state equation
	[M, f] = obj.secondOrderStateEquation(t, x, dx, u, m);
	
	% Perturbation
	try
		if Perturb.flag
			if Nstep >= Perturb.start && Nstep <= Perturb.end
				f(1) = f(1) + Perturb.force;
			end
		end
	catch
		
	end
	% Constraint Jacobian
	[g, G, Gq] = obj.constraintEquation(x, dx, m);

	% Modified system of equations
	MStar = blkdiag(eye(nx/2), [M, -G.'; G, zeros(size(G, 1))]);
	fStar = [dx; f; -Gq];

	% Solve system of equations
	xdot = MStar\fStar;

	% Exclude Lagrange multipliers and only return original states
	xdot = xdot(1:nx);
end % stateEquation
