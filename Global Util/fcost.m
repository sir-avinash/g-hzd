function J = fcost(alpha_0,s,ds,q_act, dq_act,BezierOrder,fitDq)

if nargin < 7
	fitDq = 1;
end

hd = bezierval(alpha_0, s);


if fitDq
	dhd = bezierval(diff(alpha_0, [], 2), s).*(BezierOrder-1).*ds;
	J = var(q_act - hd)+sum((q_act - hd).^2) +...
		10*(var(dq_act - dhd)+sum((dq_act - dhd).^2));
else
	J = var(q_act - hd)+sum((q_act - hd).^2);
end