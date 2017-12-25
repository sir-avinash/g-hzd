%ATRIASSCENE Creates a simple 2D ATRIAS scene object.
%
% Description:
%   Creates a simple 2D ATRIAS object using the Scene superclass.
%
% Copyright 2013-2014 Mikhail S. Jones

classdef AtriasScene < Scene

  % PUBLIC PROPERTIES =====================================================
  properties
  	axes@matlab.graphics.axis.Axes
  	ground@StripedLine_poly
  	torso@RoundedSquare
  	lLegA1@RoundedSquare
  	lLegA2@RoundedSquare
  	lLegB1@RoundedSquare
  	lLegB2@RoundedSquare
  	rLegA1@RoundedSquare
  	rLegA2@RoundedSquare
  	rLegB1@RoundedSquare
  	rLegB2@RoundedSquare
  	lActA@RoundedSquare
  	lActB@RoundedSquare
  	rActA@RoundedSquare
  	rActB@RoundedSquare

  	response@Response
	end % properties

  % PUBLIC METHODS ========================================================
	methods
		function obj = AtriasScene(sys, response)
		%ATRIASSCENE 2D ATRIAS scene constructor.

			% Call superclass constructor
			obj = obj@Scene([response.time{:}]);

			% Store system response
			obj.response = response;
		end % AtriasScene

		function obj = initialize(obj, stepLength, stepHeight,shape)
		%INITIALIZE Initialize graphical objects.

			% Define properties (torso radius and leg segment radius)
			R = 0.12;
			r = 0.04;

			% Store the axes handle
			obj.axes = gca;
            
%             stepLength = 0:0.5:3;
%             stepHeight = zeros(1,length(stepLength)); stepHeight(1:2:end) = 0.06;
%             stepHeight = [0:length(stepLength)-1]*0.1;
			% Define ground
			obj.ground = StripedLine_poly(stepLength, stepHeight,shape);
