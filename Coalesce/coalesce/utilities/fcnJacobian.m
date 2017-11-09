function J = fcnJacobian(fcn, x0, method)
%FCNJACOBIAN Computes Jacobian of a function handle.
%
% Description:
%		This function computes the Jacobian of a function handle. Supported
%		methods include central finite differencing, and complex step
%		differentiation.
%
% TODO:
%		- Symbolic
% 	- Sparse options
%		- Split into separate methods in differentiation package
%
% Copyright 2014 Mikhail S. Jones

	if nargin == 2
		method = 'complex-step';
	end % if

	switch lower(method)
	case 'finite-diff'
		% Preallocate Jacobian
		J(numel(fcn(x0)),numel(x0)) = 0;

		% Step size
		delta = sqrt(eps);

		% Create (i-1) and (i+1) vectors
		x01 = x0;
		x02 = x0;

		% Loop through inputs
		for i = 1:numel(x0)
			% Offset next point by step size delta
			x01(i) = x0(i) - delta;
			x02(i) = x0(i) + delta;

			% Central differencing
			J(:,i) = fcn(x02) - fcn(x01);

			% Reset last point to original value
			x01(i) = x0(i);
			x02(i) = x0(i);
		end % for

		% Divide by step size
		J = J/(2*delta);

	case 'complex-step'
		% Preallocate Jacobian
		J(numel(fcn(x0)),numel(x0)) = 0;

		% Step size
		delta = eps;

		% Create evaluation vector
		x = x0;

		% Loop through inputs
		for i = 1:numel(x0)
			% Offset next point by step size delta
			x(i) = x0(i) + 1i*delta;

			% Complex step differentiation
			J(:,i) = imag(fcn(x))/delta;

			% Reset last point to original value
			x(i) = x0(i);
		end % for

	otherwise
		error('coalesce:utilities:fcnJacobian', ...
			'Not a supported method.');
	end % switch
end % fcnJacobian
