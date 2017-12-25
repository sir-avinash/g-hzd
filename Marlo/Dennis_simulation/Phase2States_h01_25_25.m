function [nlp, x1, xdot1, u1, t1, F1, g1_final, dxe1, Fe1] =...
		Phase2States4(nlp,sys, height, lb0, ub0, kf, phaseN, stepLength)

x1 = nlp.phase(phaseN).state(1:7); % States positions
xdot1 = nlp.phase(phaseN).state(8:14); % States velocities
u1 = nlp.phase(phaseN).input; % Control inputs
t1 = nlp.phase(phaseN).duration; % Phase duration
F1 = nlp.phase(phaseN).lambda; % External forces (Fx, Fz)

[g1_final, ~, ~] = sys.constraintEquation(x1.final, xdot1.final, 'ds');
nlp.addConstraint(lb0+height,g1_final(4),ub0+height);

% Add minimum displacement
% d1 = nlp.addVariable(0, -1, 1); % Slack variable for distance
% % nlp.addConstraint(lb0, stepLength - (x1(1).final - x1(1).initial), ub0); % Constraint distance to be travel of hip during one step
nlp.addConstraint(lb0+stepLength,g1_final(3)-g1_final(1),ub0+stepLength); % final step length

% Redefine average speed
averageSpeed = stepLength/t1;

lExtLim = deg2rad(30+5);
lFleLimStance = deg2rad(100);
lFleLimSwing = deg2rad(100);
lAMin = deg2rad(100);
lAMax = deg2rad(260);
lBMin = deg2rad(100);
lBMax = deg2rad(260);
lTMin = deg2rad(-2);    % lean forward
lTMax = deg2rad(2);

% Joint angles
nlp.addConstraint(lExtLim, x1(5) - x1(4), lFleLimStance); % Right leg length limits
nlp.addConstraint(lAMin, x1(4), lAMax); % Left leg motor A limits
nlp.addConstraint(lBMin, x1(5), lBMax); % Left leg motor B limits
nlp.addConstraint(lExtLim, x1(7) - x1(6), lFleLimSwing); % Left leg length limits

nlp.addConstraint(lb0, (x1(7).final + x1(6).final)/2-(x1(7).ind(18) + x1(6).ind(18))/2+deg2rad(3)*averageSpeed, ub0); % Left leg length limits
nlp.addConstraint(lAMin, x1(6), lAMax);
nlp.addConstraint(lBMin, x1(7), lBMax);
nlp.addConstraint(lTMin, x1(3), lTMax);
% nlp.addConstraint(-0.5, xdot1(3), 0.5);

% Motor velocities
nlp.addConstraint(-sys.DqmLim, xdot1(4), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot1(5), sys.DqmLim); % Left leg motor B limits
nlp.addConstraint(-sys.DqmLim, xdot1(6), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot1(7), sys.DqmLim); % Left leg motor B limits

% ==Impact map for phase 1==
[D, ~] = sys.secondOrderStateEquation(0, x1.final, xdot1.final, u1.final, '');
[g, G, ~] = sys.constraintEquation(x1.final, xdot1.final, 'ds');
G = G(3:4,:);
% [g, G, ~] = sys.constraintEquation(R*x1.final, R*xdot1.final, 'ss');
% G = G*R;
M = [D, -G.'; G, zeros(2)];
f = [D*xdot1.final; zeros(2,1)];
dxe1 = nlp.addVariable(zeros(7,1), -Inf(7,1), Inf(7,1));
Fe1 = nlp.addVariable(zeros(2,1), -Inf(2,1), Inf(2,1), ...
	'Description', 'Impact Forces');
nlp.addConstraint(lb0, M*[dxe1; Fe1] - f, ub0);

% Impact impulses and friction cone
nlp.addConstraint(0, Fe1(2), 15); % Positive vertical force must be positive

% Swing leg ground speed matching (to reduce impact)
% Retraction = -0.05*averageSpeed;
[g1, G1, ~] = sys.constraintEquation(x1.final, xdot1.final, 'ds');
nlp.addConstraint(-2, G1(4,:)*xdot1.final, 0);

[g1, G1, ~] = sys.constraintEquation(x1.initial, xdot1.initial, 'ds');

% Start stance foot starts at origin
nlp.addConstraint(lb0, g1(1), ub0);
nlp.addConstraint(lb0, g1(2), ub0);

nlp.addConstraint(lb0, G1(1,:)*xdot1.initial, ub0);
nlp.addConstraint(lb0, G1(2,:)*xdot1.initial, ub0);

% Non stance foot ground clearance
[g1, ~, ~] = sys.constraintEquation(x1.ind(10), xdot1.ind(10), 'ds');  % Get position of swing leg toe
nlp.addConstraint(0.1*1.5, g1(4), 0.3*1.5); % good for [h0 h1]=[0.2 0.2];[-0.2 -0.2]
% nlp.addConstraint(0.1, g1(4), 0.6); % good for [h0 h1]=[0.2 -0.2];[-0.2 0.2]

[g1, ~, ~] = sys.constraintEquation(x1.ind(5), xdot1.ind(5), 'ds');  % Get position of swing leg toe
nlp.addConstraint(0, g1(4), 0.2); % good for [h0 h1]=[0.2 0.2];[-0.2 -0.2];[-0.2 0.2]

[g1, ~, ~] = sys.constraintEquation(x1.ind(6), xdot1.ind(6), 'ds');  % Get position of swing leg toe
nlp.addConstraint(0.05, g1(4), 0.2); % good for [h0 h1]=[0.2 0.2];[-0.2 -0.2];[-0.2 0.2]

[g1, ~, ~] = sys.constraintEquation(x1.ind(7), xdot1.ind(7), 'ds');  % Get position of swing leg toe
nlp.addConstraint(0.1, g1(4), 0.4); % good for [h0 h1]=[0.2 0.2];[-0.2 -0.2];[-0.2 0.2]

[g1, ~, ~] = sys.constraintEquation(x1.ind(13), xdot1.ind(13), 'ds');  % Get position of swing leg toe
% nlp.addConstraint(0, g1(4), 0.3); % good for [h0 h1]=[0.2 0.2];[-0.2 -0.2];[-0.2 0.2]
nlp.addConstraint(0.3, g1(4), 0.6); % good for [h0 h1]=[0.2 0.2];[-0.2 -0.2];[-0.2 0.2]


% Stance foot force (non-negative)
nlp.addConstraint(200, F1(2), 650); % Positive vertical force
% Reformulate absolute value constraint as two linear inequalities
nlp.addConstraint(0, kf*F1(2) - F1(1), Inf); % Friction cone (fk = 1)
nlp.addConstraint(0, kf*F1(2) + F1(1), Inf); % Friction cone (fk = 1)

