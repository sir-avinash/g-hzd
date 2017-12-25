function [y,dy,ddy,h0,hd,s] = PolyConstraint2_MARLOnoSpring(x,xdot,xddot,alpha,alphadot,alphaddot,theta0,thetaf)

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
theta = T*x;
thetadot = T*xdot;
thetaddot = T*xddot;

if nargin <= 6
theta0 = T*x.initial;
thetaf = T*x.final;
end

s = (theta - theta0)/(thetaf - theta0);
    
        h0 = H*x;
        hd = bezierval(alpha, s);
        y = h0-hd;

        h0dot = H*xdot;
        hddot = bezierval(alphadot, s)/(thetaf - theta0)*thetadot;
        dy = h0dot-hddot;

        h0ddot = H*xddot;
        hdddot = bezierval(alphadot, s)/(thetaf - theta0)*thetaddot+...
                 bezierval(alphaddot, s)/(thetaf - theta0)^2*thetadot.^2;
        ddy = h0ddot-hdddot;

% HStar = H-bezierval(alphadot, s)/(thetaf - theta0)*T;
% dhdq2 = -bezierval(alphaddot, s)/(thetaf - theta0)^2*(T*xdot)'*(T*xdot);
% dhdq2 = -bezierval(alphaddot, s)/(thetaf - theta0)^2*thetadot.^2;

end
        
