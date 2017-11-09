function sym2matlab(expr, name)
%SYM2MATLAB Convert symbolic expression into matlab code.
%
% Description:
%   Generates matlab equations from a symbolic expression.
%
% Copyright 2013-2014 Mikhail S. Jones

  % Simplify expression
  expr = simplify(vpa(expr));

  % Loop through each element in symbolic array
  for d1 = 1:size(expr,1)
    for d2 = 1:size(expr,2)
      % Check if a non zero term exists
      if expr(d1,d2) ~= 0
        % Write MATLAB code version of symbolic expression
        fprintf('%s(%d,%d) = %s;\n', ...
          name, d1, d2, char(expr(d1,d2)));
      end % if
    end % for
  end % for
end % sym2matlab
