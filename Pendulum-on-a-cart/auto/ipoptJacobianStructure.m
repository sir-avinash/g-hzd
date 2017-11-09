function [J] = ipoptJacobianStructure(var)
%IPOPTJACOBIANSTRUCTURE
%
% Auto-generated by COALESCE package (02-Nov-2017 14:23:41)
%
% Copyright 2013-2014 Mikhail S. Jones

	iJ = [1:1:121,1:1:121,1:1:121,1:1:121,1:1:121,122:1:242,122:1:242,122:1:242,243:1:362,243:1:362,243:1:362,243:1:362,243:1:362,363:1:482,363:1:482,363:1:482,363:1:482,363:1:482,483:1:602,483:1:602,483:1:602,483:1:602,483:1:602,603:1:722,603:1:722,603:1:722,603:1:722,603:1:722,723,724,725,726,727,728,729,730]';
	jJ = [607:1:727,244:1:364,728:1:848,2:1:122,486:1:606,244:1:364,607:1:727,728:1:848,124:1:243,123:1:242,1+zeros(1,120),365:1:484,366:1:485,366:1:485,365:1:484,1+zeros(1,120),607:1:726,608:1:727,245:1:364,244:1:363,1+zeros(1,120),486:1:605,487:1:606,487:1:606,486:1:605,1+zeros(1,120),728:1:847,729:1:848,123,244,365,486,243,364,485,606]';
	sJ = 1 + zeros(1,3376);
	J = sparse(iJ, jJ, sJ, 730, 848);

end % ipoptJacobianStructure