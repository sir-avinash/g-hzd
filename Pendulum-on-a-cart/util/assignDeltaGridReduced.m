function d_x = assignDeltaGridReduced()
	
	
	d_x1 = -1:0.5:1;
	d_x2 = 0;
	d_x3 = -2:1:2;
% 	d_x3 = 0;
	d_x4 = 0;
	
% 	d_x1 = [-1, -0.9 -0.8, 0, 0.8 0.9, 1];
% 	d_x2 = 0;
% 	d_x3 = [-2, -1.9,-1.8 0,1.8 1.9, 2];
% 	d_x4 = 0;
	
% 	d_x1 = -1.4:0.1:-1;
% 	d_x2 = 0;
% 	d_x3 = -1:0.1:-0.8;
% 	d_x4 = 0;
	
% 	d_x1 = -1:0.5/2:1;
% 	d_x2 = 0;
% 	d_x3 = -2:1/2:2;
% 	d_x4 = 0;

% 	d_x1 = 0;
% 	d_x2 = -pi/12:pi/24:pi/12;
% 	d_x3 = 0;
% 	d_x4 = -2:1:2;
	
	length1 = length(d_x1);
	length2 = length(d_x2);
	length3 = length(d_x3);
	length4 = length(d_x4);
	
	n = 1;

	for i4 = 1:length4
		for i3 = 1:length3
			for i2 = 1:length2
				for i1 = 1:length1
					
					d1 = d_x1(i1);
					d2 = d_x2(i2);
					d3 = d_x3(i3);
					d4 = d_x4(i4);
					
					d_x(:,n) = [d1 d2 d3 d4]';
					n = n + 1;
				end
			end
		end
		
	end
	
end