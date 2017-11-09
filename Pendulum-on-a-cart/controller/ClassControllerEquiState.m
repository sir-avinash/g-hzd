classdef ClassControllerEquiState < matlab.System
	% Untitled Add summary here
	%
	% This template includes the minimum set of functions required
	% to define a System object with discrete state.
	
	% Public, tunable properties
	properties
		Taction = 2
	end
	
	properties(DiscreteState)
		
	end
	
	% Pre-computed constants
	properties(Access = private)
		x_last = [0 0 0 0]'
		t_last = 0
		
	end
	
	methods(Access = protected)
		function setupImpl(obj)
			% Perform one-time calculations, such as computing constants
			
		end
		
		function [u, output_Data] = stepImpl(obj, t, x)
			% Implement algorithm. Calculate y as a function of input u and
			% discrete states.
			
			X = x;
			
			q = x(1:2);
			dq = x(3:4);
			
			x = q(1);
			theta = q(2);
			dx = dq(1);
			dtheta = dq(2);
			
			if 0
			% use full order states to learn controller, that stabilize the
			% equilibrium point
				tau = rem(t, obj.Taction);
				phi = [X; tau];	% Taction == 1			
% 				u = nnEqu_full(phi);	% L = gamma(x1);	
				u = nnEquFull260917(phi);	% L = gamma(x1);	
				
				u_ff = 0; u_fb = 0; hd = 0; h0 = 0;
				
			elseif 0
			% use backstepping inspired insertation function to learn
			% controller that drive state to equilibrium point
				A_d = 0;
				tau = rem(t, obj.Taction);
				R = [1 0 0 0; 0 0 1 0];
				phi = [R*X; tau; A_d];	% Taction == 1		
% 				phi = [R*X*exp(tau); tau; A_d];	% Taction == 1		
% 				label = nnEquZero_raw180817(phi);	% L = zeros(2);
				label = nnEquBack080917(phi);	% L = [0.0316    0.1084; 0.0000    0.0000];
				
				u_ff = label(1);
				hd = label(2:3);
% 				hd = label(2:3)*exp(-tau);
				h0 = [theta; dtheta];
				epsilon_inv = 1;
				k = [50*epsilon_inv^2 15*epsilon_inv];
% 				k = [49.6753*1 10.8539*1.5*1];
% 				k = [50*10 10*2];

				u_fb = k * (hd - h0);
% 				u_ff = 0;
% 				u_fb = 0;
				u_bar = u_ff + u_fb;
				
				% convert general input to the real input
				u = (-u_bar * (25*(3*cos(theta)^2 - 8))/3 - (- 25*cos(theta)*sin(theta)*dtheta^2 + 981*sin(theta)))/(50*cos(theta));
				
				
				
			elseif 0
			% use perioidic library to build the insertion function
				A_d = 0;
				tau = rem(t, obj.Taction);
				R = [1 -1 0 0; 0 0 1 -1];
				phi = [R*X; tau; A_d];	% Taction == 1	
% 				phi = [R*X*exp(tau); tau; A_d];	% Taction == 1	
				label = nnEquLibrary090917(phi);	% L = zeros(2);
% 				label = nnEquLibrary_raw180817(phi);	% L = zeros(2);
				u_ff = label(1);
				hd = label(2:3);
				h0 = [theta; dtheta];
				epsilon_inv = 1;
				k = [50*epsilon_inv^2 15*epsilon_inv];
% 				k = [50*10 10*2];

				u_fb = k * (hd - h0);
% 				u_ff = 0;
% 				u_fb = 0;
				u_bar = u_ff + u_fb;
				
				% convert general input to the real input
				u = (-u_bar * (25*(3*cos(theta)^2 - 8))/3 - (- 25*cos(theta)*sin(theta)*dtheta^2 + 981*sin(theta)))/(50*cos(theta));
				
				
			elseif 1
			% use periodic orbit to reach multiple target orbit.
				
				if t<=20
					dp0 = 0.5; p0 = -1;
				elseif t >20 && t <= 40
					dp0 = 0.0; p0 = 0;
				else
					dp0 = 1.2; p0 = 0;
				end

				tau = rem(t, obj.Taction);
				R = [1 -1 0 0; 0 0 1 -1];
				phi = [R*(X-[p0 0 0 0]'); tau; dp0];	% Taction == 1	
% 				phi = [R*X*exp(tau); tau; A_d];	% Taction == 1	
				label = nnOrbitLibrary090917(phi);	% L = zeros(2);
% 				label = nnEquLibrary090917(phi);	% L = zeros(2);
				
				u_ff = label(1);
				hd = label(2:3);
				h0 = [theta; dtheta];
				epsilon_inv = 1;
				k = [50*epsilon_inv^2 15*epsilon_inv];
% 				k = [50*10 10*2];

				u_fb = k * (hd - h0);
% 				u_ff = 0;
% 				u_fb = 0;
				u_bar = u_ff + u_fb;
				
				% convert general input to the real input
				u = (-u_bar * (25*(3*cos(theta)^2 - 8))/3 - (- 25*cos(theta)*sin(theta)*dtheta^2 + 981*sin(theta)))/(50*cos(theta));
				
				
								
			else
			% a bench test of LQR controller.
				k = [-1.0000   49.6753   -2.7716   10.8539];
				u = -k*X;
				
				u_ff = 0; u_fb = 0; hd = 0; h0 = 0;
				
			end
			
			P = [
				  0.04         -0.11          0.03         -0.03
				 -0.11          0.94         -0.12          0.18
				  0.03         -0.12          0.03         -0.03
				 -0.03          0.18         -0.03          0.04
				];% J(x)


			
			output_Data = X'* P* X;	% plot Lyapunov function
% 			output_Data = hd - h0;	% plot tracking error
% 			output_Data = hd(1) - h0(1);
% 			output_Data = [u_ff, u_fb];	% plot the learned and feedback torque
			
		end
		
		function resetImpl(obj)
			% Initialize / reset discrete-state properties
		end
	end
end
