%PENDULUMCARTSYSTEM N-Link pendulum on a cart system model.
%
% Copyright 2014 Mikhail S. Jones

classdef PendulumCartSystem < SecondOrderSystem

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
% 		tauLim@double scalar = 5 % Cart force limits
% 		xLim@double scalar = 10 % Cart position limits
		xLim@double scalar = 2 % Cart position limits
		MFcn@function_handle % Manipulator equation function
		fFcn@function_handle % Manipulator equation function
	end % properties

	% PUBLIC METHODS ========================================================
	methods
		function obj = PendulumCartSystem(nLinks)
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

			% Derive dynamics in manipulator equation form
			[M, f] = obj.deriveDynamics(nLinks);

			% Convert to function handles
			obj.MFcn = sym2func(M, {sym(x).', sym(dx).', sym(u).'});
			obj.fFcn = sym2func(f, {sym(x).', sym(dx).', sym(u).'});

			% Set input bounds
			obj.inputLowerBounds = -obj.tauLim;
			obj.inputUpperBounds = obj.tauLim;
		end % PendulumCartSystem

		function [M, f] = deriveDynamics(obj, nLinks)
		%DERIVEDYNAMICS Derive the dynamics for a n-link pendulum on a cart.

			% Parameters
			g = obj.g;
			mc = obj.mc; bc = obj.bc;
			mp = obj.mp; lp = obj.lp; rp = obj.rp; Ip = obj.Ip; bp = obj.bp;

			% Time
			syms t;

			% Control inputs
			f = sym('f'); ft = sym('f(t)');

			% Generalized coordinates and derivatives
			x = sym('xc'); Dx = sym('Dxc');	xt = sym('xc(t)');
			for i = 1:nLinks
				theta(i) = sym(['theta' num2str(i)]);
				Dtheta(i) = sym(['Dtheta' num2str(i)]);
				thetat{i} = sym(['theta' num2str(i) '(t)']);
			end % for

			% Cart kinematics and energy
			U = sym(0);
			T = 1/2*mc*diff(xt, t)^2;
			D = 1/2*bc*diff(xt, t)^2;
			Q = xt*ft;

			% First pendulum kinematics and energy
			xp = xt + rp*cos(thetat{1});
			yp = rp*sin(thetat{1});
			U = U + mp*g*yp;
			T = T + 1/2*mp*(diff(xp, t)^2 + diff(yp, t)^2) + 1/2*Ip*diff(thetat{1}, t)^2;
			D = D + 1/2*bp*diff(thetat{1}, t)^2;

			% Rest of the pendulum kinematics and energy
			for i = 2:nLinks
				xp = xp + (lp - rp)*cos(thetat{i-1}) + rp*cos(thetat{i});
				yp = yp + (lp - rp)*sin(thetat{i-1}) + rp*sin(thetat{i});
				U = U + mp*g*yp;
				T = T + 1/2*mp*(diff(xp, t)^2 + diff(yp, t)^2) + 1/2*Ip*diff(thetat{i}, t)^2;
				D = D + 1/2*bp*diff(thetat{i} - thetat{i-1}, t)^2;
			end % for

			% Define system Lagrangian
			L = T - U;

			% Define generalized coordinate, input, and parameters arrays
			q = [x theta]; Dq = [Dx Dtheta];
			u = [f];
			p = [g mc bc Ip mp bp rp lp];

			% Compute equations of motion from Lagrangian
			[M, f] = lagrangian(L, D, Q, q, u, p);

			% Simplify manipulator equation matrices (Rough 5 step simplification is enough)
			M = simplify(M, 5);
			f = simplify(f, 5);
		end % deriveDynamics

		function [M, f] = secondOrderStateEquation(obj, t, x, xdot, u, m)
		%SECONDORDERSTATEEQUATION The system state equation.

% 			kp_wall = 100;
% 			kd_wall = 20;
% 			u_wall = -kp_wall*(x(1) - obj.xLim) - kd_wall*(xdot(1));
% 			u = u + u_wall;
		
			% Inertia matrix
			M = obj.MFcn(x + [0 pi/2]', xdot, u);	% theta == 0, up right

			% Gravity and other terms
			f = obj.fFcn(x + [0 pi/2]', xdot, u);		
			
		end % secondOrderStateEquation
	end % methods
end % classdef
