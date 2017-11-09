function Fcn = sym2func(s, vars)
%SYM2FUNC Convert symbolic expression to function handle.
%
% Description:
% 	Faster version of built in matlabFunction.
%
% Copyright 2014 Mikhail S. Jones

	% Check variable input data type
	if ~isa(vars, 'cell')
		error('coalesce:sym2func', ...
			'Vars input must be a cell array.');
	end % if

	% Loop through each cell
	for i = 1:numel(vars)
		% Check variable input data type
		if ~isa(vars{i}, 'sym')
			error('coalesce:sym2func', ...
				'Vars input must be a cell array of symbolics.');
		end % if

		% Check variable size
		if size(vars{i}, 1) == 1
			isRow(i) = false;
		elseif size(vars{i}, 2) == 1
			isRow(i) = true;
		else
			error('coalesce:sym2func', ...
				'Vars input must be a cell array of symbolic vectors.');
		end % if
	end % for

	% Convert symbolic expression to string and pad it with spaces
	str = [' ' char(s) ' '];

	% COnvert symbolic matrix to a MATLAB friendly syntax
	str = strrep(str, 'matrix', '');
	str = strrep(str, '], [', ']; [');

	% Loop through each variable
	for i = 1:numel(vars)
		for j = 1:numel(vars{i})
			% Construct regular expression replacement pattern
    	pat = ['(?<=\W)' char(vars{i}(j)) '(?=[^a-zA-Z_0-9\(])'];

    	% Vectorized expression replacement
    	if isRow(i)
    		str = regexprep(str, pat, ['in' num2str(i) '(' num2str(j) ',:)']);
    	else
    		str = regexprep(str, pat, ['in' num2str(i) '(:,' num2str(j) ')']);
    	end % if
    end % for
  end % for

  % Construct input arguments
  in = sprintf('in%d,', 1:numel(vars));
	str = ['@(' in(1:end-1) ')' str];

	% Convert string to a function handle
	Fcn = str2func(str);
end % sym2func
