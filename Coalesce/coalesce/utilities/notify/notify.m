function notify(varargin)
%NOTIFY Send notification to desktop.
%
% Syntax:
%   notify
%   notify(message)
%   notify(message, title)
%   notify(message, title, isSound)
%
% Optional Input Arguments:
%   message - (CHAR)
%   title - (CHAR)
%   isSound - (LOGICAL)
%
% Description:
%   A desktop notification script that uses systems commands to produce a
%   desktop notification and sound. This works on linux systems with the
%   notify-send and pacmd packages.
%
% Copyright 2013-2014 Mikhail S. Jones

	% Location of current folder on the file system
	file = mfilename('fullpath');
	[filePath, ~, ~] = fileparts(file);

	% Icon file path
	iconPath = [filePath, '/matlab.png'];

	% Sound file path
	soundPath = [filePath, '/complete.oga'];

	switch nargin
	case 0
		message = 'Default desktop notification.';
		title = 'MATLAB';
		isSound = true;

	case 1
		message = char(varargin{1});
		title = 'MATLAB';
		isSound = true;

	case 2
		message = char(varargin{1});
		title = char(varargin{2});
		isSound = true;

	case 3
		message = char(varargin{1});
		title = char(varargin{2});
		isSound = logical(varargin{3});

	otherwise
		error('coalesce:utilities:notify', ...
			'Invalid number of input arguments.');
	end % switch

	if isunix
		% Send notification to desktop
		[~, ~] = unix(['notify-send -t 1000 -i ', iconPath, ...
			' ''', title, ''' ''', message, '''']);

		% Play completed sound
		if isSound
			[~, ~] = unix(['pacmd play-file ', soundPath, ' 1']);
		end % if
	else
		% Do nothing, not supported yet
	end % if
end % notify
