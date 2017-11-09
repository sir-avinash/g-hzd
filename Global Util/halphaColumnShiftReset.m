function [ halphaReset ] = halphaColumnShiftReset( halphaNominal, sPlus, qactPlus, yMinus)
% The purpose of this function is to reset halpha in an intuitive way given
% position information alone. This reset is ideal for position control with
% high gains and less accurate velocity information. The first column of
% halpha is updated to keep y+ = y-, the second column is updated to keep 
% the same shift in parameter values as the nominal halpha matrix. The
% reasoning behind this is to keep a consistent proportional gain torques 
% and consistent behavior of posture changes following impact to ensure
% good transition between stance legs after impact is declared.
% See hand derived formula from notes BAG20150619 [1]-[2].
% BAG20150619.

[n,Mtemp] = size(halphaNominal); M = Mtemp - 1;
if nargin == 3; yMinus = zeros(n,1); end

% hdesired contribution from columns that are not updated.
halphaEndColumns = [zeros(n,2) halphaNominal(:,3:end)];
hdEndColumns = bezier(halphaEndColumns,sPlus);

% Find nominal shift between first two columns of Bezier parameters.
alphaShift0to1 = halphaNominal(:,2) - halphaNominal(:,1);

% Update first two columns to keep y continuous.
alpha0 = (qactPlus - yMinus - alphaShift0to1*M*sPlus*(1-sPlus)^(M-1) - hdEndColumns) ...
    /((1-sPlus)^M + M*sPlus*(1-sPlus)^(M-1));
alpha1 = alpha0 + alphaShift0to1;

% Update halpha
halphaReset = [alpha0 alpha1 halphaNominal(:,3:end)];

end

