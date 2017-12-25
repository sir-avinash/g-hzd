function [uHip,hd,yHip,dyHip] = HipControl(HAlphaHip,s,ds,qHip,dqHip,ControlParams,EnableHipControl,qRoll,dqRoll,qSpringDef,isSim)

kp = ControlParams.Feedback.kp(5:6)./ControlParams.Feedback.epsilon(1).^2;
kd = ControlParams.Feedback.kd(5:6)./ControlParams.Feedback.epsilon(1);


% h0 = qHip;
h0 = [-qRoll;-qRoll+qHip(2)];
% h0_s = [0;qHip(2)];
% h0 = [-qRoll;qHip(2)];
% dh0 = dqHip;
dh0 = [-dqRoll;-dqRoll+dqHip(2)];
% dh0 = [-dqRoll;dqHip(2)];

% hd = bezierval(HAlphaHip,s);
% hd_s = [0;bezierval(HAlphaHip(2,:),s)];
% dhd = bezierval(diff(HAlphaHip,[],2)*5,s)*ds;

if EnableHipControl ~= 1
%    hd = [-qRoll-(qHip(1) - 0.0216);-qRoll + 0.0216];
%    dhd = [-dqRoll-(dqHip(1) - 0);-dqRoll - 0];

% set hip reference as a constant
   hd = [-qRoll-(qHip(1) - 0.0873*1); -qRoll + 0.0873*1];
   dhd = [-dqRoll-(dqHip(1) - 0);   -dqRoll + 0];

else

% hd = [0;min(max(qRoll+qHip(1)+(-0.0349/2),-0.0873*2),0)];
hd = [0;min(max(qRoll+qHip(1),-0.0873*2),0)];   % mirror law with saturation
% hd = [0;qRoll+qHip(1)];
dhd = [0;dqRoll+dqHip(1)];    % 2 DoF control
end

yHip = h0 - hd;
% yHip_s = h0_s - hd_s;
% dyHip = dh0 - dhd;
dyHip = dh0 - dhd;    % 2DoF control

if isSim
lb = -0.2;
ub = -0.5;
else
% Exp
lb = -0.4;
ub = -1;
end

s_st = scaleFactor(qSpringDef(1), lb*pi/180, ub*pi/180);
s_sw = scaleFactor(qSpringDef(2), lb*pi/180, ub*pi/180);
s = max(min(s,1),0.5);    % no negative s

if EnableHipControl ~= 1
    s_st = 1;
    uHip = -kp.*[s_st;1].*yHip - kd.*[1;1].*dyHip;
else
%     s_st = 1;
%     s_sw = 0;
%     s_sw = 1-s_st;
%     % uHip = -kp.*yHip - kd.*dyHip - kp./10.*yHip_s;
%     uHip = [0;-0.5]*max(s_st,s_sw);   % gravity compensation
    uHip = [0;0];   % gravity compensation
    uHip = uHip + -kp.*[s_st;(1-s_sw)].*yHip - kd.*[1;1].*dyHip;   % consider double support and scale the gain
    uHip(2) = uHip(2) + kp(2).*[s_sw].*yHip(1) + kd(2).*[1].*dyHip(1);
%     uHip(2) = +kp(2).*[s_sw].*yHip(1) + kd(2).*[s_sw].*dyHip(1);
end




% --Regulator--

uHip(2) = uHip(2) + kp(2)/5*(0 - qHip(2)) + kd(2)/5*(0 - dqHip(2));   % Outward 5 deg
% uHip = uHip + kp/10.*([0;0] - qHip) + kd/10.*([0;0] - dqHip);   % Outward 5 deg
% uHip(2) = uHip(2)+(-kp(2)/5*(qHip(2) - -0.0873));   % Outward 5 deg
% uHip(2) = uHip(2)+(-kp(2)*(qHip(2) - -0.0873));   % Outward 5 deg 2D

qHip2_d = HAlphaHip(2,6);
% uHip(2) = uHip(2)+(-kp(2)/5*(qHip(2) - qHip2_d)-kd(2)/5*(dqHip(2)-0));   % Outward 5 deg
% uHip(1) = uHip(1)+(-kp(1)/3*(qHip(1) + qHip2_d)-kd(1)/3*(dqHip(1)-0));   % Outward 5 deg
% uHip(1) = uHip(1)+(-kp(1)/5*(qHip(1) + qHip2_d));   % Outward 5 deg
% if 0.0873/2 < -(-qRoll+qHip(1))+0.0873
% uHip(2) = uHip(2)+(-kp(2)/3*(qHip(2) - qHip2_d));   % Outward 5 deg
% end
end

function s = scaleFactor(f, tl, tu)
%SCALEFACTOR Compute scalar (0 to 1) representing forces in leg.

  s = (clamp(f, tl, tu) - tl)/(tu - tl);
end % scaleFactor

function b = clamp(a, lim1, lim2)
  %CLAMP Clamp value between two bounds.

  % Find which limit is min and max
  a_min = min(lim1, lim2);
  a_max = max(lim1, lim2);

  % Clamp value between limits
  b = max(min(a, a_max), a_min);
end % clamp




