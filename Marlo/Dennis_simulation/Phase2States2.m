x1 = nlp.phase(1).state(1:7); % States positions
xdot1 = nlp.phase(1).state(8:14); % States velocities
u1 = nlp.phase(1).input; % Control inputs
t1 = nlp.phase(1).duration; % Phase duration
F1 = nlp.phase(1).lambda; % External forces (Fx, Fz)

x2 = nlp.phase(2).state(1:7); % States positions
xdot2 = nlp.phase(2).state(8:14); % States velocities
u2 = nlp.phase(2).input; % Control inputs
t2 = nlp.phase(2).duration; % Phase duration
F2 = nlp.phase(2).lambda; % External forces (Fx, Fz)

% x3 = nlp.phase(3).state(1:7); % States positions
% xdot3 = nlp.phase(3).state(8:14); % States velocities
% u3 = nlp.phase(3).input; % Control inputs
% t3 = nlp.phase(3).duration; % Phase duration
% F3 = nlp.phase(3).lambda; % External forces (Fx, Fz)
% 
% x4 = nlp.phase(4).state(1:7); % States positions
% xdot4 = nlp.phase(4).state(8:14); % States velocities
% u4 = nlp.phase(4).input; % Control inputs
% t4 = nlp.phase(4).duration; % Phase duration
% F4 = nlp.phase(4).lambda; % External forces (Fx, Fz)
% 
% x5 = nlp.phase(5).state(1:7); % States positions
% xdot5 = nlp.phase(5).state(8:14); % States velocities
% u5 = nlp.phase(5).input; % Control inputs
% t5 = nlp.phase(5).duration; % Phase duration
% F5 = nlp.phase(5).lambda; % External forces (Fx, Fz)

% Set bounds
t1.lowerBound = 0.2;
t1.upperBound = 0.6;
t2.lowerBound = 0.2;
t2.upperBound = 0.6;
% nlp.addConstraint(0,t2-t1,0);
% t3.lowerBound = 0.3;
% t3.upperBound = 1;
% t4.lowerBound = 0.3;
% t4.upperBound = 1;
% t5.lowerBound = 0.3;
% t5.upperBound = 1;

% Add perturbation constraint
h_up = 100e-3; % stairs height;
h_down = -100e-3; % stairs height;
% h = 0; % stairs height;

[g1_final, ~, ~] = sys.constraintEquation(x1.final, xdot1.final, 'ds');
nlp.addConstraint(0,g1_final(4),0);
nlp.addConstraint(0,g1_final(3),0);   % step length

step_length = 0.2;
[g2_final, ~, ~] = sys.constraintEquation(x2.final, xdot2.final, 'ds');
nlp.addConstraint(0,g2_final(4),0);
nlp.addConstraint(step_length,g2_final(3),step_length+0.4);   % step_length
nlp.addConstraint(0,g2_final(1),0);
nlp.addConstraint(0,g2_final(2),0);   % step_length
% [g2_initial, ~, ~] = sys.constraintEquation(x2.initial, xdot2.initial, 'ds');
% nlp.addConstraint(0,g2_initial(4),0);
% nlp.addConstraint(-step_length,g2_initial(3),-step_length);   % step length
% [g3, ~, ~] = sys.constraintEquation(x3.final, xdot3.final, 'ds');
% nlp.addConstraint(0,h_up-g3(4),0);
% [g4, ~, ~] = sys.constraintEquation(x4.final, xdot4.final, 'ds');
% nlp.addConstraint(0,h_down-g4(4),0);
% [g5, ~, ~] = sys.constraintEquation(x5.final, xdot5.final, 'ds');
% nlp.addConstraint(0,h_down-g5(4),0);

% Add minimum displacement
d1 = nlp.addVariable(0, -Inf, Inf); % Slack variable for distance
nlp.addConstraint(0, d1 - (x1(1).final - x1(1).initial), 0); % Constraint distance to be travel of hip during one step
d2 = nlp.addVariable(0, -Inf, Inf); % Slack variable for distance
nlp.addConstraint(0, d2 - (x2(1).final - x2(1).initial), 0); % Constraint distance to be travel of hip during one step
% d3 = nlp.addVariable(0.1, 0.1, Inf); % Slack variable for distance
% nlp.addConstraint(0, d3 - (x3(1).final - x3(1).initial), 0); % Constraint distance to be travel of hip during one step
% d4 = nlp.addVariable(0.1, 0.1, Inf); % Slack variable for distance
% nlp.addConstraint(0, d4 - (x4(1).final - x4(1).initial), 0); % Constraint distance to be travel of hip during one step
% d5 = nlp.addVariable(0.1, 0.1, Inf); % Slack variable for distance
% nlp.addConstraint(0, d5 - (x5(1).final - x5(1).initial), 0); % Constraint distance to be travel of hip during one step

% Add Average Speed constraint
% nlp.addConstraint(0.1, d1/t1, 0.5); % Constraint average speed m/s


