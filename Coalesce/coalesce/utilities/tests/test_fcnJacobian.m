% Clean up the workspace
close all; clear all; clc;

% Define function and vector
fcn = @(x) sin(x);
x0 = randn(1,10);

% Warm-up
fcnJacobian(fcn, x0, 'finite-diff');
fcnJacobian(fcn, x0, 'finite-diff');

% Numerical Jacobian
tic;
J = fcnJacobian(fcn, x0, 'finite-diff');
toc;

% Maximum absolute error
abs_max_error = max(max(abs(diag(cos(x0)) - J)))

% Warm-up
fcnJacobian(fcn, x0, 'complex-step');
fcnJacobian(fcn, x0, 'complex-step');

% Numerical Jacobian
tic;
J = fcnJacobian(fcn, x0, 'complex-step');
toc;

% Maximum absolute error
abs_max_error = max(max(abs(diag(cos(x0)) - J)))
