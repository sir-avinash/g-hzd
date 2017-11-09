function [theta_limits] = interpolateTheta(theta_limits_norm,dxSet,dx, hSet, h)

minAbs = abs(dxSet - dx);
[~, AIdx] = sort(minAbs);
AIdx = AIdx(1:2);
theta_limits_hSet = (theta_limits_norm(:,:,AIdx(1),:)*(dxSet(AIdx(2))-dx) +...
    theta_limits_norm(:,:,AIdx(2),:)*(dx-dxSet(AIdx(1))))/(dxSet(AIdx(2))-dxSet(AIdx(1)));

minAbs = abs(hSet - h);
[~, AIdx] = sort(minAbs);
AIdx = AIdx(1:2);
theta_limits = (theta_limits_hSet(:,:,:,AIdx(1))*(hSet(AIdx(2))-h) +...
    theta_limits_hSet(:,:,:,AIdx(2))*(h-hSet(AIdx(1))))/(hSet(AIdx(2))-hSet(AIdx(1)));

% Jtheta1 = (theta_limits_norm(AIdx(2),1) - theta_limits_norm(AIdx(1),1))/(dxSet(AIdx(2))-dxSet(AIdx(1)));
% Jtheta2 = (theta_limits_norm(AIdx(2),2) - theta_limits_norm(AIdx(1),2))/(dxSet(AIdx(2))-dxSet(AIdx(1)));
% Jdetlatheta = Jtheta1 - Jtheta2;