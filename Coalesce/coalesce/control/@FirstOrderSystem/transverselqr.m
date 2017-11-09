function controller = transverselqr(obj, response, varargin)
%TRANSVERSELQR Transverse Linear Quadratic Regulator
%
% Syntax:
%		controller = obj.transverselqr(response, Q, R, N, Qf)
%
% Required Input Arguments:
%		response - (RESPONSE) Time response for the dynamical system
%
% Optional Input Arguments:
%		Q - (DOUBLE) LQR state cost
%		R - (DOUBLE) LQR input cost
%		N - (DOUBLE) LQR cost offset
%		Qf - (DOUBLE)
%
% Description:
%		This function construct a transverse coordinate system to project the
%		dynamics onto. This new transverse dynamic system is linearized and a
%		time varying LQR controller is designed around the nominal trajectory.
%		This reduces the dimensionality of the system and creates a time
%		invariant controller that can stabilize periodic orbits better than
%		standard LTV LQR. For more details refer to the reference below.
%
% References:
%		Manchester, Ian R. "Transverse dynamics and regions of stability for
%		nonlinear hybrid limit cycles." arXiv preprint arXiv:1010.2241 (2010)
%
% TODO:
%		- Add transverse impact maps for hybrid systems
%
% Copyright 2013-2014 Mikhail S. Jones

	% Number of states and inputs
	nx = numel(obj.states);
	nu = numel(obj.inputs);

	% Parse input arguments
	parser = inputParser;
	parser.addRequired('response', ...
		@(x) validateattributes(x, {'Response'}, {'numel', 1}));
	parser.addOptional('Q', eye(nx), ...
		@(x) validateattributes(x, {'double'}, {'size', [nx nx]}));
	parser.addOptional('R', eye(nu), ...
		@(x) validateattributes(x, {'double'}, {'size', [nu nu]}));
