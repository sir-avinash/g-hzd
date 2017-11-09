function [q,dq,T,H2,H1,H0,hd] = CoorConverter_ZD(t, x, xdot, hAlphaSet)
	%%
	dxSet = -0.6:0.2:1;   % 11-Feb
	hSet = [-0.1:0.1:0.1];
	dxInput = 0.4;
	hInput = 0;
	HAlpha = interpolateRoughGround(hAlphaSet,dxSet,dxInput, hSet, hInput);
	s = x(8);
% 	s = min(max(s,-1),1);
	ds = xdot(8);
% 	dds = 0;
	H_link = [1 0 0 0 0; 0 0 0 1/2 1/2; 0 -1 1 0 0; 0 0 0 -1 1];
	H0 = blkdiag(eye(2),[H_link;1 1/2 1/2 0 0],1);
	hd = bezierval(HAlpha,s);
% 	dhd = bezierval(diff(HAlpha,[],2),s)*5*ds;
% 	ddhd = bezierval(diff(HAlpha,[],2),s)*5*dds + bezierval(diff(diff(HAlpha,[],2),[],2),s)*5*4*ds.^2;
	B1 = bezierval(diff(HAlpha,[],2),s)*5;
	B2 = bezierval(diff(diff(HAlpha,[],2),[],2),s)*5*4*ds.^2;
	
	H1 = blkdiag(eye(2), [[H_link,-B1];1 1/2 1/2 0 0 0; 0 0 0 0 0 1]);
	H2 = [0;0;-B2;0;0];
	T = inv(H1);
	hd = [0;0;hd;0;0];
	
	q = H0\(x + hd);
	dq = T*xdot;
	
% 	ddq = T*xddot - T*H2;
	
end % CoorConverter