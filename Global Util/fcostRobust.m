function J = fcostRobust(alpha_0,s_t, s_v, delta_q, BezierOrder)

% 	v = [ones(20,1) delta_theta delta_theta.^2 delta_theta.^3 delta_theta.^4 delta_theta.^5]';
% 	hd = (alpha_0*v)';
J = 0;
	for n = 1:3
	hd1 = bezierval(alpha_0(1,:), s_t(:,n)')';
	hd2 = bezierval(alpha_0(2,:), s_v(:,n)')';
	
J = J + var(delta_q(:,n) - hd1 - hd2)+sum((delta_q(:,n) - hd1 - hd2).^2);
	end