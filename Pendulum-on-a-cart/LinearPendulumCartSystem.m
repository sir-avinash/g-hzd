%PENDULUMCARTSYSTEM N-Link pendulum on a cart system model.
%
% Copyright 2014 Mikhail S. Jones

classdef LinearPendulumCartSystem < SecondOrderSystem

	% PUBLIC PROPERTIES =====================================================
	properties
		nLinks@double scalar % Number of pendulum links
		g@double scalar = 9.81 % Gravity
		mc@double scalar = 1 % Cart mass
		bc@double scalar = 0.1*0 % Cart damping
		mp@double scalar % Pendulum segment mass
		lp@double scalar % Pendulum segment total length
		rp@double scalar % Pendulum segment distance to center of mass
		Ip@double scalar % Pendulum segment inertia at center of mass
		bp@double scalar % Pendulum segment damping constant
		tauLim@double scalar = 200 % Cart force limits
		xLim@double scalar = 10 % Cart position limits
		Amatrix@double % Manipulator equation function
		Bmatrix@double % Manipulator equation function
	end % properties

	% PUBLIC METHODS ========================================================
	methods
		function obj = LinearPendulumCartSystem(nLinks)
		%PENDULUMCARTSYSTEM N-link pendulum on a cart system model constructor.

			% Define inputs and outputs
			u = {'f'};
			for i = 1:nLinks
				theta{i} = ['theta' num2str(i)];
				Dtheta{i} = ['Dtheta' num2str(i)];
			end % for
			x = {'xc', theta{:}};
			dx = {'Dxc', Dtheta{:}};

			% Call superclass constructor
			obj = obj@SecondOrderSystem(x, u, {''});
			
			% Set additional properties
			obj.nLinks = nLinks;
			obj.mp = 1/nLinks;
			obj.lp = 1/nLinks;
			obj.rp = obj.lp/2;
			obj.Ip = obj.mp*obj.lp^2/12;
			obj.bp = 0.01/nLinks*0;
			
			% Linearize pendulum system
			sys = PendulumCartSystem(1);
			linearizedSys = linearizeSystem(sys);
			obj.Amatrix = linearizedSys.A;
			obj.Bmatrix = linearizedSys.B;
			
			% Set input bounds
			obj.inputLowerBounds = -obj.tauLim;
			obj.inputUpperBounds = obj.tauLim;
		end % PendulumCartSystem

		function [M, f] = secondOrderStateEquation(obj, t, x, xdot, u, m)
		%SECONDORDERSTATEEQUATION The system state equation.

			% Inertia matrix
			M = eye(2);

			% Gravity and other terms
			f = obj.Amatrix(3:4,:)*[x; xdot] + obj.Bmatrix(3:4,:)*u;

			
		end % secondOrderStateEquation
	end % methods
end % classdef
