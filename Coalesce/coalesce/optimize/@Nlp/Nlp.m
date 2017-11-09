%NLP Creates a nonlinear programming optimization problem object.
%
% Description:
%   NLP is a MATLAB object-oriented class for formulating,
%   building, and solving nonlinear optimization problems.
%
% Features:
%   * Handles a wide variety of optimization problems including linear,
%     nonlinear, constrained, and unconstrained.
%   * Uses a object-oriented interface to abstract the problem formulation,
%     allowing for a simple, intuitive and robust symbolic problem
%     generation.
%   * Automatically generates analytical gradients and Hessians (optional)
%     to increase solver performance.
%   * Includes wrappers to interface MATLAB solvers as well as a hand full
%     of open-source solvers.
%
% Copyright 2013-2014 Mikhail S. Jones

classdef Nlp < handle

	% PUBLIC PROPERTIES =====================================================
	properties
		variable@Variable
		variableLowerBound@double vector = [] % private
		variableUpperBound@double vector = [] % private

		solution@double vector = [] % private
		initialGuess@double vector = [] % private

		objective@Objective

		constraint@Constraint

		options@struct scalar
	end % properties

	% PROTECTED PROPERTIES ==================================================
	properties (Access = protected)
		version@char vector = 'v.1.0'
	end % properties

	% DEPENDENT PROPERTIES ==================================================
	properties (Dependent = true)
		numberOfVariables@double scalar
		numberOfConstraints@double scalar
		numberOfObjectives@double scalar
	end % properties

	% PUBLIC METHODS ========================================================
	methods
        function this = clearObjective(this)
            this.objective = Objective.empty;
        end
        
		function this = Nlp(varargin)
		%NLP Creates a nonlinear programming optimization problem object.
		%
		% Syntax:
		%   obj = Nlp
		%
		% Optional Input Arguments:
		%   name - (CHAR) Problem name
		%		description - (CHAR) Problem description
		%		verbose - (LOGICAL) Set verbosity of user feedback
		%
		% Copyright 2013-2014 Mikhail S. Jones

			% Parse input arguments
			parser = inputParser;
			parser.addParamValue('name', 'No Name', ...
				@(x) validateattributes(x, {'char'}, {}));
			parser.addParamValue('description', 'No Description', ...
				@(x) validateattributes(x, {'char'}, {}));
			parser.addParamValue('verbose', true, ...
				@(x) validateattributes(x, {'logical'}, {'scalar'}));
			parser.parse(varargin{:});
			this.options = parser.Results;

			% User feedback
			fprintf('NLP object constructed!\n');
		end % Nlp

		function nVars = get.numberOfVariables(this)
		%GET.NUMBEROFVARIABLES Get method for number of variables.

			% Number of variables
			nVars = length(this.initialGuess);
		end % get.numberOfVariables

		function nCons = get.numberOfConstraints(this)
		%GET.NUMBEROFCONSTRAINTS Get method for number of constraints.

			% Check if any constraints have been defined
			if isempty(this.constraint)
				nCons = 0;
			else
				% Construct reference to object array
				refCons = [this.constraint.expression];

				% Compute number of constraints
				nCons = sum([refCons.length]);
			end % if
		end % get.numberOfConstraints

		function nObjs = get.numberOfObjectives(this)
		%GET.NUMBEROFOBJECTIVES Get method for number of objectives.

			% Number of objectives
			nObjs = 1;
		end % get.numberOfObjectives

		function [isDefined, usedVars] = checkVariables(this, varargin)
		%CHECKVARIABLES Check if variables in expression have been defined.
		%
		% Syntax:
		%   obj.checkVariables(expr)
		%   obj.checkVariables(expr, vars)
		%
		% Description:
		%   This method checks that all symbolic variables within the
		%   expression are defined. Alternatively, the use can supply the
		%		variables to check against.
		%
		% Copyright 2013-2014 Mikhail S. Jones

			switch nargin
				case 2
					% Cell array of defined variable names
					definedVars = {'var' 'par'};
					expression = varargin{1};

				case 3
					% User supplies variable names to check against
					definedVars = varargin{2};
					expression = varargin{1};

				otherwise
					error('Invalid number of input arguments.');
			end % switch

			% Create cell array of all found variable names
			usedVars = symvar(expression);

			if isempty(usedVars)
				isDefined = true;
			else
				% Construct cell array of used variable names
				for k = 1:numel(usedVars)
					usedNames{k} = usedVars(k).name;
				end % if

				% Check if all variables in expression are defined
				isDefined = all(logical(ismember(usedNames, definedVars)));
			end % if
		end % checkVariables

		function delete(this)
		%DELETE Delete the object.
		%
		% Description:
		%   DELETE does not need to called directly, as it is called when
		%   the object is cleared.
		%
		% Copyright 2013-2014 Mikhail S. Jones

			% User feedback
			fprintf('NLP object (%s) deleted!\n', this.options.name);
		end % delete
	end % methods
end % classdef
