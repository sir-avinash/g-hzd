function [h, dh, M] = outputCoordinate(q,dq)

[p4L,~,EL,~,~,~]= LagrangeModelAtriasConstraint2D(q,dq);
% h0_swLength = p4L(1) - q(1);
% h0_swHeight = p4L(2);
h0_swHeight = p4L(2) - q(2); % relative sw length
M34 = EL(:,2)';
M34(1,2) = M34(1,2) - 1;    % relative sw length
M12 =[0 0 0 1/2 1/2 0 0;
      0 0 0 0 0 1/2 1/2;
      0 0 0 -1 1 0 0;
      0 0 0 0 0 -1 1]; 
% M12 =[0 0 1 0 0 0 0;
%       0 0 0 0 0 1/2 1/2;
%       0 0 0 -1 1 0 0]; 
% M12 =[0 0 1 0 0 0 0;
%       0 0 0 0 0 1/2 1/2;
%       0 1 0 0 0 0 0]; 
M = [M12];
% M = [M12;M34];

% h = [M12*q; h0_swLength; h0_swHeight];
% h = [M12*q; h0_swHeight];
h = [M12*q];
dh = M*dq;