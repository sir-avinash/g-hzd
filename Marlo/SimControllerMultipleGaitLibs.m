classdef SimControllerMultipleGaitLibs < handle
	% PUBLIC PROPERTIES
	properties
		% Step Duration (s0
		%       t0_step@double = 0.467
		% Step Duration Gain
		t_gain@double = 0.05
		% Leg P Gain
		Kp@double = 50
		% Leg D Gain
		Kd@double = 20
		% Last step time
		t_last@double = 0
		% Last dx
		dx_last@double = 0.7
		
		N_1step@double = 0 % used for check impact
		
		vcm@double = zeros(2,1);
		slopeBelieve@double = 0;
		stepPosition_last@double = zeros(2,1);
		stepPosition@double = zeros(2,1);
        
        p4L_last@double = zeros(2,1); % last step swing y z position, global value
        p4_last@double = zeros(2,1); %

        l0_update@double = 0.4; 
        l1_update@double = 0.4; 
    end

	% PUBLIC METHODS
	methods
		
		% HZD controller
		function  [u,x,xdot,data,ls_last] = HZDfeedbackControl(obj,t,x,xdot,...
				hAlphaSet,thetaSet,Nstep,controller)            
            
			q = x;
			dq = xdot;
			
            [p4L,p4,~,~,~,~]= LagrangeModelAtriasConstraint2D(q,dq);
			[~,obj.vcm,J_cm,dJ_cm] =  VelAccelAtrias2D(q(3:end),dq(3:end));    
            
            if strcmp(controller.gait_library,'off')
                h0=0;h1=0;l0=0.5;l1=0.5;
            else
                h1=controller.CBF_hd(Nstep);
                l1=controller.CBF_ld(Nstep);
                if Nstep>1
                    h0=controller.CBF_hd(Nstep-1);
                    l0=controller.CBF_ld(Nstep-1);
                else
                    h0=-0.25; % need to change based on initial step
                    l0=0.4; % need to change based on initial step
                end
            end
            
            if obj.N_1step ~= Nstep
                obj.p4L_last = p4L;	% save swing foot position at impact
                obj.p4_last=p4;                
                obj.N_1step = Nstep;	% update step number
                ls_last=abs(obj.p4L_last(1)-obj.p4_last(1));
                % compute error of footstep placement
                e_fp=ls_last-obj.l1_update;
                % adjust new design step length based on 
                % foot step placement error of the previous step
                obj.l0_update=obj.l1_update;
                obj.l1_update=l1-e_fp;
            end
            ls_last=abs(obj.p4L_last(1)-obj.p4_last(1));
            
            if Nstep<=10
                l0Set=[0.4,0.6]; l1Set=[0.4,0.6];
                HAlpha = interpolateRoughGround(hAlphaSet{1},l1Set,obj.l1_update, l0Set, obj.l0_update);
                HAlpha_theta = interpolateRoughGround(thetaSet{1},l1Set,obj.l1_update, l0Set, obj.l0_update);
                
                kp = controller.Kp{1}; %80*20;
                kd = controller.Kd{1}; %20*5;
            else
                
                h1Set=[-0.25,0.25]; 
                h0Set=[-0.25,0.25];
                l0Set=[0.4,0.7];
                l1Set=[0.4,0.7];

                HAlpha = interpolateRoughGround4(hAlphaSet{2},h1Set,h1, h0Set, h0,l1Set,obj.l1_update, l0Set, obj.l0_update);
                HAlpha_theta = interpolateRoughGround4(thetaSet{2},h1Set,h1, h0Set, h0,l1Set,obj.l1_update, l0Set, obj.l0_update);
                
                kp = controller.Kp{2}; %80*20;
                kd = controller.Kd{2}; %20*5;            
            end
            
			thetaMin = HAlpha_theta(1);
			thetaMax = HAlpha_theta(end);
			H = [0 0 1 1/2 1/2 0 0];
			theta = H*q;
			dtheta = H*dq;
			
			s = (theta - thetaMin)/(thetaMax - thetaMin);
			ds = dtheta/(thetaMax - thetaMin);
			
            if controller.saturate_s
                s = min(max(s,0),1); % saturate s
            end
            
			[h0, dh0, M0] = outputCoordinate(q,dq); % choose output specification
			T = [zeros(1,4);1 -1 0 0;-1/2 -1/2 0 0;eye(4)];
			
% 			hd = bezierval(HAlpha, s);
% 			dhd = bezierval(diff(HAlpha,[],2),s)*5*ds;
            hd = bezier(HAlpha, s);
			dhd = bezierd(HAlpha,s)*ds;
			
			% Nonholonomic constraint foot placement
			if 0
			dx_p_gain = 0.2;
			hd(2) = hd(2) +	s*dx_p_gain*(obj.vcm(1) - dx_tgt);
			end
			
			y = h0 - hd;
			dy = dh0 - dhd;
			
			y_angle = (M0*T)\y;
			dy_angle = (M0*T)\dy;
			
% 			kp = controller.Kp; %80*20;
% 			kd = controller.Kd; %20*5;
			
            % PD controller
			u_PD = -kp*y_angle - kd*dy_angle;
			
            vcm = obj.vcm(1);
            
            %% I-O controller
            qact=q(3:7);dqact=dq(3:7); % ignore hip pos and vel
            [D,C,G,B,~]= LagrangeModelAtrias2D(qact,dqact); % D*ddq+C*dq+G=B*u
            fq= -inv(D)*(C*dqact+G); gq= inv(D)*B; % ddq=fq+gq*u
            
            M0=M0(:,3:7);
            Lf2h0 = M0*fq; 
            LgLfh0 = M0*gq;
            
%           s = (theta - thetaMin)/(thetaMax - thetaMin);
%           theta=H*q;
            H=H(3:7);
            Lf2s= H*fq/(thetaMax-thetaMin);
            LgLfs= H*gq/(thetaMax-thetaMin);
                        
            Lf2hd=beziera(HAlpha, s)*(ds)^2 + bezierd(HAlpha, s)*Lf2s;
            LgLfhd=bezierd(HAlpha, s)*LgLfs;
            
            Lf2y=Lf2h0-Lf2hd;
            LgLfy=LgLfh0-LgLfhd;
            
            T=T(3:7,:);
            Lf2y_angle=(M0*T)\Lf2y;
            LgLfy_angle=(M0*T)\LgLfy;
            
			%% compute vector field for CBF
%           
            [lF,hb,gb,Lf_gb,Lg_gb]= CBF_compute(q,dq,fq,gq,Nstep,controller,ls_last);
            [p_knee,E_knee,Eq_knee]= swing_knee_pos(q,dq);

            u_star=LgLfy_angle\(-Lf2y_angle);
            
            if strcmp(controller.type,'lqr')
                u_lqr=-controller.K_lqr*[y_angle; dy_angle];
                u=u_star+LgLfy_angle\u_lqr;
            elseif strcmp(controller.type,'io')
                u=u_star+LgLfy_angle\u_PD;
            elseif strcmp(controller.type,'mn')
                u=Min_norm_controller(y_angle,dy_angle,Lf2y_angle,LgLfy_angle,controller);
            elseif strcmp(controller.type,'clf')
                u=CLF_QP_controller(y_angle,dy_angle,Lf2y_angle,LgLfy_angle,controller);
            elseif strcmp(controller.type,'cbf') 
%                 a_cm=dJ_cm*dqact+J_cm*ddq;
                Lf_a_com=dJ_cm*dqact+J_cm*fq;
                Lg_a_com=J_cm*gq;
                 u=CBF_QP_controller(y_angle,dy_angle,Lf2y_angle,LgLfy_angle,gb,Lf_gb,Lg_gb,Lf_a_com,Lg_a_com,controller); 
            else % PD controller
                u=u_PD;
            end
            
            % Lyapunov function
            eta = [y_angle;  dy_angle];
            P=controller.P;

            V = transpose(eta)*P*eta;
            
            if controller.hard_saturation
                ub=controller.ub;
               u= min(ub,max(u,-ub));
            end
            
            % compute GRF
            ddq=fq+gq*u;
%             obj.vcm-J_cm*dqact==0
            a_cm=dJ_cm*dqact+J_cm*ddq;
            
            ld=controller.CBF_ld(Nstep);

             % export data
             data=[u;vcm;lF;V;hb;gb;a_cm;ld;p_knee];
		end
		
	end
	
end