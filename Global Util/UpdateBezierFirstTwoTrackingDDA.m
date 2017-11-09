function h_alpha = UpdateBezierFirstTwoTrackingDDA(q,dq,StanceLeg,theta_limits,h_alpha)

if StanceLeg == 0
    qHipminus = q([13 10]);
    qminus = q([3 11 12 8 9]);
    dqminus = dq([3 11 12 8 9]);
    qHip = q([10 13]);
    q = q([3 8 9 11 12]);
    dq = dq([3 8 9 11 12]);
else
    qHipminus = q([10 13]);
    qminus = q([3 8 9 11 12]);
    dqminus = dq([3 8 9 11 12]);
    qHip = q([13 10]);
    q = q([3 11 12 8 9]);
    dq = dq([3 11 12 8 9]);
end


[Tzero,Tact,Tbzero,Tbact] = ATRIAS2D_ZD_TransformBAG;
T=[Tzero;Tact]; Tb=[Tbzero;Tbact]; 
T0=inv(T);
T1=-T0*Tb;

qbar=T*q+Tb;
dqbar=T*dq;
qact=qbar(2:5);
dqact=dqbar(2:5);
qzero=qbar(1);
dqzero=dqbar(1);

[s,ds,th,dth,delta_theta,c]=ATRIAS2D_SS_s_RigidBAG(qzero,dqzero,theta_limits);

yminus = get_yminus(qminus,dqminus,qHipminus,h_alpha,theta_limits);

h_alpha = halphaColumnShiftReset( h_alpha, s, [qact;qHip], yminus);
end

function yminus = get_yminus(qminus,dqminus,qHipminus,h_alpha,theta_limits)


[Tzero,Tact,Tbzero,Tbact] = ATRIAS2D_ZD_TransformBAG;
T=[Tzero;Tact]; Tb=[Tbzero;Tbact]; 
T0=inv(T);
T1=-T0*Tb;

qbar=T*qminus+Tb;
dqbar=T*dqminus;
qact=qbar(2:5);
dqact=dqbar(2:5);
qzero=qbar(1);
dqzero=dqbar(1);

% theta_limits = ControlParams.Output.ThetaLimits;
[s,ds,th,dth,delta_theta,c]=ATRIAS2D_SS_s_RigidBAG(qzero,dqzero,theta_limits);

yminus = [qact;qHipminus] - bezier(h_alpha,s);


end

