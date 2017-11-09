function str = ind2str(ind)
%IND2STR Convert index to string.
%
% Description:
%		Converts a numerical array into a string faster than num2str. Takes
%		of known format properties to generate string with no overhead.
%
% Copyright 2013-2014 Mikhail S. Jones

	% Create string
	str = sprintf('%.0f ', ind);
end % ind2str
