function [y1] = nnEquZero3_none270717(x1)
%NNEQUZERO3_NONE270717 neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 27-Jul-2017 00:17:03.
% 
% [y1] = nnEquZero3_none270717(x1) takes these arguments:
%   x = 4xQ matrix, input #1
% and returns:
%   y = 1xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.keep = [1 2 3];
x1_step2.xoffset = [-1.69590442012002;-2;0];
x1_step2.gain = [0.589655872191919;0.5;2.00501253132832];
x1_step2.ymin = -1;

% Layer 1
b1 = [-0.40461323257583476;-0.16318464102594651;4.5162550193261861;4.6715515650818888;0.99294656765773415;-3.9302561727021894;5.0466993529417792;-0.32722636055171833;1.4498335276841594;3.1128441042419959];
IW1_1 = [0.21550912288066007 0.46607827808269386 -0.74644588818591062;0.086372372815291587 -0.065437804877498895 0.25226196271412249;0.033880915843150609 0.10852708107744272 3.9962527181312892;0.18108248933040286 0.2533760185441421 -3.1201818066911451;-0.10573587324564153 -0.28707821012149082 -0.90843932744005929;0.14381342455257279 0.31155965983245332 -3.1223012798586769;-0.21530667888436375 -0.21761072382605184 -3.5909048888322253;0.16550229643006059 -0.062752328642254954 -0.1148463618924338;0.12165123947948182 -0.097387308868759792 -0.9856144918737767;-0.21303902173158554 -0.44334928334284929 2.1094932289267274];

% Layer 2
b2 = -6.4148949796998975;
LW2_1 = [3.48944499310532 14.355227581438335 -5.8189471036417171 29.194670917668496 10.229380212067083 -16.810636037681117 -18.096645111182134 -8.1556762927348068 -10.138231581988896 -13.307183925547996];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 0.668645916432596;
y1_step1.xoffset = -1.49555987021541;

% ===== SIMULATION ========

% Dimensions
Q = size(x1,2); % samples

% Input 1
xp1 = removeconstantrows_apply(x1,x1_step1);
xp1 = mapminmax_apply(xp1,x1_step2);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = repmat(b2,1,Q) + LW2_1*a1;

% Output 1
y1 = mapminmax_reverse(a2,y1_step1);
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
  y = bsxfun(@minus,x,settings.xoffset);
  y = bsxfun(@times,y,settings.gain);
  y = bsxfun(@plus,y,settings.ymin);
end

% Remove Constants Input Processing Function
function y = removeconstantrows_apply(x,settings)
  y = x(settings.keep,:);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
  x = bsxfun(@minus,y,settings.ymin);
  x = bsxfun(@rdivide,x,settings.gain);
  x = bsxfun(@plus,x,settings.xoffset);
end
