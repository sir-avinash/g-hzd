%ATRIASSYSTEM ATRIAS bipedal robot system model.
%
% Copyright 2014 Mikhail S. Jones

classdef AtriasSystem < SecondOrderSystem

	% CONSTANT PROPERTIES ===================================================
	properties (Constant = true)
		tauLim = 5 % Actuator torque limit                % for flat ground
		DqmLim = 10 % Actuator velocity limit (default)   % for flat ground
        
%         tauLim = 4 % Actuator torque limit                % for rough ground
% 		DqmLim = 7.88*2 % Actuator velocity limit (default)   % for rough ground
	end % properties

	% PUBLIC METHODS ========================================================
	methods
		function obj = AtriasSystem
		%ATRIASSYSTEM ATRIAS system model constructor.

			% Call superclass constructor
			obj = obj@SecondOrderSystem(...
				{'yH', 'zH', 'qT', 'q1', 'q2', 'q1L', 'q2L'}, ...
				{'tauRmA', 'tauRmB', 'tauLmA', 'tauLmB'}, ...
				{'f', 'ss', 'ds'});

			% Set input bounds
			obj.inputLowerBounds = -obj.tauLim;
			obj.inputUpperBounds = obj.tauLim;
		end % AtriasSystem

		function [g, G, Gq] = constraintEquation(obj, x, xdot, m)
		%CONSTRAINTEQUATION The system model constraint equations.
		%
		% Description:
		%		The nonlinear constraint equations should be written in the form
		%
		%		0 = g(x(t), m).
		%
		% 	Where g(x(t)) is the constraint written at the position level,
		%		G(x(t)) is the Jacobian of the constraints, and Gq(x(t), xdot(t))
		%		is the first order time derivative of the Jacobian.
        q = x;
        dq = xdot;
            [p4L,p4,EL,ER,ELq,ERq]= LagrangeModelAtriasConstraint2D(q,dq);
			switch m
				case 'ss'
					g = p4;
					G = ER.';
					Gq = ERq;
				case 'ds'
					g = [p4;p4L];
					G = [ER.';EL.'];
                    Gq = [ERq;ELq];

				otherwise
					g = [];
					G = [];
					Gq = [];
			end % switch
		end % constraintEquation

		function [M, f] = secondOrderStateEquation(this, t, x, xdot, u, m)
		%SECONDORDERSTATEEQUATION The system model state equation.
		%
		% Description:
		%		The nonlinear state equation should be written in the form
		%
		%		M(x(t), m)*xddot(t) = f(x(t), xdot(t), u(t), m).
		%
		%		Where M(x(t)) is the inertia matrix and f(x(t), xdot(t), u(t)) is
		%		the remaining terms including gravity, Coriolis, dissipation, and
		%		control inputs.
            q = x;
            dq = xdot;
            [D,C,G,B,~,~,~]= LagrangeModelAtriasFlight2D(q,dq);
            
            M = D;
            
			tauLmA = u(1);
			tauLmB = u(2);
			tauRmA = u(3);
			tauRmB = u(4);
            f = -C*dq-G+B*[tauLmA;tauLmB;tauRmA;tauRmB];

		end % secondOrderStateEquation
               
        function [footPlace, direction, modes, jumpFcn] = guardSet(obj,t, x, xdot, m)

            [g, ~, ~] = obj.constraintEquation(x, xdot, 'ds');
            footPlace = g(3:4);
            direction = -1;
            modes{1} = 'ss';

            R = [1 0 0 0 0 0 0;
                0 1 0 0 0 0 0;
                0 0 1 0 0 0 0;
                0 0 0 0 0 1 0;
                0 0 0 0 0 0 1;
                0 0 0 1 0 0 0;
                0 0 0 0 1 0 0;];

            [D, ~] = obj.secondOrderStateEquation(0, x, xdot, zeros(4,1), '');
            [g, G, ~] = obj.constraintEquation(x, xdot, 'ds');
            G = G(3:4,:);
%             [~, G, ~] = obj.constraintEquation(R*x, R*xdot, 'ss');
%             G = G*R;
            M = [D, -G.'; G, zeros(2)];
            f = [D*xdot; zeros(2,1)];
            dxeAug = (M\f);
            dxe = R*dxeAug(1:length(x));
            xe = R*x;
% 			xe(1) = 0;
            jumpFcn{1} = [xe;dxe];

        end
        
		function [pHip, vHip] = hipPositionVel(obj, x, xdot, m)
        % stance leg pivot model
        q = x(3:end);
        dq = xdot(3:end);
        [~, pHip] =  PointsAtrias2D(q);
        [vHip] =  VelAccelAtrias2D(q,dq);

		end % constraintEquation
        
        
        
%         function t_out = Time_out(this, t, x, xdot)
%          
%             t_out = t;
%             
%             
%         end % Time_out
	end % methods
end % classdef
