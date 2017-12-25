lExtLim = deg2rad(12.5);
lFleLim = deg2rad(150);
lAMin = deg2rad(60);
lAMax = deg2rad(300);
lBMin = deg2rad(60);
lBMax = deg2rad(300);

% Joint angles
nlp.addConstraint(lExtLim, x1(5) - x1(4), lFleLim);
nlp.addConstraint(lExtLim, x1(5) - x1(4), lFleLim); % Right leg length limits
nlp.addConstraint(lAMin, x1(4), lAMax); % Left leg motor A limits
nlp.addConstraint(lBMin, x1(5), lBMax); % Left leg motor B limits
nlp.addConstraint(lExtLim, x1(7) - x1(6), lFleLim); % Left leg length limits
nlp.addConstraint(lAMin, x1(6), lAMax);
nlp.addConstraint(lBMin, x1(7), lBMax);

nlp.addConstraint(lExtLim, x2(5) - x2(4), lFleLim);
nlp.addConstraint(lExtLim, x2(5) - x2(4), lFleLim); % Right leg length limits
nlp.addConstraint(lAMin, x2(4), lAMax); % Left leg motor A limits
nlp.addConstraint(lBMin, x2(5), lBMax); % Left leg motor B limits
nlp.addConstraint(lExtLim, x2(7) - x2(6), lFleLim); % Left leg length limits
nlp.addConstraint(lAMin, x2(6), lAMax);
nlp.addConstraint(lBMin, x2(7), lBMax);
% 
nlp.addConstraint(lExtLim, x3(5) - x3(4), lFleLim);
nlp.addConstraint(lExtLim, x3(5) - x3(4), lFleLim); % Right leg length limits
nlp.addConstraint(lAMin, x3(4), lAMax); % Left leg motor A limits
nlp.addConstraint(lBMin, x3(5), lBMax); % Left leg motor B limits
nlp.addConstraint(lExtLim, x3(7) - x3(6), lFleLim); % Left leg length limits
nlp.addConstraint(lAMin, x3(6), lAMax);
nlp.addConstraint(lBMin, x3(7), lBMax);

nlp.addConstraint(lExtLim, x4(5) - x4(4), lFleLim);
nlp.addConstraint(lExtLim, x4(5) - x4(4), lFleLim); % Right leg length limits
nlp.addConstraint(lAMin, x4(4), lAMax); % Left leg motor A limits
nlp.addConstraint(lBMin, x4(5), lBMax); % Left leg motor B limits
nlp.addConstraint(lExtLim, x4(7) - x4(6), lFleLim); % Left leg length limits
nlp.addConstraint(lAMin, x4(6), lAMax);
nlp.addConstraint(lBMin, x4(7), lBMax);
% 
nlp.addConstraint(lExtLim, x5(5) - x5(4), lFleLim);
nlp.addConstraint(lExtLim, x5(5) - x5(4), lFleLim); % Right leg length limits
nlp.addConstraint(lAMin, x5(4), lAMax); % Left leg motor A limits
nlp.addConstraint(lBMin, x5(5), lBMax); % Left leg motor B limits
nlp.addConstraint(lExtLim, x5(7) - x5(6), lFleLim); % Left leg length limits
nlp.addConstraint(lAMin, x5(6), lAMax);
nlp.addConstraint(lBMin, x5(7), lBMax);

% Motor velocities
nlp.addConstraint(-sys.DqmLim, xdot1(4), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot1(5), sys.DqmLim); % Left leg motor B limits
nlp.addConstraint(-sys.DqmLim, xdot1(6), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot1(7), sys.DqmLim); % Left leg motor B limits

nlp.addConstraint(-sys.DqmLim, xdot2(4), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot2(5), sys.DqmLim); % Left leg motor B limits
nlp.addConstraint(-sys.DqmLim, xdot2(6), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot2(7), sys.DqmLim); % Left leg motor B limits

nlp.addConstraint(-sys.DqmLim, xdot3(4), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot3(5), sys.DqmLim); % Left leg motor B limits
nlp.addConstraint(-sys.DqmLim, xdot3(6), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot3(7), sys.DqmLim); % Left leg motor B limits

nlp.addConstraint(-sys.DqmLim, xdot4(4), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot4(5), sys.DqmLim); % Left leg motor B limits
nlp.addConstraint(-sys.DqmLim, xdot4(6), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot4(7), sys.DqmLim); % Left leg motor B limits

nlp.addConstraint(-sys.DqmLim, xdot5(4), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot5(5), sys.DqmLim); % Left leg motor B limits
nlp.addConstraint(-sys.DqmLim, xdot5(6), sys.DqmLim); % Left leg motor A limits
nlp.addConstraint(-sys.DqmLim, xdot5(7), sys.DqmLim); % Left leg motor B limits
