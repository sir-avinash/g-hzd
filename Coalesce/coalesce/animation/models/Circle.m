classdef Circle < Model
%CIRCLE Creates a 2D circle model object.
%
% Description:
%   Creates a 2D circle object using the Model superclass.
%
% Copyright 2013-2014 Mikhail S. Jones

	properties
		radius@double scalar = 0.1
		color = 'w'
		nNodes@double scalar = 50
	end % properties

	methods
		function this = Circle(radius, color, nNodes)
		%CIRCLE Creates a 2D circle model object.
		%
		% Syntax:
		%   obj = Circle
		%   obj = Circle(radius)
		%   obj = Circle(radius, color)
		%   obj = Circle(radius, color, n)
		%
		% Copyright 2014 Mikhail S. Jones

			% Call superclass constructor
			this = this@Model;

			% Parse input arguments and set default properties
			switch nargin
				case 0
					% Do nothing
				case 1
					this.radius = radius;
				case 2
					this.radius = radius;
					this.color = color;
				case 3
					this.radius = radius;
					this.color = color;
					this.nNodes = nNodes;
				otherwise
					error('Invalid number of input arguments.');
			end % switch

			% Parametric equations for a circle
			theta = (0:this.nNodes)/this.nNodes*2*pi;
			this.x = this.radius*sin(theta);
			this.y = this.radius*cos(theta);
			this.z = 0*theta;

			% Create graphics object
			this.handle = patch(this.x, this.y, this.z, this.color, ...
				'EdgeColor', 'k', ...
				'LineWidth', 2);
		end % Circle
	end % methods
end % classdef
