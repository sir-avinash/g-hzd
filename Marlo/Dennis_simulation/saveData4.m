function saveData4(x1,xdot1,t1,u1,...
		x2,xdot2,t2,u2,...
		x3,xdot3,t3,u3,...
		x4,xdot4,t4,u4,filename)
	
	save(filename,'')
	for n = 1:nargin-1
		startIndex = regexp(inputname(n),'(x|y|u)');
		if startIndex~= 0
			eval([inputname(n),' = squeeze(eval(',inputname(n),'))'';']);
		else
			eval([inputname(n),' = eval(',inputname(n),');']);
		end
		
		save(filename,inputname(n),'-append');
	end
