function [u, Output_data] = ControllerBackStepping(t, x)
	
	
	x1 = x([1,3]);
	x2 = x([2,4]);
	
% 	x2_d = [1.0000    1.1575;	0.0000    0.0000]*x1;
	x2_d = [0;0];
	k = -[40,5];
	u = k*(x2 - x2_d);
	
% 	u = 0;
	Output_data = 0;
	
	
end