function [y,dy,ddy,h0,hd,s] = PolyConstraint2_MARLOnoSpring_walkinplace(x,xdot,xddot,s,ds,alpha)

if length(x) == 7
    T = [0 0 1 1/2 1/2 0 0];
    H = [0 0 0 1/2 1/2 0 0; 0 0 0 0 0 1/2 1/2; 0 0 0 -1 1 0 0; 0 0 0 0 0 -1 1];
elseif length(x) == 5
    T = [1 1/2 1/2 0 0];
    H = [0 1/2 1/2 0 0; 0 0 0 1/2 1/2; 0 -1 1 0 0; 0 0 0 -1 1];
else
    disp('Wrong length of x')
    return
end
    
        h0 = H*x;
        hd = bezierval(alpha, s)+bezierval(alpha, s);
        y = h0-hd;

        h0dot = H*xdot;
        dy = h0dot;

        h0ddot = H*xddot;
        ddy = h0ddot;

% HStar = H-bezierval(alphadot, s)/(thetaf - theta0)*T;
% dhdq2 = -bezierval(alphaddot, s)/(thetaf - theta0)^2*(T*xdot)'*(T*xdot);
% dhdq2 = -bezierval(alphaddot, s)/(thetaf - theta0)^2*thetadot.^2;

end
        
