function saveData2Steps(x1,xdot1,t1,u1,...
		x2,xdot2,t2,u2,filename)
	
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
