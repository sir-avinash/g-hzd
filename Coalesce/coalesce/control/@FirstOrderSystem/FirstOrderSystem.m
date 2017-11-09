%FIRSTORDERSYSTEM Abstract hybrid first order input-output system.
%
% Description:
%		Constructs a hybrid first order input-output system with basic control
%		optimization and simulation tools.
%
% Copyright 2014 Mikhail S. Jones

classdef FirstOrderSystem < handle

	% PUBLIC PROPERTIES =====================================================
	properties
		inputLowerBounds@double vector % Vector of input lower bounds
		inputUpperBounds@double vector % Vector of input upper bounds
	end % properties

	% PROTECTED PROPERTIES ==================================================
	properties (Access = protected)
		states@cell vector % Vector of state variables (x)
		inputs@cell vector % Vector of input variables (u)
		modes@cell vector % Vector of dynamic modes (m)
	end % properties

	% PUBLIC METHODS ========================================================
	methods
		function obj = FirstOrderSystem(x, u, m)
		%FIRSTORDERSYSTEM First order input-ouput system constructor.

			% Set state properties
			obj.states = x;

			% Set state properties
			obj.inputs = u;
			obj.inputLowerBounds = -Inf(numel(u), 1);
			obj.inputUpperBounds = Inf(numel(u), 1);

			% Set mode properties
			obj.modes = m;
		end % FirstOrderSystem

		function y = outputEquation(obj, t, x, u, m)
		%OUTPUTEQUATION The hybrid first order system output equation.
		%
		% Description:
		%		This method is a placeholder that can be overloaded.
		%		The nonlinear output equation should be written in the form
		%
		%		y(t) = h(t, x(t), u(t), m).

			% Output equation
			y = x;
		end % outputEquation

		function set.inputLowerBounds(obj, lb)
		%SET.INPUTLOWERBOUNDS Set method for input lower bounds.

			% Number of inputs
			nu = numel(obj.inputs);

			% Check size
			if isvector(lb) && any(numel(lb) == [1 nu])
				obj.inputLowerBounds(1:nu) = lb;
			else
				error('Vector does not match size of input vector.');
			end % if
		end % set.inputLowerBounds

		function set.inputUpperBounds(obj, ub)
		%SET.INPUTUPPERBOUNDS Set method for input upper bounds.

			% Number of inputs
			nu = numel(obj.inputs);

			% Check size
			if isvector(ub) && any(numel(ub) == [1 nu])
				obj.inputUpperBounds(1:nu) = ub;
			else
				error('Vector does not match size of input vector.');
			end % if
		end % set.inputUpperBounds
	end % methods

	% ABSTRACT METHODS ======================================================
	methods (Abstract = true)
		xdot = stateEquation(obj, t, x, u, m)
		%STATEEQUATION The hybrid first order system state equation.
		%
		% Description:
		%		This method is an abstract placeholder that must be overloaded.
		%		The nonlinear state equation should be written in the form
		%
		%		xdot(t) = f(t, x(t), u(t), m).
	end % methods
end % classdef