% 			obj.ground.translate(-obj.ground.width/2, 0, 0);
%             obj.ground.translate(-obj.ground.width/2, 0, 0);
% 			obj.ground.update;
 
        [g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ...
         ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT ...
         JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 ...
         Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v06;
            
			% Define graphical ATRIAS
			obj.torso = RoundedSquare(LT*1.2 + 2*R, 5*R, R);
%             obj.torso = RoundedSquare(LT*0.8 + 2*R, 5*R, R);
s=1;
% RoundedSquare(width, height, radius, color, nNodes)
			obj.lLegA1 = RoundedSquare(L1 + 2*r, 2*r*s, r);
			obj.lLegA2 = RoundedSquare(L4 + 2*r, 2*r*s, r);
			obj.lLegB1 = RoundedSquare(L3 + 2*r, 2*r*s, r);
			obj.lLegB2 = RoundedSquare(L2 + 2*r, 2*r*s, r);
			obj.rLegA1 = RoundedSquare(L1 + 2*r, 2*r*s, r);
			obj.rLegA2 = RoundedSquare(L4 + 2*r, 2*r*s, r);
			obj.rLegB1 = RoundedSquare(L3 + 2*r, 2*r*s, r);
			obj.rLegB2 = RoundedSquare(L2 + 2*r, 2*r*s, r);
			obj.lActA = RoundedSquare(0.25 + 2*r, 2*r*s, r);
			obj.lActB = RoundedSquare(0.25 + 2*r, 2*r*s, r);
			obj.rActA = RoundedSquare(0.25 + 2*r, 2*r*s, r);
			obj.rActB = RoundedSquare(0.25 + 2*r, 2*r*s, r);

			% Axes properties
			view(0, 89.9); % Fixes issue where OpenGL will sometimes not draw objects
			axis off;
		end % initialize

		function obj = update(obj, t)
		%UPDATE Update graphical objects.

			% Evaluate response at current time
			[x, u] = obj.response.eval(t);

			px = x(1);
			pz = x(2) + 0.04;
			qt = x(3);
			qRlA = x(4);
			qRlB = x(5);
			qRmA = x(4);
			qRmB = x(5);
            qLlA = x(6);
			qLlB = x(7);
			qLmA = x(6);
			qLmB = x(7);

			% Update torso
			obj.torso.reset;
			obj.torso.translate(-obj.torso.radius, -obj.torso.height/2, 0);
			obj.torso.rotate(0, 0, qt+pi/2);
			obj.torso.translate(px, pz, 0.065);
            hold on
			obj.torso.update;

			% Update left leg A1 segment
			obj.lLegA1.reset;
			obj.lLegA1.translate(-obj.lLegA1.radius, -obj.lLegA1.height/2, 0);
			obj.lLegA1.rotate(0, 0, qLlA+qt+pi/2);
			obj.lLegA1.translate(px, pz, 0.01);
			obj.lLegA1.update;

			% Update left leg A2 segment
			obj.lLegA2.reset;
			obj.lLegA2.translate(-obj.lLegA2.radius, -obj.lLegA2.height/2, 0);
			obj.lLegA2.rotate(0, 0, qLlA+qt+pi/2);
			obj.lLegA2.translate(px + 0.5*cos(qLlB+qt+pi/2), pz + 0.5*sin(qLlB+qt+pi/2), 0.02);
			obj.lLegA2.update;

			% Update left leg B1 segment
			obj.lLegB1.reset;
			obj.lLegB1.translate(-obj.lLegB1.radius, -obj.lLegB1.height/2, 0);
			obj.lLegB1.rotate(0, 0, qLlB+qt+pi/2);
			obj.lLegB1.translate(px, pz, 0.03);
			obj.lLegB1.update;

			% Update left leg B2 segment
			obj.lLegB2.reset;
			obj.lLegB2.translate(-obj.lLegB2.radius, -obj.lLegB2.height/2, 0);
			obj.lLegB2.rotate(0, 0, qLlB+qt+pi/2);
			obj.lLegB2.translate(px + 0.45*cos(qLlA+qt+pi/2), pz + 0.45*sin(qLlA+qt+pi/2), 0.04);
			obj.lLegB2.update;

			% Update left actuator A segment
			obj.lActA.reset;
			obj.lActA.translate(-obj.lActA.radius, -obj.lActA.height/2, 0);
			obj.lActA.rotate(0, 0, qLmA+qt+pi/2);
			obj.lActA.translate(px, pz, 0.05);
			obj.lActA.update;

			% Update left actuator B segment
			obj.lActB.reset;
			obj.lActB.translate(-obj.lActB.radius, -obj.lActB.height/2, 0);
			obj.lActB.rotate(0, 0, qLmB+qt+pi/2);
			obj.lActB.translate(px, pz, 0.06);
			obj.lActB.update;

			% Update right leg A1 segment
			obj.rLegA1.reset;
			obj.rLegA1.translate(-obj.rLegA1.radius, -obj.rLegA1.height/2, 0);
			obj.rLegA1.rotate(0, 0, qRlA+qt+pi/2);
			obj.rLegA1.translate(px, pz, 0.07);
			obj.rLegA1.update;

			% Update right leg A2 segment
			obj.rLegA2.reset;
			obj.rLegA2.translate(-obj.rLegA2.radius, -obj.rLegA2.height/2, 0);
			obj.rLegA2.rotate(0, 0, qRlA+qt+pi/2);
			obj.rLegA2.translate(px + 0.5*cos(qRlB+qt+pi/2), pz + 0.5*sin(qRlB+qt+pi/2), 0.08);
			obj.rLegA2.update;

			% Update right leg B1 segment
			obj.rLegB1.reset;
			obj.rLegB1.translate(-obj.rLegB1.radius, -obj.rLegB1.height/2, 0);
			obj.rLegB1.rotate(0, 0, qRlB+qt+pi/2);
			obj.rLegB1.translate(px, pz, 0.09);
			obj.rLegB1.update;

			% Update right leg B2 segment
			obj.rLegB2.reset;
			obj.rLegB2.translate(-obj.rLegB2.radius, -obj.rLegB2.height/2, 0);
			obj.rLegB2.rotate(0, 0, qRlB+qt+pi/2);
			obj.rLegB2.translate(px + 0.45*cos(qRlA+qt+pi/2), pz + 0.45*sin(qRlA+qt+pi/2), 0.1);
			obj.rLegB2.update;

			% Update right actuator A segment
			obj.rActA.reset;
			obj.rActA.translate(-obj.rActA.radius, -obj.rActA.height/2, 0);
			obj.rActA.rotate(0, 0, qRmA+qt+pi/2);
			obj.rActA.translate(px, pz, 0.11);
			obj.rActA.update;

			% Update right actuator B segment
			obj.rActB.reset;
			obj.rActB.translate(-obj.rActB.radius, -obj.rActB.height/2, 0);
			obj.rActB.rotate(0, 0, qRmB+qt+pi/2);
			obj.rActB.translate(px, pz, 0.12);
			obj.rActB.update;

			% Set axes limits
			w = 8;
			ylim(obj.axes, pz/pz - 0.5 + ([-w, w])*720/1280/2);
			xlim(obj.axes, px + [-w, w]/2);
%             xlim(obj.axes, 3 + [-w, w]/2);
		end % update
	end % methods
end % classdef
