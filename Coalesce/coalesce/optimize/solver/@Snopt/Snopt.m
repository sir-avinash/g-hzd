classdef Snopt < Solver
%SNOPT Provides an interface for COALESCE objects.
%
% Copyright 2013-2014 Mikhail S. Jones

	% PUBLIC PROPERTIES =====================================================
	properties
	end % properties

	% PUBLIC METHODS ========================================================
	methods
		function this = Snopt(nlp)
		%SNOPT Creates a optimization solver object.
		%
		% Copyright 2013-2014 Mikhail S. Jones

			% Call superclass constructor
			this = this@Solver(nlp);

			% Set default SNOPT options
			snscreen('on');
			snseti('Iterations limit', 1e5);
			snseti('Major iterations limit', 5e3);
			snseti('Minor iterations limit', 5e2);
			snsetr('Feasibility tolerance', 1e-6);
			snsetr('Major feasibility tolerance', 1e-6);
			snsetr('Minor feasibility tolerance', 1e-6);
			snsetr('Major optimality tolerance', 1e-6);
		end % Snopt

		function setOptions(~, userOptions)
		%SETOPTIONS Set optimizer options.

			% Set SNOPT options
			snsetr(userOptions{:});
		end % setOptions
	end % methods
end % classdef
