%PENDULUMCARTSCENE Creates a pendulum on a cart scene object.
%
% Description:
%   Creates a pendulum on a cart object using the Scene superclass.
%
% Copyright 2013-2014 Mikhail S. Jones

classdef PendulumCartScene < Scene

  % PUBLIC PROPERTIES =====================================================
  properties
  	N@double % Number of pendulum segments
  	lp@double % Pendulum segment total length
  	xLim@double % Cart position limits

%   	axes@double
	axes@matlab.graphics.axis.Axes
  	ground@StripedLine
  	cart@RoundedSquare
  	link@RoundedSquare

%   	response@Response
	response
	end % properties

  % PUBLIC METHODS ========================================================
	methods
		function obj = PendulumCartScene(sys, response)
		%PENDULUMCARTSCENE Pendulum on a cart scene constructor.

			% Call superclass constructor
			obj = obj@Scene(response.time{1});

			% Store system response
			obj.response = response;

			% Store parameters
			obj.N = sys.nLinks;
			obj.lp = sys.lp;
			obj.xLim = sys.xLim;
% 			obj.xLim = 3;
		end % PendulumCartScene

		function this = initialize(obj, stepLength, stepHeight,shape)
		%INITIALIZE Initialize graphical objects.

			% Store the axes handle
			obj.axes = gca;

			% Parameters
			wCart = (obj.N*obj.lp)/4;
			hCart = wCart/2;
			wLink = (obj.N*obj.lp)/20;

			% Define graphical link on cart
			obj.cart = RoundedSquare(wCart, hCart, hCart/4);
			for i = 1:obj.N
				obj.link(i) = RoundedSquare(obj.lp + wLink, wLink, wLink/2, 'r');
			end % for

			% Define left wall
			obj.ground(1) = StripedLine(obj.cart.height, 0.025);
			obj.ground(1).rotate(0, 0, pi/2);
			obj.ground(1).scale(-1, 1, 1);
			obj.ground(1).translate(-obj.xLim - obj.cart.width/2, - obj.cart.height/2, 0);
			obj.ground(1).update;

			% Define ground
			obj.ground(2) = StripedLine(2*obj.xLim + obj.cart.width, 0.025);
			obj.ground(2).translate(-obj.xLim - obj.cart.width/2, - obj.cart.height/2, 0);
			obj.ground(2).update;

			% Define right wall
			obj.ground(3) = StripedLine(obj.cart.height, 0.025);
			obj.ground(3).scale(-1, 1, 1);
			obj.ground(3).rotate(0, 0, pi/2);
			obj.ground(3).translate(obj.xLim + obj.cart.width/2, obj.cart.height/2, 0);
			obj.ground(3).update;
			
			% Define roofBlock
% 			x = -2:1e-3:2;
% 			y = roofProfile(x) + wLink/2;
% 			plot(x, y, 'Color', 'black', 'LineStyle', '-', 'LineWidth', 2);

			% Axes properties
			view(0, 89.9); % Fixes issue where OpenGL will sometimes not draw objects
			axis off;
		end % initialize

		function obj = update(obj, t)
		%UPDATE Update graphical objects.

			% Evaluate response at current time
			try
			[x, u] = obj.response.eval(t);
			catch
				x = obj.response.eval(t);
			end

			% Update cart
			obj.cart.reset;
			obj.cart.translate(x(1) - obj.cart.width/2, - obj.cart.height/2, 0);
			obj.cart.update;

			% Initialize pendulum position
			xp = x(1); zp = 0;

			% Update link
			for i = 1:obj.N
				obj.link(i).reset;
				obj.link(i).translate(-obj.link(i).height/2, -obj.link(i).height/2, 0);
				obj.link(i).rotate(0, 0, x(i+1) + pi/2);
% 				obj.link(i).translate(xp, zp, i*1e-3);	% link will blink, as it translate in a circle 
				obj.link(i).translate(xp, zp, 0);
				obj.link(i).update;

				xp = xp + obj.lp*cos(x(i+1));
				zp = zp + obj.lp*sin(x(i+1));
			end % for

			% Set axes limits
			yLim = 1.1*(obj.N*obj.lp);
			xLim = yLim/720*1280;
			if 1.1*obj.xLim > xLim
				xLim = 1.1*obj.xLim;
				yLim = xLim/1280*720;
			end % if
			ylim(obj.axes, [-yLim, yLim]);
			xlim(obj.axes, [-xLim, xLim]);
		end % update
	end % methods
end % classdef
