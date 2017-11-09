classdef StripedLine_poly < Model
%STRIPEDLINE Creates a diagonally striped line model object.
%
% Description:
%   Creates a striped line object using the Model superclass.
%
% Copyright 2013-2014 Mikhail S. Jones

	properties
		stepLength@double = 0:0.5:10
		stepHeight@double = [0:21-1]*0.1
	end % properties

	methods
		function this = StripedLine_poly(stepLength, stepHeight, shape)
		%STRIPEDLINE Creates a striped line model object.
		%
		% Syntax:
		%   obj = StripedLine
		%   obj = StripedLine(width)
		%   obj = StripedLine(width, spacing)
		%
		% Copyright 2014 Mikhail S. Jones

			% Call superclass constructor
			this = this@Model;

			% Parse input arguments and set default properties
% 			switch nargin
% 			case 0
% 				% Do nothing
% 			case 1
% % 				this.width= width;
% 			case 2
% % 				this.width= width;
% % 				this.spacing = spacing;
% 
% % 				this.stepLength= stepLength;
% % 				this.stepHeight = stepHeight;                
% 			otherwise
% 				error('Invalid number of input arguments.');
% 			end % switch

			% Equations for a striped line
            xInput = stepLength(1):1e-2:stepLength(end);
            yOutput = interp1 (stepLength,stepHeight,xInput,shape)-0.015;    % leave a little clearance

			% Create graphics object
			this.handle = plot(xInput, yOutput, ...
				'Color', 'black', ...
				'LineStyle', '-', ...
				'LineWidth', 3);
		end % StripedLine
	end % methods
end % classdef
