function [f] = ipoptObjective(var)
%IPOPTOBJECTIVE
%
% Auto-generated by COALESCE package (08-Nov-2016 09:55:43)
%
% Copyright 2013-2014 Mikhail S. Jones

	f(1,1) = 0; % Pre-allocation
	f(1) = ((var(1).*sum(((((((var(2:1:20).^2.0)+(var(22:1:40).^2.0))+(var(42:1:60).^2.0))+(var(62:1:80).^2.0))+((((var(3:1:21).^2.0)+(var(23:1:41).^2.0))+(var(43:1:61).^2.0))+(var(63:1:81).^2.0)))./2.0)))+(var(542).*sum(((((((var(543:1:561).^2.0)+(var(563:1:581).^2.0))+(var(583:1:601).^2.0))+(var(603:1:621).^2.0))+((((var(544:1:562).^2.0)+(var(564:1:582).^2.0))+(var(584:1:602).^2.0))+(var(604:1:622).^2.0)))./2.0))));
end % ipoptObjective