parser.addOptional('N', zeros(nx-1, nu), ...
		@(x) validateattributes(x, {'double'}, {'size', [nx-1 nu]}));
	parser.addOptional('Qf', eye(nx), ...
		@(x) validateattributes(x, {'double'}, {'size', [nx nx]}));
	parser.parse(response, varargin{:});
	opts = parser.Results;

	% Unpack trajectories from time response object
	[tStar, xStar, uStar, mStar] = response.unpack;

	% Check the Q matrix is positive definite
	if any(eig(opts.Q) <= 0)
		error('Q state cost matrix must be positive definite.');
	end % if

	% Check the Q matrix is symmetric
	if ~isequal(opts.Q, opts.Q.')
		error('Q state cost matrix must be symmetric.');
	end % if

	% Check the R matrix is symmetric
	if ~isequal(opts.R, opts.R.')
		error('R input cost matrix must be symmetric.');
	end % if

	% Check if trajectory is feasible
	% TODO

	% Check if trajectory is periodic
	% TODO

	% Linearize dynamics
	[AFcn, BFcn, CFcn, DFcn] = obj.linearize;

	% Loop through all dynamic modes in feasible trajectory
	for im = 1:numel(mStar)
		% Evaluate the nonlinear dynamics along the nominal trajectory
		nt = numel(tStar{im});
		clear f;
		for it = nt:-1:1
	  	f(:,it) = obj.stateEquation(tStar{im}(it), xStar{im}(:,it), uStar{im}(:,it), mStar{im});
	  end % for

	  % We choose transversal planes that are orthogonal to the system motion
	  z{im} = normc(f);
	  zTraj{im} = Trajectory(tStar{im}, z{im});
	  dzTraj{im} = fnder(zTraj{im});

	  % Choose a vector w so it is not collinear with z(tau) for any tau
	  w = eye(nx,1); % Arbitrary guess should work in almost all cases

	  % Choose a fixed orthonormal basis with w as its first element
	  eta = [w, null(w')];

		% Compute time variant transverse dynamics around feasible trajectory
		for it = nt:-1:1
			% Evaluates dynamics at current position and time
			ft = f(:,it);
			At = AFcn(xStar{im}(:,it), uStar{im}(:,it), mStar{im});
			Bt = BFcn(xStar{im}(:,it), uStar{im}(:,it), mStar{im});

			% Evaluate
		  zt = ppval(zTraj{im}, tStar{im}(it));
		  dzt = ppval(dzTraj{im}, tStar{im}(it));

			% Compute xi(tau) and dxi(tau)
			for ix = nx:-1:2
				% Store the jth column of eta to reduce indexing calls
				etaj = eta(:,ix);

				% Compute xi and dxi
		    xi(:,ix) = etaj - (etaj'*zt)/(1 + w'*zt).*(w + zt);
		    dxi(:,ix) = -(((etaj'*dzt).*(w + zt) + (etaj'*zt).*dzt).*(1 + w'*zt) - ...
			    (etaj'*zt).*(w + zt).*(w'*dzt))/(1 + w'*zt)^2;
			end % for
			xi(:,1) = zt;
			dxi(:,1) = dzt;

			% Compute projection operator Pi which defines the mapping such that
			% xperp = Pi(tau)*x
			Pi = xi(:,2:end)';
			dPi = dxi(:,2:end)';

			% Compute the linearized transverse dynamics in the new coordinate
			%	system (xperp, tau)
			Atr{im}(:,:,it) = dPi*Pi' + Pi*At*Pi' - Pi*ft*(zt'*At*Pi' + dzt'*Pi')/(zt'*ft);
			Btr{im}(:,:,it) = Pi*Bt - Pi*ft*zt'*Bt/(zt'*ft);
			Pitr{im}(:,:,it) = Pi;
		end % for

		% Convert time variant linear transverse dynamics to piecewise polynomials
		ATraj{im} = Trajectory(tStar{im}, Atr{im});
		BTraj{im} = Trajectory(tStar{im}, Btr{im});
		PiTraj{im} = Trajectory(tStar{im}, Pitr{im});
		xTraj{im} = Trajectory(tStar{im}, xStar{im});
		uTraj{im} = Trajectory(tStar{im}, uStar{im});
	end % for

	% Concatenate trajectories
	ATraj = [ATraj{:}];
	BTraj = [BTraj{:}];
	PiTraj = [PiTraj{:}];
	xTraj = [xTraj{:}];
	uTraj = [uTraj{:}];
	zTraj = [zTraj{:}];

	% Project Q matrices onto transverse coordinates
	opts.Q = Pi*opts.Q*Pi';
	opts.Qf = Pi*opts.Qf*Pi';

	% Solve finite-horizon problem by integrating the continuous time Ricatti
	% equation backwards starting from Qf
	[t, x] = ode45(@riccati, [tStar{end}(end) tStar{1}(1)], opts.Qf);

	% Loop through time vector and compute gain schedule
	for it = numel(t):-1:1
		% Reshape from vector to matrix
		S = reshape(x(it,:), nx-1, nx-1);

		% Compute gain schedule
		k(:,:,it) = opts.R\(ppval(BTraj, t(it)).'*S + opts.N.');
	end % for

	% Convert time varying gain schedule to piecewise polynomials
	kTraj = Trajectory(t, k);

	% Generate controller
  controller = @(tau,x) ppval(uTraj, tau) + ppval(kTraj, tau)*ppval(PiTraj, tau)*(ppval(xTraj, tau) - x);
  controller = @(t,x) controller(computeTau(x), x);

  % Interpolate trajectories for fast tau computation method
  N = 1000;
  ts = linspace(tStar{1}(1), tStar{end}(end), N);
  xs = ppval(xTraj, ts);
  zs = ppval(zTraj, ts);


	function DP = riccati(t, P)
	%RICCATI Continuous algebraic Riccati equation.
	%
	% Copyright 2013-2014 Mikhail S. Jones

		% Evaluate time varying linearized dynamics
		At = ppval(ATraj, t); Bt = ppval(BTraj, t);

		% Reshape vector into matrix
		P = reshape(P, nx-1, nx-1);

		% Riccati differential equation
		DP = - At.'*P - P*At + (P*Bt + opts.N)/opts.R*(Bt.'*P + opts.N.') - opts.Q;

		% Reshape matrix into vector
		DP = DP(:);
	end % riccati

	function tau = computeTau(x)
	%COMPUTETAU Compute state based time invariant parameter tau.
	%
	% Copyright 2013-2014 Mikhail S. Jones

		% Determine which transverse planes intersect the current location by
		%	finding the value of tau where z(tau)'(x(tau)* - x) = 0
		switch 'fast'
		case 'accurate'
			% Compute defect z'(x* - x) and generate a spline
			defect = spline(vertcat(tStar{:}), sum([z{:}].*(vertcat(xStar{:})' - repmat(x, 1, nt))));

			% Find zero crossing of spline
			zero = fnzeros(defect);

			% Ignore intervals of zero crossings and only use first point
			taus = zero(1,:);

		case 'fast'
			% Compute defect z'(x* - x) and generate a spline
			defect = sum(zs.*(xs - repmat(x, 1, N)));

			% Find locations where adjacent values are above and below zero
			ind = find(sign(defect(1:end-1)) ~= sign(defect(2:end)));

			% Approximate crossing
			taus = ts(ind);
		end % switch

		% Determine euclidean distance from each zero crossing
		for it = numel(taus):-1:1
			r(it) = sqrt(sum((ppval(xTraj, taus(it)) - x).^2));
		end % for

		% Determine the closest zero crossing to the current system motion
		[~, ind] = min(r);
		tau = taus(ind);
	end % computeTau
end % transverselqr
