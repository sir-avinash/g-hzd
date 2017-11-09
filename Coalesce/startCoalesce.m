function startCoalesce
%STARTCOALESCE Start up script for COALESCE package.
%
% Description:
%		This script adds COALESCE packages to the MATLAB search path. It also
%		check dependencies and versions to ensure proper performance.
%
% Copyright 2013-2014 Mikhail S. Jones

	% Location of current folder on the file system
	currentFolder = pwd;

	% Add coalesce to MATLAB search path
	addpath(...
		[currentFolder '/coalesce/animation'], ...
		[currentFolder '/coalesce/animation/models'], ...
		[currentFolder '/coalesce/animation/utilities'], ...
		[currentFolder '/coalesce/control'], ...
		[currentFolder '/coalesce/optimize'], ...
		[currentFolder '/coalesce/optimize/solver'], ...
		[currentFolder '/coalesce/symbolic'], ...
		[currentFolder '/coalesce/utilities'], ...
		[currentFolder '/coalesce/utilities/notify'], ...
		[currentFolder '/lib/snoptStudent/'], ...
		[currentFolder '/lib/ipopt/']);

	% Check SNOPT dependency
	if ~exist('snopt')
		fprintf('\n');
		fprintf('SNOPT not found. COALESCE will attempt to use another solver instead.\n');
		fprintf('This may drastically reduce optimization performance.\n');
		fprintf('SNOPT can be obtained from:\n');
		fprintf('  - Student version available at (http://www.scicomp.ucsd.edu/~peg/Software.html)\n');
		fprintf('  - Full version available at ()\n');
		fprintf('\n');
	end % if

	% Check IPOPT dependency
	if ~exist('ipopt')
		fprintf('\n');
		fprintf('IPOPT not found. COALESCE will attempt to use another solver instead.\n');
		fprintf('This may drastically reduce optimization performance.\n');
		fprintf('IPOPT can be obtained from:\n');
		fprintf('  - Full version available at (http://www.coin-or.org/download/binary/Ipopt/)\n')
		fprintf('\n');
	end % if

	% Check FMINCON dependency
	if ~exist('fmincon')
		disp(' ');
		disp('FMINCON not found. COALESCE will attempt to use another solver instead.');
		disp('FMINCON can be obtained from:');
		disp('  - Trial version available at (http://www.mathworks.com/products/optimization/)')
		disp(' ');
	end % if
end % startCoalesce
