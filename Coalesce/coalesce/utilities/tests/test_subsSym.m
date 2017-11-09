%TEST_SUBSSYM Test subsSym function.
%
%
% Copyright 2014 Mikhail S. Jones

clear all; close all; clc

% % Symbolic substitution
% old = sym('[x y z xx yy zz]');
% new = sym('[X Y Z A B C]');
% expr = sym('x + y + z + xx + yy + zz');
% S1 = subs(expr, old, new);
% S2 = subsSym(expr, old, new);
% fprintf('Symbolic substitution test: %d\n\n', logical(S1==S2));
%
% % Numeric substitution
% old = sym('[x y z]');
% new = sym('[1 2 3]');
% expr = sym('x + y/z - z*x + x^y');
% S1 = subs(expr, old, new);
% S2 = subsSym(expr, old, new);
% fprintf('Numeric substitution test: %d\n\n', logical(S1==S2));
%
% % % Vector substitution
% % old = {sym('x') sym('y')};
% % new = {sym('x', [1 10]) sym('y', [1 10])};
% % expr = sym('x + y');
% % S1 = subs(expr, old, new);
% % S2 = subsSym(expr, old, new);
% % fprintf('Vector substitution test: %d\n\n', all(logical(S1==S2)));
%
%
% % Check it doesn't fail when given weird datatypes
% old = sym('x');
% new = sym('X');
% S2 = subsSym(1, old, new);
% S2 = subsSym(sym.empty, old, new);
% S2 = subsSym(char.empty, old, new);
% S2 = subsSym(double.empty, old, new);
% S2 = subsSym(cell.empty, old, new);

for i = 1:10
  i
  N(i) = i^2;
  f = sym('a+b+c');
  old = {sym('a') sym('b') sym('c')};
  news = {sym('x') sym('y') sym('z')};
  newv = {sym('a', [1 N(i)]) sym('b', [1 N(i)]) sym('c', [1 N(i)])};

  tic;
  subs(f,old,news);
  t1(i) = toc;

  tic;
  subsSym(f,[old{:}],[news{:}]);
  t1b(i) = toc;

  tic;
  subs(f,old,newv);
  t2(i) = toc;
end

figure; hold on; grid on; box on;
plot(N, t1, 'r');
plot(N, t1b, '--r');
plot(N, t2, 'b');

break
% Speed comparison
fprintf('Speed comparison: \n');

% Warm up functions
subsSym(1,1,1);
subs(1,1,1);

P = 0.25:0.25:1;
N = 100*(1:10);

for iN = 1:numel(N)
    for iP = 1:numel(P)
        expr = sym('x', [1, N(iN)]);
        old = expr(1:round(P(iP)*N(iN)));
        new = sym('a', [1, round(P(iP)*N(iN))]);

        clear S;
        tic;
        S = subsSym(expr, old, new);
        t2(iP,iN) = toc;

        clear S;
        tic;
        S = subs(expr, old, new);
        t1(iP,iN) = toc;

        fprintf('\t%f times faster substituting %d%% of %d variables.\n', t1(iP,iN)/t2(iP,iN), 100*P(iP), N(iN));
    end % for
end % for

% Plot results
figure; hold on; grid on; box on;
plot(N, t2, '-');
plot(N, t1, '--');
legend(cellfun(@num2str, num2cell(P), 'UniformOutput', false));
xlabel('Number of variables in expression');
ylabel('Time (sec)');

% Plot results
figure; hold on; grid on; box on;
plot(N, t1./t2, '-');
legend(cellfun(@num2str, num2cell(P), 'UniformOutput', false));
xlabel('Number of variables in expression');
ylabel('Speed up factor');
