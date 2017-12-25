function u = rigidFiveLinkController(t,x,xdot,HAlpha,theta_limit,T)

q = x;
dq = xdot;

theta = T*q;
dtheta = T*dq;

s = (theta-theta_limit(1))/(theta_limit(2)-theta_limit(1));
ds = dtheta/(theta_limit(2)-theta_limit(1));

H = [0 0 0 1/2 1/2 0 0; 0 0 0 0 0 1/2 1/2; 0 0 0 -1 1 0 0; 0 0 0 0 0 -1 1];
h0 = H*q;
dh0 = H*dq;
hd = bezierval(HAlpha, s);
dhd = bezierval(diff(HAlpha,[],2),s)*5*ds;
y = h0-hd;
dy = dh0 - dhd;

kp = 100;
kd = 40;

u = H(:,4:end)\(-kp*y - kd*dy);









