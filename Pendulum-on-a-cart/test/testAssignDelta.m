	d_x1 = -1:0.5:1;
	d_x2 = -pi/6:pi/12:pi/6;
	d_x3 = -2:1:2;
	d_x4 = -2:1:2;
	
	length1 = length(d_x1);
	length2 = length(d_x2);
	length3 = length(d_x3);
	length4 = length(d_x4);
	
	lengthTotal = length1 + length2 + length3 + length4;
	n = 1;
	d_x = zeros(4,lengthTotal);
	while n <= lengthTotal
		
		if n <= length1
			d1 = d_x1(n);
		else
			d1 = 0;
		end
		
		if n > length1 && n <= length1 + length2
			d2 = d_x2(n - length1);
		else
			d2 = 0;
		end
		
		if n > length1 + length2 && n <= length1 + length2 + length3
			d3 = d_x3(n - (length1 + length2));
		else
			d3 = 0;
		end
		
		if n > length1 + length2 + length3 && n <= length1 + length2 + length3 + length4
			d4 = d_x4(n - (length1 + length2 + length3));
		else
			d4 = 0;
		end
					
% 		d1 = 0;
% 		d2 = 0;
% 		d3 = 0;
% 		d4 = 0;
		d_x(:,n) = [d1 d2 d3 d4]';
		
		n = n + 1;
		
	end