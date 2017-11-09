function [f,G] = snoptUserFun(var)
%SNOPTUSERFUN
%
% Auto-generated by COALESCE package (12-Jul-2017 17:08:22)
%
% Copyright 2013-2014 Mikhail S. Jones

	f(85,1) = 0; % Pre-allocation
	f(1) = (var(1).*sum((((var(2:1:13).^2.0)+(var(3:1:14).^2.0))./2.0)));
	f(2:14) = (((2.0.*var(67:1:79))+((-(sin(var(28:1:40)))./2.0).*var(80:1:92)))-((var(2:1:14)-(var(41:1:53)./10.0))+(((var(54:1:66).^2.0).*cos(var(28:1:40)))./2.0)));
	f(15:27) = ((((-(sin(var(28:1:40)))./2.0).*var(67:1:79))+(0.33333333333333331.*var(80:1:92)))-((-(var(54:1:66))./100.0)-((981.0.*cos(var(28:1:40)))./200.0)));
	f(28:39) = ((var(16:1:27)-var(15:1:26))-(((var(1)./12.0).*(var(41:1:52)+var(42:1:53)))./2.0));
	f(40:51) = ((var(42:1:53)-var(41:1:52))-(((var(1)./12.0).*(var(67:1:78)+var(68:1:79)))./2.0));
	f(52:63) = ((var(29:1:40)-var(28:1:39))-(((var(1)./12.0).*(var(54:1:65)+var(55:1:66)))./2.0));
	f(64:75) = ((var(55:1:66)-var(54:1:65))-(((var(1)./12.0).*(var(80:1:91)+var(81:1:92)))./2.0));
	f(76) = (1.0-var(15));
	f(77) = (1.5707963267948966-var(28));
	f(78) = -(var(41));
	f(79) = -(var(54));
	f(80) = (1.5707963267948966-var(32));
	f(81) = -(var(58));
	f(82) = -(var(27));
	f(83) = (1.5707963267948966-var(40));
	f(84) = -(var(53));
	f(85) = -(var(66));
	G(405,1) = 0; % Pre-allocation
	G(1) = sum((((var(2:1:13).^2.0)+(var(3:1:14).^2.0))./2.0));
	G(2:13) = (var(1).*((2.0.*var(2:1:13))./2.0));
	G(14:25) = (var(1).*((2.0.*var(3:1:14))./2.0));
	G(26:38) = 2.0;
	G(39:51) = ((var(80:1:92).*(-(cos(var(28:1:40)))./2.0))-(((var(54:1:66).^2.0).*-(sin(var(28:1:40))))./2.0));
	G(52:64) = (-(sin(var(28:1:40)))./2.0);
	G(65:77) = -1.0;
	G(78:90) = 0.10000000000000001;
	G(91:103) = -(((cos(var(28:1:40)).*(2.0.*var(54:1:66)))./2.0));
	G(104:116) = ((var(67:1:79).*(-(cos(var(28:1:40)))./2.0))--(((981.0.*-(sin(var(28:1:40))))./200.0)));
	G(117:129) = (-(sin(var(28:1:40)))./2.0);
	G(130:142) = 0.33333333333333331;
	G(143:155) = 0.01;
	G(156:167) = 1.0;
	G(168:179) = -1.0;
	G(180:191) = -((((var(41:1:52)+var(42:1:53)).*0.08333333333333333)./2.0));
	G(192:203) = -(((var(1)./12.0)./2.0));
	G(204:215) = -(((var(1)./12.0)./2.0));
	G(216:227) = 1.0;
	G(228:239) = -1.0;
	G(240:251) = -((((var(67:1:78)+var(68:1:79)).*0.08333333333333333)./2.0));
	G(252:263) = -(((var(1)./12.0)./2.0));
	G(264:275) = -(((var(1)./12.0)./2.0));
	G(276:287) = 1.0;
	G(288:299) = -1.0;
	G(300:311) = -((((var(54:1:65)+var(55:1:66)).*0.08333333333333333)./2.0));
	G(312:323) = -(((var(1)./12.0)./2.0));
	G(324:335) = -(((var(1)./12.0)./2.0));
	G(336:347) = 1.0;
	G(348:359) = -1.0;
	G(360:371) = -((((var(80:1:91)+var(81:1:92)).*0.08333333333333333)./2.0));
	G(372:383) = -(((var(1)./12.0)./2.0));
	G(384:395) = -(((var(1)./12.0)./2.0));
	G(396) = -1.0;
	G(397) = -1.0;
	G(398) = -1.0;
	G(399) = -1.0;
	G(400) = -1.0;
	G(401) = -1.0;
	G(402) = -1.0;
	G(403) = -1.0;
	G(404) = -1.0;
	G(405) = -1.0;
end % snoptUserFun