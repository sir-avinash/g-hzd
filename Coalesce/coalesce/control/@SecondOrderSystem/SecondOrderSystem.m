%SECONDORDERSYSTEM Abstract hybrid second order input-output system.
%
% Description:
%		Constructs a hybrid second order input-output system with basic control
%		optimization and simulation tools.
%
% Copyright 2014 Mikhail S. Jones

classdef SecondOrderSystem < FirstOrderSystem

	% PROTECTED PROPERTIES ==================================================
	properties (Access = protected)
		% State properties
		firstOrderStates@cell vector = {} % Cell array of state variables (x)
		secondOrderStates@cell vector = {} % Cell array of state variables (x)
	end % properties

	% PUBLIC METHODS ========================================================
	methods
		function obj = SecondOrderSystem(x, u, m)
		%SECONDORDERSYSTEM Second order input-ouput system constructor.

			% Construct new state vector
			xdot = cellfun(@(y) [y 'dot'], x, 'UniformOutput', false);

			% Call superclass constructor
			obj = obj@FirstOrderSystem([x xdot], u, m);

			% Set object properties
			obj.firstOrderStates = x;
			obj.secondOrderStates = xdot;
		end % SecondOrderSystem

		function [g, G, Gq] = constraintEquation(obj, x, xdot, m)
		%CONSTRAINTEQUATION The input-ouput model constraint equations.
		%
		% Description:
		%		This method is a placeholder that can be overloaded.
		%		The nonlinear constraint equations should be written in the form
		%
		%		0 = g(t, x(t), u(t), m).

			% Constraint equation
			g = [];
			G = [];
			Gq = [];
		end % constraintEquation
	end % methods

	% ABSTRACT METHODS ======================================================
	methods (Abstract = true)
		[M, f] = secondOrderStateEquation(obj, t, x, xdot, u, m)
		%SECONDORDERSTATEEQUATION The input-output model state equation.
		%
		% Description:
		%		This method is an abstract placeholder that must be overloaded.
		%		The nonlinear state equation should be written in the form
		%
		%		M(x(t), m)*xddot(t) = f(x(t), xdot(t), u(t), m).
	end % methods
end % classdef
