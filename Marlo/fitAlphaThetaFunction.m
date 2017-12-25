clc; close all; clear all;

coorSet = {'_LK_','_Cart_','_Full_'};
coor = coorSet{1};  % choose coordinate

switch coor
	case {'_LK_', '_Cart_'}
		m_num = 4;
	otherwise
		m_num = 5;
end

BezierOrder = 6;
AlphaSet = zeros(m_num,BezierOrder,1, 1,1,1);
thetaAlpha = zeros(1,BezierOrder,1, 1,1,1);

i = 1;
j = 1;
k=1;
l=1;

% -- Params Panel --
% height0=0;
% height1=0;
% height2=0;
% 
% stepLength0=0.5;
% stepLength1=0.5;
% stepLength2=0.5;
date='28-Oct-2016';
for stepLength0=[0.4,0.7]
    for stepLength1=[0.4,0.7]
        for height0 = [-0.25,0.25]
            for height1 = [-0.25,0.25]
       
vers = ['_day_l0_',num2str(stepLength0*100),'_l1_',num2str(stepLength1*100),'_h0_',num2str(height0*100),'_h1_',num2str(height1*100),'_periodic'];

Data = ['Data2Step_',date,vers]; 	% check the date carefully!
load(Data)
		
		%%
		T1 = linspace(0,t1,length(x1));
		
		Ttheta = [0 0 1 1/2 1/2 0 0];
		H = [0 0 0 1/2 1/2 0 0; 0 0 0 0 0 1/2 1/2; 0 0 0 -1 1 0 0; 0 0 0 0 0 -1 1];
		H_full = [0 0 1 0 0 0 0; 0 0 0 1 0 0 0; 0 0 0 0 1 0 0; 0 0 0 0 0 1 0; 0 0 0 0 0 0 1];
		s = linspace(0,1,length(x1));
		ds = (s(2) - s(1))/(T1(2) - T1(1));
		T = 1/ds;
		options = optimset('Display','off','MaxIter',1e6,'MaxFunEvals',1e6,'TolX',1e-8,'TolFun',1e-8);
		
		alpha_p = zeros(4,BezierOrder);
		for n = 1:length(x1)
			% n = length(x1);
			switch coor
				case '_LK_'
					q_act(:,n) = H*x1(n,:)';
					dq_act(:,n) = H*xdot1(n,:)';
				case '_Cart_'
					[q_act(:,n), dq_act(:,n), ~] = outputCoordinate(x1(n,:)',xdot1(n,:)');
				case '_Full_'
					q_act(:,n) = H_full*x1(n,:)';
					dq_act(:,n) = H_full*xdot1(n,:)';
			end
			theta(:,n) = Ttheta*x1(n,:)';
			dtheta(:,n) = Ttheta*xdot1(n,:)';
			
		end
		
		s_theta = (theta - theta(1))/(theta(end) - theta(1));
		ds_theta = (dtheta)/(theta(end) - theta(1));
		
		thetaAlpha(:,:,i,j,k,l) = fminsearch(@fcost,zeros(1,BezierOrder), options, s, ds, theta, dtheta,BezierOrder);
		sAlpha(:,:,i,j,k,l) = fminsearch(@fcost,zeros(1,BezierOrder), options, s_theta, ds_theta, s, ds,BezierOrder);
		
		for m = 1:m_num
			alpha_p(m,:) = fminsearch(@fcost,zeros(1,BezierOrder), options, s, ds, q_act(m,:), dq_act(m,:),BezierOrder);
		end
		
		for m = 1:4
			alpha_star(m,:) = fminsearch(@fcost,zeros(1,BezierOrder), options, s, ds, u1(:,m)', u1(:,m)',BezierOrder,0);
		end
		Alpha_vhip(:,:,i,j,k,l) = fminsearch(@fcost,zeros(1,BezierOrder), options, s, ds, xdot1(:,1)', xdot1(:,1)',BezierOrder,0);
		
		AlphaSet(:,:,i,j,k,l) = alpha_p;
		AlphaStar(:,:,i,j,k,l) = alpha_star;
		
		%%
		hd = bezierval(alpha_p,s);
		dhd = bezierval(diff(alpha_p,[],2),s)*(BezierOrder-1)*ds;
		hd_theta = bezierval(thetaAlpha(:,:,i,j,k,l),s);
		s_T = bezierval(sAlpha(:,:,i,j,k,l),s_theta);
		u_star = bezierval(alpha_star,s);
		vHip = bezierval(Alpha_vhip(:,:,i,j,k,l),s);
		
		figure(101)
		plot(T1, q_act); hold on
		plot(T1, hd,'--','LineWidth',2); hold off
		title('Position')
		
		figure(102)
		plot(T1, dq_act); hold on
		plot(T1, dhd,'--','LineWidth',2); hold off
		title('Velocity')
		
		figure(103)
		plot(T1, theta); hold on
		plot(T1, hd_theta,'--','LineWidth',2); hold off
		title('theta')
		
		figure(104)
		plot(s_theta, s); hold on
		plot(s_theta, s_T,'--','LineWidth',2); hold off
		title('s_theta')
		
		figure(105)
		plot(T1, u1'); hold on
		plot(T1, u_star,'--','LineWidth',2); hold off
		title('u')
		
		figure(106)
		plot(T1, xdot1(:,1)); hold on
		plot(T1, vHip,'--','LineWidth',2); hold off
		title('hip velocity')
		
		drawnow()
        
            i = i+1;
            end % for loop n
            i = 1;
            j = j+1;
        end % for loop m
        i=1; j=1; k=k+1;
    end
    i=1;j=1;k=1;l=l+1;
end
%%
% dataName = ['NormalData',coor,date];
% save(['E:\MATLAB Simulation\MARLO\Gait_Optimization\twoStepHeightOpt\DataFiles\',dataName],'AlphaSet','thetaAlpha','sAlpha','AlphaStar','Alpha_vhip','T')
base_path = fileparts(fileparts(fileparts(mfilename('fullpath'))));
% dataName = ['NormalData',coor,date,'_l2_',num2str(stepLength2*100)];
dataName = ['Gait_Library_',date,'_2StepsLengthHeightPeriodic'];
save([base_path,'\DDAcontroller\DataFiles\',dataName],'AlphaSet','thetaAlpha','sAlpha','AlphaStar','Alpha_vhip','T')
