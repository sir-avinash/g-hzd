function [c] = ipoptConstraints(var)
%IPOPTCONSTRAINTS
%
% Auto-generated by COALESCE package (22-Dec-2017 00:16:59)
%
% Copyright 2013-2014 Mikhail S. Jones

	c(8407,1) = 0; % Pre-allocation
	c(1:1201) = (((2.0.*var(6007:1:7207))+((-(sin((var(2404:1:3604)+1.5707963267948966)))./2.0).*var(7208:1:8408)))-(var(2:1:1202)+(((var(4806:1:6006).^2.0).*cos((var(2404:1:3604)+1.5707963267948966)))./2.0)));
	c(1202:2402) = ((((-(sin((var(2404:1:3604)+1.5707963267948966)))./2.0).*var(6007:1:7207))+(0.33333333333333331.*var(7208:1:8408)))-(-((981.0.*cos((var(2404:1:3604)+1.5707963267948966))))./200.0));
	c(2403:3602) = ((var(1204:1:2403)-var(1203:1:2402))-(((var(1)./1200.0).*(var(3605:1:4804)+var(3606:1:4805)))./2.0));
	c(3603:4802) = ((var(3606:1:4805)-var(3605:1:4804))-(((var(1)./1200.0).*(var(6007:1:7206)+var(6008:1:7207)))./2.0));
	c(4803:6002) = ((var(2405:1:3604)-var(2404:1:3603))-(((var(1)./1200.0).*(var(4806:1:6005)+var(4807:1:6006)))./2.0));
	c(6003:7202) = ((var(4807:1:6006)-var(4806:1:6005))-(((var(1)./1200.0).*(var(7208:1:8407)+var(7209:1:8408)))./2.0));
	c(7203:8403) = var(3605:1:4805);
	c(8404) = (var(1203)-var(2403));
	c(8405) = (var(2404)-var(3604));
	c(8406) = (var(3605)-var(4805));
	c(8407) = (var(4806)-var(6006));
end % ipoptConstraints