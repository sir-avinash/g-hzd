%SYM2CELL_TEST
%
% Description:
%   This script benchmarks the sym2cell function versus alternative methods.
%
% Copyright 2013-2014 Mikhail S. Jones

% Clean up workspace
clear all; close all; clc;

% Vector of symbolic array lengths to benchmark
N = (5:5:50).^2;

% Parse functions
c = sym2cell(sym('s'));

% Loop through each array
for iN = 1:numel(N)
  % User feedback
  fprintf('%i%%\n', 100*iN/numel(N));

  % Initialize the symbolic array
  s = sym('s', [1, N(iN)]);

  % Benchmark sym2cell
  tic;
  c = sym2cell(s);
  t1(iN) = toc;

  % Benchmark arrayfun
  tic;
  c = arrayfun(@char, s, 'UniformOutput', false);
  t2(iN) = toc;
end % for

% Plot results
figure; hold on; grid on; box on;
plot(N, t1, 'r');
plot(N, t2, 'b');
xlabel('Symbolic array length');
ylabel('Time (sec)');
legend('sym2cell', 'arrayfun');
