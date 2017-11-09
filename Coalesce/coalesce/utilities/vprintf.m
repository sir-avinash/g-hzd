function vprintf(varargin)
	if varargin{1}
		fprintf(varargin{2:end});
	end % if
end % vprintf
