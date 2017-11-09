function [h, dh, M] = outputCoordinate(q,dq)

[p4L,p4,EL,ER,~,~]= LagrangeModelAtriasConstraint2D(q,dq);
% h0_swLength = p4L(1) - q(1);
h0_swRelHeight =  p4L(2) - p4(2);
M34 = EL(:,2)' - ER(:,2)';
% M34(1,1) = M34(1,1) - 1;    % relative sw length
M12 =[0 0 1 0 0 0 0;
      0 0 0 0 0 1/2 1/2;
      0 0 0 -1 1 0 0;
      0 0 0 0 0 -1 1];

% M12 =[0 0 1 0 0 0 0;
%       0 0 0 0 0 1/2 1/2;
%       0 1 0 0 0 0 0]; 

M = [M12];
% M = [M12;M34];


% h = [M12*q; h0_swRelHeight];
h = [M12*q];
dh = M*dq;