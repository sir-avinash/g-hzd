
% Impact impulses and friction cone
nlp.addConstraint(0, Fe1(2), 50); % Positive vertical force must be positive
% nlp.addConstraint(0, Fe2(2), 50); % Positive vertical force must be positive
% nlp.addConstraint(0, Fe3(2), 50); % Positive vertical force must be positive
% nlp.addConstraint(0, Fe4(2), 50); % Positive vertical force must be positive
% nlp.addConstraint(0, Fe5(2), 50); % Positive vertical force must be positive

% Reformulate absolute value constraint as two linear inequalities
nlp.addConstraint(0, kf*Fe1(2) - Fe1(1), Inf); % Friction cone (fk = 1)
nlp.addConstraint(0, kf*Fe1(2) + Fe1(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*Fe2(2) - Fe2(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*Fe2(2) + Fe2(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*Fe3(2) - Fe3(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*Fe3(2) + Fe3(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*Fe4(2) - Fe4(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*Fe4(2) + Fe4(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*Fe5(2) - Fe5(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*Fe5(2) + Fe5(1), Inf); % Friction cone (fk = 1)

% Swing leg ground speed matching (to reduce impact)
Retraction = 0;
[~, G1, ~] = sys.constraintEquation(x1.final, xdot1.final, 'ds');
nlp.addConstraint(-2, G1(3,:)*xdot1.final, 2);
% [~, G2, ~] = sys.constraintEquation(x2.final, xdot2.final, 'ds');
% nlp.addConstraint(-2, G2(3,:)*xdot2.final, 2);
% [~, G3, ~] = sys.constraintEquation(x3.final, xdot3.final, 'ds');
% nlp.addConstraint(-Inf, G3(3,:)*xdot3.final, Retraction);
% [~, G4, ~] = sys.constraintEquation(x4.final, xdot4.final, 'ds');
% nlp.addConstraint(-Inf, G4(3,:)*xdot4.final, Retraction);
% [~, G5, ~] = sys.constraintEquation(x5.final, xdot5.final, 'ds');
% nlp.addConstraint(-Inf, G5(3,:)*xdot5.final, Retraction);

% Impact velocities (TO toe must have positive velocity)
% [~, G1, ~] = sys.constraintEquation(x1.initial, xdot1.initial, 'ds');
% nlp.addConstraint(0, G1(4,:)*xdot1.initial, Inf);
[g1, G1, ~] = sys.constraintEquation(x1.initial, xdot1.initial, 'ds');
[g2, G2, ~] = sys.constraintEquation(x2.initial, xdot2.initial, 'ds');
% [g3, G3, ~] = sys.constraintEquation(x3.initial, xdot3.initial, 'ds');
% nlp.addConstraint(0, G3(4,:)*xdot3.initial, Inf);
% % [g4, G4, ~] = sys.constraintEquation(x4.initial, xdot4.initial, 'ds');
% % nlp.addConstraint(0, G4(4,:)*xdot4.initial, Inf);
% [g5, G5, ~] = sys.constraintEquation(x5.initial, xdot5.initial, 'ds');
% nlp.addConstraint(0, G5(4,:)*xdot5.initial, Inf);

% Start stance foot starts at origin
nlp.addConstraint(-1e-6, g1(1), -1e-6);
nlp.addConstraint(-1e-6, g1(2), -1e-6);
% nlp.addConstraint(-1e-4, g2(1), 1e-4);
nlp.addConstraint(-1e-6, g2(2), 1e-6);
nlp.addConstraint(-1e-6, G1(1,:)*xdot1.initial, 1e-6);
nlp.addConstraint(-1e-6, G1(2,:)*xdot1.initial, 1e-6);
nlp.addConstraint(-1e-6, G2(1,:)*xdot2.initial, 1e-6);
nlp.addConstraint(-1e-6, G2(2,:)*xdot2.initial, 1e-6);
nlp.addConstraint(-1e-6, G2(4,:)*xdot2.initial, Inf);

% Non stance foot ground clearance
% toeProfile = 0.12*sin(pi*(0:nlp.nNodes - 1)/(nlp.nNodes - 1)); % Creates a half sine profile the toe must clear during swing
toeProfile = 0.12;
[g, ~, ~] = sys.constraintEquation(x1.initial, xdot1.initial, 'ds');  % Get position of swing leg toe
nlp.addConstraint(toeProfile, g(4), 0.2); % Apply ground clearance constraint
% [g, ~, ~] = sys.constraintEquation(x2, xdot2, 'ds');  % Get position of swing leg toe
% nlp.addConstraint(toeProfile, g(4), 0.2); % Apply ground clearance constraint

% Stance foot force (non-negative)
nlp.addConstraint(0, F1(2), 1500); % Positive vertical force
% Reformulate absolute value constraint as two linear inequalities
nlp.addConstraint(0, kf*F1(2) - F1(1), Inf); % Friction cone (fk = 1)
nlp.addConstraint(0, kf*F1(2) + F1(1), Inf); % Friction cone (fk = 1)

% Stance foot force (non-negative)
nlp.addConstraint(0, F2(2), 1500); % Positive vertical force
% Reformulate absolute value constraint as two linear inequalities
nlp.addConstraint(0, kf*F2(2) - F2(1), Inf); % Friction cone (fk = 1)
nlp.addConstraint(0, kf*F2(2) + F2(1), Inf); % Friction cone (fk = 1)
% % 
% % % Stance foot force (non-negative)
% nlp.addConstraint(0, F3(2), Inf); % Positive vertical force
% % Reformulate absolute value constraint as two linear inequalities
% nlp.addConstraint(0, kf*F3(2) - F3(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*F3(2) + F3(1), Inf); % Friction cone (fk = 1)
% 
% % % Stance foot force (non-negative)
% nlp.addConstraint(0, F4(2), Inf); % Positive vertical force
% % % Reformulate absolute value constraint as two linear inequalities
% nlp.addConstraint(0, kf*F4(2) - F4(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*F4(2) + F4(1), Inf); % Friction cone (fk = 1)
% % 
% % % Stance foot force (non-negative)
% nlp.addConstraint(0, F5(2), Inf); % Positive vertical force
% % Reformulate absolute value constraint as two linear inequalities
% nlp.addConstraint(0, kf*F5(2) - F5(1), Inf); % Friction cone (fk = 1)
% nlp.addConstraint(0, kf*F5(2) + F5(1), Inf); % Friction cone (fk = 1)
