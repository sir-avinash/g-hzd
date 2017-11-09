function controller = tvlqr(obj, response, varargin)
%TVLQR Time Variant Linear Quadratic Regulator
%
% Syntax:
%		controller = obj.tvlqr(response, Q, R, N, horizon)
%
% Required Input Arguments:
%		response - (RESPONSE) Time response for the dynamical system
%
% Optional Input Arguments:
%		Q - (DOUBLE) LQR state cost
%		R - (DOUBLE) LQR input cost
%		N - (DOUBLE) LQR cost offset
%		horizon - (CHAR) Horizon type (periodic, finite)
%
% Description:
%		This method linearizes the system around the nominal trajectory
%		resulting in a linear time varying system. A time varying LQR
%		controller is then constructed by integrating the continuous algebraic
%		Riccati equation backwards through time.
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
	parser.addOptional('N', zeros(nx, nu), ...
		@(x) validateattributes(x, {'double'}, {'size', [nx nu]}));
	parser.addOptional('horizon', 'finite', ...
		@(x) ischar(validatestring(lower(x), {'finite', 'periodic'})));
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

	% Linearize dynamics
	[AFcn, BFcn, CFcn, DFcn] = obj.linearize;

	% Loop through all dynamic modes in feasible trajectory
	for im = 1:numel(mStar)
		% Compute time variant linear dynamics around feasible trajectory
		for it = numel(tStar{im}):-1:1
			A{im}(:,:,it) = AFcn(xStar{im}(:,it), uStar{im}(:,it), mStar{im});
			B{im}(:,:,it) = BFcn(xStar{im}(:,it), uStar{im}(:,it), mStar{im});
		end % for

		% Convert time variant linear dynamics into piecewise polynomials
		ATraj{im} = Trajectory(tStar{im}, A{im});
		BTraj{im} = Trajectory(tStar{im}, B{im});
		xTraj{im} = Trajectory(tStar{im}, xStar{im});
		uTraj{im} = Trajectory(tStar{im}, uStar{im});
	end % for

	% Concatenate trajectories
	ATraj = [ATraj{:}];
	BTraj = [BTraj{:}];
	xTraj = [xTraj{:}];
	uTraj = [uTraj{:}];

	% Determine horizon type
	switch lower(opts.horizon)
	case 'finite'
		% Solve the continuous-time algebraic Riccati equations
		S = care(ppval(ATraj, tStar{end}(end)), ppval(BTraj, tStar{end}(end)), opts.Q, opts.R);

		% Solve finite-horizon problem by integrating the continuous time
		% Ricatti equation backwards starting from infinite-time
		% horizon solution
		[t, x] = ode45(@riccati, [tStar{end}(end) tStar{1}(1)], S);

	case 'periodic'
		% Initialize matrices and counter
		xf = eye(nx); err = []; c = 0;

		% Set ODE solver options
		options = odeset('AbsTol', 1e-12, 'RelTol', 1e-8);

		% Loop until error in boundary conditions converge
		while (c == 0) || (err >= 1e-6)
			% Advance counter
			c = c + 1;

			% User feedback
			fprintf('Iteration: %d, ', c);

			% Solve finite-horizon problem by integrating the Ricatti
			% differential equation backwards
			[t, x] = ode45(@riccati, [tStar{end}(end) tStar{1}(1)], xf, options);

			% Boundary conditions and error
			x0 = reshape(x(1,:,:), nx, nx);
			xf = reshape(x(end,:,:), nx, nx);
			err = max(max(abs((xf - x0)./x0)));

			% User feedback
			fprintf('Maximum absolute error: %f\n', err);
		end % while
	end % switch

	% Loop through time vector
	for i = numel(t):-1:1
		% Reshape from vector to matrix
		S = reshape(x(i,:), nx, nx);

		% Compute gain schedule
		k(:,:,i) = opts.R\(ppval(BTraj, t(i)).'*S + opts.N.');
	end % for

	% Convert time varying gain schedule to trajectory object
	kTraj = Trajectory(t, k);

	% Generate controller
	controller = @(t, x) ppval(uTraj,t) + ppval(kTraj,t)*(ppval(xTraj,t) - x);

	% For periodic controllers, use modulus of time
	if strcmp(lower(opts.horizon), 'periodic')
		controller = @(t,x) controller(mod(t, tStar{end}(end)), x);
	end % if

	function DP = riccati(t, P)
	%RICCATI Continuous algebraic Riccati equation.
	%
	% Copyright 2013-2014 Mikhail S. Jones

		% Evaluate time varying linearized dynamics
		At = ppval(ATraj, t); Bt = ppval(BTraj, t);

		% Reshape vector into matrix
		P = reshape(P, nx, nx);

		% Riccati differential equation
		DP = - At.'*P - P*At + (P*Bt + opts.N)/opts.R*(Bt.'*P + opts.N.') - opts.Q;

		% Reshape matrix into vector
		DP = DP(:);
	end % riccati
end % tvlqr
