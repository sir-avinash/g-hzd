% Building a three link walker model - a modern spin to Jessy's old code

classdef ThreeLinkWalkerSystem < SecondOrderSystem
    properties (Constant = true)
        tauLim = 60 % Actuator torque limit                % for flat ground
		DqmLim = 10 % Actuator velocity limit (default)   % for flat ground
    end %properties
    
    methods
        function obj = ThreeLinkWalkerSystem
            obj = obj@SecondOrderSystem(...
                {'q1', 'q2', 'q3'}, ...
				{'tau2', 'tau3'}, ...
				{'f', 'ss', 'ds'});
            
            % Set input bounds
			obj.inputLowerBounds = -obj.tauLim;
			obj.inputUpperBounds = obj.tauLim;
        end % ThreeLinkWalker
        
%         function [g, G, Gq] = constraintEquation(obj, x, xdot, m)
% 		%CONSTRAINTEQUATION The system model constraint equations.
% 		%
% 		% Description:
% 		%		The nonlinear constraint equations should be written in the form
% 		%
% 		%		0 = g(x(t), m).
% 		%
% 		% 	Where g(x(t)) is the constraint written at the position level,
% 		%		G(x(t)) is the Jacobian of the constraints, and Gq(x(t), xdot(t))
% 		%		is the first order time derivative of the Jacobian.
%         q = x;
%         dq = xdot;
%             [p4L,p4,EL,ER,ELq,ERq]= LagrangeModelAtriasConstraint2D(q,dq);
% 			switch m
% 				case 'ss'
% 					g = p4;
% 					G = ER.';
% 					Gq = ERq;
% 				case 'ds'
% 					g = [p4;p4L];
% 					G = [ER.';EL.'];
%                     Gq = [ERq;ELq];
% 
% 				otherwise
% 					g = [];
% 					G = [];
% 					Gq = [];
% 			end % switch
% 		end % constraintEquation

%         function [M, f] = secondOrderStateEquation(this, t, x, xdot, u, m)
% 		%SECONDORDERSTATEEQUATION The system model state equation.
% 		%
% 		% Description:
% 		%		The nonlinear state equation should be written in the form
% 		%
% 		%		M(x(t), m)*xddot(t) = f(x(t), xdot(t), u(t), m).
% 		%
% 		%		Where M(x(t)) is the inertia matrix and f(x(t), xdot(t), u(t)) is
% 		%		the remaining terms including gravity, Coriolis, dissipation, and
% 		%		control inputs.
%             q = x;
%             dq = xdot;
%             [D,C,G,B,~,~,~]= LagrangeModelAtriasFlight2D(q,dq);
%             
%             M = D;
%             
% 			tauLmA = u(1);
% 			tauLmB = u(2);
% 			tauRmA = u(3);
% 			tauRmB = u(4);
%             f = -C*dq-G+B*[tauLmA;tauLmB;tauRmA;tauRmB];
% 
% 		end % secondOrderStateEquation
    end %methods    
end %classdef    