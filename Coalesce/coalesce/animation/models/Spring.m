classdef Spring < Model
%SPRING Creates a 3D springmodel object.
%
% Description:
%   Creates a 3D spring object using the Model superclass.
%
% Copyright 2013-2014 Mikhail S. Jones

	properties
		radius@double scalar = 0.1
		length@double scalar = 1
		thickness@double scalar = 0.02
		color = 'w'
		nCoils@double scalar = 5
		nNodes@double scalar = 50
	end % properties

	methods
		function this = Spring(radius, length, thickness, color, nCoils, nNodes)
		%SPRING Creates a 3D spring model object.
		%
		% Syntax:
		%   obj = Spring
		%   obj = Spring(radius, length, thickness)
		%   obj = Spring(radius, length, thickness, color)
		%   obj = Spring(radius, length, thickness, color, nCoils)
		%   obj = Spring(radius, length, thickness, color, nCoils, nNodes)
		%
		% Copyright 2014 Mikhail S. Jones

			% Call superclass constructor
			this = this@Model;

			% Parse input arguments and set default properties
			switch nargin
				case 0
					% Do nothing
				case 3
					this.radius = radius;
					this.length = length;
					this.thickness = thickness;
				case 4
					this.radius = radius;
					this.length = length;
					this.thickness = thickness;
					this.color = color;
				case 5
					this.radius = radius;
					this.length = length;
					this.thickness = thickness;
					this.color = color;
					this.nCoils = nCoils;
				case 6
					this.radius = radius;
					this.length = length;
					this.thickness = thickness;
					this.color = color;
					this.nCoils = nCoils;
					this.nNodes = nNodes;
				otherwise
					error('Invalid number of input arguments.');
			end % switch

			% Set length to compute dependent coordinates
			this.setLength(this.length);

			% Create graphics object
			this.handle = surf(this.x, this.y, this.z, ...
				'EdgeColor', 'none', ...
				'FaceColor', this.color);
		end % Spring

		function setLength(this, length)
		%SETLENGTH Set spring length
		%

			% Set property
			this.length = length;

			% Parametric equations for a 3D coil spring
			t = linspace(0, 1, this.nNodes*(this.nCoils + 2));
			l = this.length - 2*this.thickness;
			x = this.thickness + [...
				zeros(1,this.nNodes), ...
				linspace(0, l, this.nNodes*this.nCoils), ...
				l + zeros(1,this.nNodes)];
			y = this.radius.*sin(t*(this.nCoils + 2)*2*pi);
			z = this.radius.*cos(t*(this.nCoils + 2)*2*pi);

			% Extrude path into a tube
			[this.x, this.y, this.z] = extrudePath(...
				[x; y; z], this.thickness);
		end % setLength
	end % methods
end  % classdef
