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

x3 = nlp.phase(3).state(1:7); % States positions
xdot3 = nlp.phase(3).state(8:14); % States velocities
u3 = nlp.phase(3).input; % Control inputs
t3 = nlp.phase(3).duration; % Phase duration
F3 = nlp.phase(3).lambda; % External forces (Fx, Fz)

x4 = nlp.phase(4).state(1:7); % States positions
xdot4 = nlp.phase(4).state(8:14); % States velocities
u4 = nlp.phase(4).input; % Control inputs
t4 = nlp.phase(4).duration; % Phase duration
F4 = nlp.phase(4).lambda; % External forces (Fx, Fz)

x5 = nlp.phase(5).state(1:7); % States positions
xdot5 = nlp.phase(5).state(8:14); % States velocities
u5 = nlp.phase(5).input; % Control inputs
t5 = nlp.phase(5).duration; % Phase duration
F5 = nlp.phase(5).lambda; % External forces (Fx, Fz)

% Set bounds
t1.lowerBound = 0.3;
t1.upperBound = 1;
t2.lowerBound = 0.3;
t2.upperBound = 1;
t3.lowerBound = 0.3;
t3.upperBound = 1;
t4.lowerBound = 0.3;
t4.upperBound = 1;
t5.lowerBound = 0.3;
t5.upperBound = 1;