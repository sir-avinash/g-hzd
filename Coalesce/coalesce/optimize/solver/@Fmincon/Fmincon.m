classdef Fmincon < Solver
%FMINCON Provides an interface for COALESCE objects.
%
% Copyright 2013-2014 Mikhail S. Jones

	% PUBLIC PROPERTIES =====================================================
	properties
	end % properties

	% PUBLIC METHODS ========================================================
	methods (Access = public)
		function this = Fmincon(nlp)
		%FMINCON Creates a optimization solver object.
		%
		% Copyright 2013-2014 Mikhail S. Jones

			% Call superclass constructor
			this = this@Solver(nlp);

			% Set default FMINCON options
			this.options = optimset(...
				'Algorithm', 'interior-point', ...
				'Display', 'iter', ...
				'FinDiffType', 'forward', ...
				'GradConstr', 'on', ...
				'GradObj', 'on', ...
				'Hessian','fin-diff-grads', ...
				...'Hessian','user-supplied', ...
				...'HessMult',@fminconHessMult, ...
				'MaxFunEvals', 1e5, ...
				'SubproblemAlgorithm','cg', ...
				'UseParallel', 'Always');
		end % Fmincon

		function setOptions(this, userOptions)
		%SETOPTIONS Set optimizer options.

			% Set properties
			opts = {this.options};
			this.options = optimset(opts{:}, userOptions{:});
		end % setOptions
	end % methods
end % classdef
