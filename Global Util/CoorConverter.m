function [H,T] = CoorConverter(t, x, xdot)
%%
	H = eye(8);
	H(3,:) = [0 0 1 1/2 1/2 0 0 0];
	H = [H(1:2,:);H(4:7,:);H(3,:);H(8,:)];
	T =inv(H);
	
end % CoorConverter