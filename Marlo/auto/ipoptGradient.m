function [g] = ipoptGradient(var)
%IPOPTGRADIENT
%
% Auto-generated by COALESCE package (08-Nov-2016 09:55:43)
%
% Copyright 2013-2014 Mikhail S. Jones

	ig = [1,1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1,1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19),1+zeros(1,19)]';
	jg = [1,2:1:20,22:1:40,42:1:60,62:1:80,3:1:21,23:1:41,43:1:61,63:1:81,542,543:1:561,563:1:581,583:1:601,603:1:621,544:1:562,564:1:582,584:1:602,604:1:622]';
	sg(306,1) = 0; % Pre-allocation
	sg(1) = sum(((((((var(2:1:20).^2.0)+(var(22:1:40).^2.0))+(var(42:1:60).^2.0))+(var(62:1:80).^2.0))+((((var(3:1:21).^2.0)+(var(23:1:41).^2.0))+(var(43:1:61).^2.0))+(var(63:1:81).^2.0)))./2.0));
	sg(2:20) = (var(1).*((2.0.*var(2:1:20))./2.0));
	sg(21:39) = (var(1).*((2.0.*var(22:1:40))./2.0));
	sg(40:58) = (var(1).*((2.0.*var(42:1:60))./2.0));
	sg(59:77) = (var(1).*((2.0.*var(62:1:80))./2.0));
	sg(78:96) = (var(1).*((2.0.*var(3:1:21))./2.0));
	sg(97:115) = (var(1).*((2.0.*var(23:1:41))./2.0));
	sg(116:134) = (var(1).*((2.0.*var(43:1:61))./2.0));
	sg(135:153) = (var(1).*((2.0.*var(63:1:81))./2.0));
	sg(154) = sum(((((((var(543:1:561).^2.0)+(var(563:1:581).^2.0))+(var(583:1:601).^2.0))+(var(603:1:621).^2.0))+((((var(544:1:562).^2.0)+(var(564:1:582).^2.0))+(var(584:1:602).^2.0))+(var(604:1:622).^2.0)))./2.0));
	sg(155:173) = (var(542).*((2.0.*var(543:1:561))./2.0));
	sg(174:192) = (var(542).*((2.0.*var(563:1:581))./2.0));
	sg(193:211) = (var(542).*((2.0.*var(583:1:601))./2.0));
	sg(212:230) = (var(542).*((2.0.*var(603:1:621))./2.0));
	sg(231:249) = (var(542).*((2.0.*var(544:1:562))./2.0));
	sg(250:268) = (var(542).*((2.0.*var(564:1:582))./2.0));
	sg(269:287) = (var(542).*((2.0.*var(584:1:602))./2.0));
	sg(288:306) = (var(542).*((2.0.*var(604:1:622))./2.0));
	g = sparse(ig, jg, sg, 1, 1100);

end % ipoptGradient