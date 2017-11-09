function str = sym2str(expr, isVectorized)
%SYM2STR Convert symbolic expression into a string.
%
% Description:
%   Generates matlab equations from a symbolic expression. Essentially
%   a leaner faster version of matlabFunction that only outputs the
%   equations and not the function.
%
% Copyright 2013-2014 Mikhail S. Jones

  if nargin == 1
    isVectorized = false;
  end % if

  % Convert to string
  str = char(expr);

  % Remove matrix, vector, or array from string
  str = strrep(str, 'matrix([[', '[');
  str = strrep(str, 'array([[', '[');
  str = strrep(str, 'vector([', '[');
  str = strrep(str, ']])', ']');
  str = strrep(str, '])', ']');

  % Modify operators not already vectorized
  if isVectorized
    str = regexprep(str, '(?<=[^.])*', '.*');
    str = regexprep(str, '(?<=[^.])/', './');
    str = regexprep(str, '(?<=[^.])\^', '.^');
  end %if
end % sym2str
