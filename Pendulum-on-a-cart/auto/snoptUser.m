function [A,iAfun,jAvar,iGfun,jGvar] = snoptUser()
%SNOPTUSER
%
% Auto-generated by COALESCE package (12-Jul-2017 17:08:22)
%
% Copyright 2013-2014 Mikhail S. Jones

	A = [];
	iAfun = []';
	jAvar = []';
	iGfun = [1,1+zeros(1,12),1+zeros(1,12),2:1:14,2:1:14,2:1:14,2:1:14,2:1:14,2:1:14,15:1:27,15:1:27,15:1:27,15:1:27,28:1:39,28:1:39,28:1:39,28:1:39,28:1:39,40:1:51,40:1:51,40:1:51,40:1:51,40:1:51,52:1:63,52:1:63,52:1:63,52:1:63,52:1:63,64:1:75,64:1:75,64:1:75,64:1:75,64:1:75,76,77,78,79,80,81,82,83,84,85]';
	jGvar = [1,2:1:13,3:1:14,67:1:79,28:1:40,80:1:92,2:1:14,41:1:53,54:1:66,28:1:40,67:1:79,80:1:92,54:1:66,16:1:27,15:1:26,1+zeros(1,12),41:1:52,42:1:53,42:1:53,41:1:52,1+zeros(1,12),67:1:78,68:1:79,29:1:40,28:1:39,1+zeros(1,12),54:1:65,55:1:66,55:1:66,54:1:65,1+zeros(1,12),80:1:91,81:1:92,15,28,41,54,32,58,27,40,53,66]';
end % snoptUser