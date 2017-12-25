function saveData(x1,xdot1,xddot1,x2,xdot2,xddot2,x3,xdot3,xddot3,...
    x4,xdot4,xddot4,x5,xdot5,xddot5,y1,dy1,ddy1,y2,dy2,ddy2,y3,dy3,ddy3,...
    y4,dy4,ddy4,y5,dy5,ddy5,t1,t2,t3,t4,t5,alpha,alphadot,alphaddot,...
    kappa1,kappadot1,kappaddot1,kappa2,kappadot2,kappaddot2,filename)

save(filename,'')
for n = 1:nargin-1
    startIndex = regexp(inputname(n),'(x|y)');
    if startIndex~= 0
        eval([inputname(n),' = squeeze(eval(',inputname(n),'))'';']);
    else
        eval([inputname(n),' = eval(',inputname(n),');']);
    end
    
    save(filename,inputname(n),'-append');
end
