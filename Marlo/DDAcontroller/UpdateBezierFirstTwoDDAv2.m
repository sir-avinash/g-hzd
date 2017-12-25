function h_alpha = UpdateBezierFirstTwoDDAv2(q,dq,ControlState,ControlParams,h_alpha, yminus, dyminus)
% -- initial data --
HAlphaDDA = h_alpha;
Tfd = [25.0000   25.0000   0      0         0     0
         0         0       0   25.0000   25.0000  0
  -50.0000   50.0000       0         0         0  0
         0         0       0  -50.0000   50.0000  0
                                     zeros(1,4) 1 0
                                     zeros(1,4) 0 1];
kpn = ControlParams.Feedback.kp;
kdn = ControlParams.Feedback.kd;
epsilon = ControlParams.Feedback.epsilon(1);
kp = kpn/epsilon^2;
kd = kdn/epsilon;
if ControlState.StanceLeg == 0
    qHip = q([10 13]);
    dqHip = dq([10 13]);
    qLegS = q([3 4 5]);
    dqLegS = dq([3 4 5]);
    q = q([3 8 9 11 12]);
    dq = dq([3 8 9 11 12]);
else
    qHip = q([13 10]);
    dqHip = dq([13 10]);
    qLegS = q([3 6 7]);
    dqLegS = dq([3 6 7]);
    q = q([3 11 12 8 9]);
    dq = dq([3 11 12 8 9]);
end
theta_limits = ControlParams.Output.ThetaLimits;
[Tzero,Tact,Tbzero,Tbact] = ATRIAS2D_ZD_TransformBAG;
theta = Tzero*[qLegS;0;0]+Tbzero;
s = (theta-theta_limits(1))/(theta_limits(2)-theta_limits(1));
s = max(min(s,1.0),-0.0);

h0 = [Tact*q;qHip];

b = bezierterm(HAlphaDDA,s);

% -- update b3 only --
index_b = 3;
index_left = setdiff(1:size(HAlphaDDA,2),index_b);

halpha_4 = HAlphaDDA(:,index_b);

halpha_left = HAlphaDDA(:,index_left);
b_4 = b(index_b);
b_left = b(index_left);

hd_4 = halpha_4*b_4;
hd_left = halpha_left*b_left;

equ_left = y_minus-h0+hd_left;
A = -b_4;

halpha_4_plus = equ_left/A;

HAlphaDDA_plus = HAlphaDDA;
HAlphaDDA_plus(:,index_b) = halpha_4_plus;

h_alpha = HAlphaDDA_plus;
