function ind = str2ind(str)
%STR2IND Convert string to ind.
%
% Description:
%		Converts a string into a numerical index faster than str2num or
%		str2double. Takes of known format properties to generate string with
%		no overhead.
%
% Copyright 2013-2014 Mikhail S. Jones

	% Convert to numerical index
	ind = sscanf(str, '%f');
end % str2ind
