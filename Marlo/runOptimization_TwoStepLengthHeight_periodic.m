
% RUNWALK Runs the walking optimization on ATRIAS system.
%
% Copyright 2013-2014 Mikhail S. Jones

% Clean up the workspace
clc; close all; clear all;

% -- Params Panel --
height0=-0.25;
height1=0.25;
height2=height0;

stepLength0=0.4;
stepLength1=0.7;
stepLength2=stepLength0;

height0 = round(height0*100)/100;
height1 = round(height1*100)/100;
height2 = round(height2*100)/100;
stepLength0 = round(stepLength0*100)/100;
stepLength1 = round(stepLength1*100)/100;
stepLength2 = round(stepLength2*100)/100;

% init_step =  load(['DataOneStep_12-Sep-2016','_day_l0',num2str(stepLength*100),'h0',num2str(height1*100)]);
% final_step =  load(['DataOneStep_12-Sep-2016','_day_l0',num2str(stepLength*100),'h0',num2str(height2*100)]);
% init_step = load('DataOneStep_21-Sep-2016_day_l040h00');
lb0 = -1e-8;
ub0 =  1e-8;

tic

% Construct system model
sys = AtriasSystem;

% Friction coefficient (ground)
kf = 0.4;

% Relabeling matrix
R = [	1 0 0 0 0 0 0;
        0 1 0 0 0 0 0;
        0 0 1 0 0 0 0;
        0 0 0 0 0 1 0;
        0 0 0 0 0 0 1;
        0 0 0 1 0 0 0;
        0 0 0 0 1 0 0;];

nNodes = 20;

% Construct trajectory optimization phase object
[nlp] = sys.directCollocation_diffNodes(nNodes, ... % Number of nodes
	'method', 'trapezoidal', ... % Integration method (implicit euler, explicit euler, trapezoidal (default))
	'modeSchedule', {'ss','ss'},'periodic', true);

if 1
    % Decompose phase into states, inputs and duration
    [nlp, x1, xdot1, u1, t1, F1, g1_final, dxe1, Fe1] = Phase2States4(...
    nlp, sys, height1, lb0, ub0, kf, 1,stepLength1);

    % Decompose phase into states, inputs and duration
    [nlp, x2, xdot2, u2, t2, F2, g2_final, dxe2, Fe2] = Phase2States4_step2(...
    nlp, sys, height2, lb0, ub0, kf, 2, stepLength2);
else
    % Decompose phase into states, inputs and duration
    [nlp, x1, xdot1, u1, t1, F1, g1_final, dxe1, Fe1] = Phase2States4(...
    nlp, sys, height1, lb0, ub0, kf, 1,stepLength1);

    % Decompose phase into states, inputs and duration
    [nlp, x2, xdot2, u2, t2, F2, g2_final, dxe2, Fe2] = Phase2States4(...
    nlp, sys, height2, lb0, ub0, kf, 2, stepLength2);
end
% Set bounds
t1.lowerBound = 0.6;%0.8;%0.2;%0.35+lb0;
t1.upperBound = 2;%1.0;%0.35+ub0;
% Set bounds
t2.lowerBound = 0.6;%0.8;%0.2;%0.35+lb0;
t2.upperBound = 2;%1.0;%0.35+ub0;


% Set initial solution
NLPsol1 = load(['InitialDataOneStep_21-Sep-2016_day_l0',num2str(stepLength1*100),'h00']);   
% NLPsol1 = load('InitialData2Step_24-Oct-2016_day_ls_50_h0_25_h1_25_periodic');
% 		nlp.initialGuess = [NLPsol1.NLPsolution NLPsol1.NLPsolution];
% nlp.initialGuess = NLPsolution;
InitialGuess4 %(if no initial mat)

% Add connected constraint, phase 1 to 1
% % p01 = init_step.x1(1,:)' - x1.initial;
% % nlp.addConstraint(lb0, p01(3:7), ub0); % Match everything except x position

% initial condition for step 1
[g1_initial, ~, ~] = sys.constraintEquation(x1.initial, xdot1.initial, 'ds');
% % nlp.addConstraint(lb0+height0,g1_initial(4),ub0+height0);
% % nlp.addConstraint(lb0+stepLength0,g1_initial(1)-g1_initial(3),ub0+stepLength0); % final step length

%Phase 1 - 2 transition:
p21 = R*x1.final - x2.initial;
nlp.addConstraint(lb0, p21(3:7), ub0); % Match everything except x position
nlp.addConstraint(lb0, R*dxe1 - xdot2.initial, ub0); % Match velocities with impact

%periodicity constriant:
if 1
p21 = R*x2.final - x1.initial;
nlp.addConstraint(lb0, p21(3:7), ub0); % Match everything except x position
nlp.addConstraint(lb0, R*dxe2 - xdot1.initial, ub0); % Match velocities with impact
end

% Add Objective
nlp.clearObjective.addObjective(trapz(u1'*u1, t1) + trapz(u2'*u2, t2));

% Construct optimizer interface object, export and solve
optim = Ipopt(nlp);
optim.export;
ConstrucTime = toc;

tic;
optim.solve;

% Construct time response object
response = nlp.getResponse;

% Plot time response
response.plot;

% Construct and play animation
% Construct and play animation
interval = 0.01;
Length = -10:interval:100;
Height = zeros(1,length(Length));
shape = 'linear';
scene = AtriasScene(sys, response);
Player(scene, Length, Height, shape);

IterTime = toc;

disp(['Construct Time = ',num2str(ConstrucTime)])
disp(['Iter Timer = ',num2str(IterTime)])
disp(['Average Speed 1 = ',num2str(eval((stepLength1)/(t1)))])
disp(['Average Speed 2 = ',num2str(eval((stepLength2)/(t2)))])
disp(['Step Length 0 = ', num2str(-eval(g1_initial(3)-g1_initial(1)))])
disp(['Step Length 1 = ', num2str(eval(g1_final(3)-g1_final(1)))])
disp(['Step Length 2 = ', num2str(eval(g2_final(3)-g2_final(1)))])
disp(['Step Height 0 = ', num2str(-eval(g1_initial(4)-g1_initial(2)))])
disp(['Step Height 1 = ', num2str(eval(g1_final(4)-g1_final(2)))])
disp(['Step Height 2 = ', num2str(eval(g2_final(4)-g2_final(2)))])
disp(['Time Step 1= ', num2str(eval(t1))])
disp(['Time Step 2= ', num2str(eval(t2))])
disp(['Impact Step 1= ', num2str(eval(Fe1(2)))])
disp(['Impact Step 2= ', num2str(eval(Fe2(2)))])
%% Save alpha data
vers = ['_day_l0_',num2str(stepLength0*100),'_l1_',num2str(stepLength1*100),'_h0_',num2str(height0*100),'_h1_',num2str(height1*100),'_periodic'];
SaveData = 1;
if SaveData
    % Save solution
    NLPsolution = nlp.solution;
    date='28-Oct-2016';
    InitialData2Step = ['InitialData2Step_',date,vers];
    base_path = fileparts(fileparts(fileparts(mfilename('fullpath'))));
    save([base_path,'\DDAcontroller\DataFiles\',InitialData2Step],'NLPsolution');
    save([base_path,'\DDAcontroller\DataFiles\',['Response',date,vers]],'response');

    %  Save for trajectory fitting
    Data2Step = ['Data2Step_',date,vers];
    filename = [base_path,'\DDAcontroller\DataFiles\',Data2Step];
    saveData2Steps(x1,xdot1,t1,u1,...
		x2,xdot2,t2,u2,filename);
end
