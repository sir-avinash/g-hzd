function C = sym2cell(A)
%SYM2CELL Convert symbolic array into cell array of strings.
%
% Description:
%   Uses string manipulations to convert a symbolic array into
%   a cell array of strings. This is faster than other alternatives
%   such as using cellfun with char or a for loop with char as it
%   only requires a single call to the symbolic engine.
%
% Copyright 2013-2014 Mikhail S. Jones

	% Convert to string
	str = char(A);

	% Remove matrix, vector, or array from string
	str = strrep(str, 'matrix([[', '[');
	str = strrep(str, 'array([[', '[');
	str = strrep(str, 'vector([', '[');
	str = strrep(str, ']])', ']');
	str = strrep(str, '])', ']');

	% Modify delimiters
	str = strrep(str, '], [', ';');
	str = strrep(str, '[', '');
	str = strrep(str, ']', '');

	% Remove spaces
	str = strrep(str, ' ', '');

	% Split string expression into cell array
	str = regexp(str, ';', 'split');
	str = regexp(str, ',', 'split');
	C = vertcat(str{:});

	% Check for empty arrays
	if strcmp(C, '')
		C = char.empty;
	end %if
end % sym2cell
