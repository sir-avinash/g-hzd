classdef DirectCollocation < Nlp
%DIRECTCOLLOCATION Defines a direct collocation optimization problem.
%
% Copyright 2013-2014 Mikhail S. Jones

	properties (SetAccess = public, GetAccess = public)
		phase@Phase % Structure containing phase information (states, inputs, time)
		nNodes@double scalar % Number of collocation nodes
	end % properties

	methods (Access = public)
		function obj = DirectCollocation(nNodes, varargin)
		%DIRECTCOLLOCATION Direct Collocation optimization problem constructor.
		%
		% Syntax:
		%   obj = DirectCollocation(nNodes)
		%
		% Required Input Arguments:
		%   nNode - (DOUBLE) Number of nodes in phase
		%
		% Optional Input Arguments:
		%   name - (CHAR) Trajectory optimization problem description or name.

			% Call superclass constructor
			obj = obj@Nlp(varargin{:});

			% Sub class properties
			obj.nNodes = nNodes;
		end % DirectCollocation
	end % methods
end % classdef
