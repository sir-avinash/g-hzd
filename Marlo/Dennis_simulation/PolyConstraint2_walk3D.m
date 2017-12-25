function [y,h0,hd,s] = PolyConstraint2_walk3D(x,alpha,theta0,thetaf)

T = [0 0 1 1/2 1/2 0 0];
theta = T*x;

s = (theta-theta0)/(thetaf-theta0);

H = [0 0 0 1/2 1/2 0 0; 0 0 0 0 0 1/2 1/2; 0 0 0 -1 1 0 0; 0 0 0 0 0 -1 1];
h0 = H*x;
hd = bezierval(alpha, s);
y = h0-hd;

end
        
