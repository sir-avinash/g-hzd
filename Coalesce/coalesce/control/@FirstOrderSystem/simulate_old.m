function [response,xMinus,y,dy,data,ls_last] = simulate(obj, tSpan, x0, controller, varargin)
%SIMULATE Simulate the hybrid first order input-output system.
%
% Required Input Arguments:
%		tSpan - (DOUBLE) Time span to simulate over
%		x0 - (DOUBLE) Initial state vector
%
% Optional Input Arguments:
%		InitialMode - (CHAR) Name of the initial dynamic mode
%		MaxModes - (DOUBLE) Maximum number of mode switches
%		Controller - (FUNCTION_HANDLE) Controller function
%
% Copyright 2014 Mikhail S. Jones

	% Number of states, inputs and modes in schedule
	nx = numel(obj.states);
	nu = numel(obj.inputs);

	% Parse input arguments
	parser = inputParser;
	parser.addRequired('timeSpan', ...
		@(x) validateattributes(x, ...
			{'double'}, {'vector'}));
	parser.addRequired('initialState', ...
		@(x) validateattributes(x, {'double'}, {'numel', nx}));
	parser.addOptional('initialMode', obj.modes{1}, ...
		@(x) ischar(validatestring(x, obj.modes)));
	parser.addOptional('maxModes', inf, ...
		@(x) validateattributes(x, {'double'}, {'scalar', 'positive'}));
	parser.addOptional('controller', @(t,x,stepHeight) 0, ...
		@(x) validateattributes(x, {'function_handle'}, {}));
	parser.addOptional('solver', 'ode45', ...
		@(x) ischar(validatestring(x, ...
			{'ode45', 'ode23', 'ode113', 'ode15s', 'ode23s', 'ode23t', 'ode23tb'})));
    parser.addOptional('stepHeight', zeros(1,100),...
		@(x) validateattributes(x, {'double'}, {'vector'}));
    parser.addOptional('stepLength', zeros(1,100),...
		@(x) validateattributes(x, {'double'}, {'vector'}));
    parser.addOptional('shape', 'linear', ...
		@(x) ischar(validatestring(x, {'linear','nearest'})));
    parser.addOptional('CheckEvent', false,...
		@(x) validateattributes(x, {'logical'}, {'scalar'}));
    
    
	parser.parse(tSpan, x0, varargin{:});
	opts = parser.Results;

	% Convert solver string to function handle
	opts.solver = str2func(opts.solver);

	% Initialize time, mode and counter
	t0 = tSpan(1); m0 = opts.initialMode; im = 0; ti = 0; im_stepPosition = zeros(2,1);

	% Wrap controller to respect control input bounds
% 	opts.controller = @(t,x,Nstep) min(max(reshape(opts.controller(t,x,Nstep), 1, []), obj.inputLowerBounds), obj.inputUpperBounds);
    
	% Simulate system
	while im < opts.maxModes
		% Advance counter
		im = im + 1;
        disp(['Step No: ' num2str(im)]);
%         stepHeight = opts.stepHeight(im);

		% Define state equation function
		ode = @(t, x) obj.stateEquation(t, x, min(max(opts.controller(t, x, im),-10),10), m0, im);

		% Define ODE options and event functions
        
    		options = odeset(...
    			'Events', @(t, x) events(t, x(1:nx/2), x(nx/2+1:end), m0),...
                'RelTol',1e-3,...
                'AbsTol',1e-3,...
                'NormControl','on',...
                'MaxStep',1e-1);
%             options = odeset(...
%                 'Events', @(t, x) events(t, x(1:nx/2), x(nx/2+1:end), m0 ,stepHeight));

		% Run ODE solver
        if opts.CheckEvent
            [t{im}, x{im}, te, xe, ie] = opts.solver(ode, [t0 tSpan(end)], x0(:), options);
			if ~isempty(ie)
				[~, ~, ~,stepPosition] = events(te, xe(1:nx/2)', xe(nx/2+1:end)', m0);
			else
				stepPosition = zeros(1,2);
			end
        else
            [t{im}, x{im}] = opts.solver(ode, [t0 tSpan(end)], x0(:),[]);
            ie = [];
			stepPosition = zeros(1,2);
        end
        t{im} = t{im} + ti;
