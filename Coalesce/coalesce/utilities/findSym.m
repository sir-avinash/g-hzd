function varargout = findSym(A)
%FINDSYM Find indexes of nonzero elements.
%
% Syntax:
%   [ind] = findSym(expr)
%   [i, j] = findSym(expr)
%   [i, j, s] = findSym(expr)
%
% Input Arguments:
%   A - (SYM) Symbolic matrix or vector
%
% Description:
%   MATLAB find on symbolics is very slow and results in lots of overhead.
%   This function converts the symbolic expression to strings, finds the
%   nonzero terms and then converts it back to symbolic. It can be up to 10
%   times faster in most cases but there are some cases were it is only
%   marginally faster. This has not been extensively benchmarked and your
%   mileage may vary.
%
% Notes:
%   This functions varies from the original matlab implementation for
%   single output arguments. Instead of returning linear indexes of the
%   nonzero terms, this returns a logical matrix ~(A = 0).
%
% Copyright 2013-2014 Mikhail S. Jones

	% Check data type
	switch class(A)
	case 'double'
		% If not then we are better off using regular find
		ind = ~(A == 0);
		S = A;

	case 'sym'
		% Convert symbolic array into cell array of strings
		S = sym2cell(A);

		% Find location of nonzero terms
		ind = ~strcmp('0', S);

	otherwise
		error('Invalid data type, must be either sym or double.');
	end % if

	switch nargout
	case {0, 1}
		% Return logical index
		varargout = {ind};

	case 2
		% Find location of nonzero elements
		[i, j] = find(ind);

		% Return indexes and values of only nonzero terms
		varargout = {i, j};

	case 3
		% Find location and value of nonzero elements
		[i, j] = find(ind);
		s = S(ind);

		% Check data type
		if isa(s, 'cell')
			% If it is a cell array of chars then convert to sym
			s = sym(s);
		end % if

		% Return indexes and values of only nonzero terms
		varargout = {i, j, s};

	otherwise
		error('Invalid number of output arguments.');
	end % switch
end % findSym