% 		[t{im}, x{im}] = opts.solver(ode, [t0 tSpan(end)], x0(:));
		m{im} = m0;

		% Check if an event was triggered
		if ~isempty(ie)
			% Determine correct jump map to use
			[~, ~, modes, jumpFcn] = obj.guardSet(t{im}(end), x{im}(end,1:nx/2)', x{im}(end,nx/2+1:end)', m0);
			% Evaluate jump map to determine new state
% 			x0 = jumpFcn{ie}(x{im}(end,:)');
            x0 = jumpFcn{ie};
			m0 = modes{ie};
		end  % if
            xMinus = x{im}(end,:)';
		

%         if im == 1
%             optionsf = optimset('Display','iter','TolX',1e-4,'TolFun',1e-4);
%             opts.optimzation = str2func('fminsearch');
%             x0period = opts.optimzation(@cost,p0,optionsf);
%             x0 = x0period;
%         else
%             x0 = jumpFcn{ie};
%         end
%         
%         m0 = modes{ie};

		% Set new initial time


		% Loop through time vector backwards to preallocate
% 		for it = numel(t{im}):-1:1
% 			% Compute control inputs
% 			u{im}(it,:) = opts.controller(t{im}(it), x{im}(it,:)');
% 		end % for
        
		for it = 1:numel(t{im})
			% Compute control inputs
			[u{im}(it,:),y{im}(it,:),dy{im}(it,:),data{im}(it,:),ls_last{im}] = opts.controller(t{im}(it)-ti, x{im}(it,:)',im, im_stepPosition);
		end % for
        %% check violation on friction and step length (Quan Jul/11/2016)
        lf = data{im}(end,6);
                
        ld=data{im}(end,15);
        lmin=ld-controller.stone_size;
        lmax=ld+controller.stone_size;
        delta_l=1e-3;
        global sim_test
        % check if violate step length
            if (lmin-lf)>delta_l 
                disp(['Violate l_min on step ' num2str(im) '!!!'])
%                 violation_counter=violation_counter+1;
                sim_test.fail=1;
%                 break
            end
            if (lf-lmax)>delta_l
                disp(['Violate l_max on step ' num2str(im) '!!!'])
%                 violation_counter=violation_counter+1;
                sim_test.fail=2;
%                 break
            end
            
        acm=data{im}(:,13:14);
        acm(:,2)=acm(:,2)+9.81;
        kf=acm(:,1)./acm(:,2);
        kf=abs(kf);
        for i = 1:numel(t{im})
            if kf(i)>(controller.friction_kf+delta_l)
                disp(['Friction Violation (|F/N|>kf) on step' num2str(im) '!!!'])
                sim_test.fail=3;
%                 break
%                 violation_counter=violation_counter+1;
            end
            
            if acm(i,2)<delta_l%(controller.friction_delta_a+delta_l)
                disp(['Friction Violation (N < 0) on step' num2str(im) '!!!'])
                sim_test.fail=4;
                break
%                 violation_counter=violation_counter+1;
            end


        end
        
        if controller.break_sim==1
            if sim_test.fail ~= 0
                break
            end
        end
        %%
        ti = t{im}(end);
        t0 = 0;
        im_stepPosition = stepPosition;

        
	end % while

	% Construct time response object
	response = Response(t, x, u, m, obj.states, obj.inputs);

	function [value, isTerminal, direction, stepPosition] = events(t, x, xdot, m)
	%EVENTS Guard set wrapper for ODE events function.
	
		[footPlace, direction] = obj.guardSet(t, x, xdot, m);
        foot_x = footPlace(1);
        value = footPlace(2);
        stepPosition(1) = foot_x;
        stepPosition(2) = interp1(opts.stepLength,opts.stepHeight,foot_x,opts.shape);
        if t>0.1
            value = value - stepPosition(2); % terrain disturbance
        else
            value = 1;
        end
		isTerminal = true;
	end % events

%     function J = cost(x0)
%     % COST fminsearch to find periodic orbit
%     
%     
%     [t{im}, x{im}, ~, ~, ie] = opts.solver(ode, [t0 tSpan(end)], x0(:), options);
%     [~, ~, modes, jumpFcn] = obj.guardSet(t{im}(end), x{im}(end,1:nx/2)', x{im}(end,nx/2+1:end)', m0);
%     x0new = jumpFcn{ie};
%     J = norm(x0new(4:end) - x0(4:end));
%     
%     end
end % simulate
