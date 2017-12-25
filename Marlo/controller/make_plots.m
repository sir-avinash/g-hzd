function make_plots(response,y,dy,data,controller,ls_last)
%% Check Tracking

	t = [response.time{:}];
	Y = [];
	dY = [];
	Vcm = [];
    LF= [];
    HF= [];
    V_clf= [];
    u= [];
    hb=[];
    gb=[];
    acm= [];
    ld = [];
    p_knee=[];
	for n = 1:size(y,2)
        Y = [Y;y{n}];
		dY = [dY;dy{n}];
        u = [u; data{n}(:,1:4)];
		Vcm = [Vcm;data{n}(:,5)];
        LF = [LF;data{n}(:,6)];
        HF = [HF;data{n}(:,7)];
		V_clf = [V_clf;data{n}(:,8)];
        hb=[hb;data{n}(:,9:10)];
        gb=[gb;data{n}(:,11:12)];
        acm=[acm;data{n}(:,13:14)];
        ld=[ld;data{n}(:,15)];    
        p_knee=[p_knee;data{n}(:,16:17)];
	end
% 	figure(10)
% 	plot(t,Y(:,2));ylim([0.8 1.2]);%movegui(gca,[2000,0])
% 	xlabel('Time (s)')
% 	ylabel('Hip Height (m)')
% 	figure(11)
%     figure;
%     dY=180*dY/pi;
% 	plot(t,dY);
% 	xlabel('Time (s)')
% 	ylabel('dq (degree/s)')
    
    figure; plot(t,u);
    xlabel('Time (s)'); ylabel('u'); title('Control Inputs');
    
% % 	figure;	plot(t,Vcm);ylim([0 2]);
% % 	xlabel('Time (s)'); ylabel('v_{cm} (m/s)'); title('COM Velocity');
    
% %     lmin=ld-controller.stone_size; lmax=ld+controller.stone_size;
% %     figure; plot(t,LF,t,lmin,'--',t,lmax,'--');
% %     xlabel('Time (s)'); ylabel('l_{f} (m)'); title('Step Length');  
% %     
% %     figure;	plot(t,HF);
% %     xlabel('Time (s)'); ylabel('h_{f} (m)'); title('Step Height');
% %     
    figure; plot(LF,HF,p_knee(:,1),p_knee(:,2)); legend('Swing foot','Swing knee');
    axis equal
%     swing foot traj with circle constrains
if controller.plot_circle_constraint
    lf_end=0;
    Nstep=size(y,2);
    for n = 1:Nstep
        figure;
        LF = data{n}(:,6)+lf_end;
        HF = data{n}(:,7);
%         subplot(Nstep,1,n);
    hold on; plot(LF,HF); axis('equal');
    xlabel('l_f (m)');	ylabel('h_{f} (m)'); title('Swing Foot Trajectory');
    % plot 2 circles of CBF constraints
    R1=controller.CBF_R1; l_max=controller.CBF_ld(n)+0.025;
    x=-R1+lf_end; y=0; r=R1+l_max;
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    hold on; plot(xunit, yunit,'--');
    
    %%%%%%
    R2=controller.CBF_R2; l_min=controller.CBF_ld(n)-0.025;
    l0=ls_last{n}-controller.CBF_delta_l0;
    x=l_min/2-l0/2+lf_end; y=-R2; r=sqrt((l_min/2+l0/2)^2+y^2);
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    hold on; plot(xunit, yunit,'--');
    grid on;
    hold on; line([l_min l_max]+lf_end,[0 0],'color','k','linewidth',2);
%     lf_end=LF(end);
    end
%     figure; plot(t,V_clf);
%     xlabel('V'); ylabel('Time (s)');  title('Lyapunov Function');
end
%     figure; plot(t,hb);
%     xlabel('hb'); ylabel('Time (s)');  title('CBF position constraints');
% 	legend('h1','h2');
    
% %     figure; plot(t,hb(:,1));
% %     ylabel('h1'); xlabel('Time (s)');  title('CBF position constraints');
% %     
% %     figure; plot(t,hb(:,2));
% %     ylabel('h2'); xlabel('Time (s)');  title('CBF position constraints');
    
%      figure; plot(t,gb);
%     xlabel('gb'); ylabel('Time (s)');  title('CBF constraints gb');
%     legend('gb1','gb2');
    
    acm(:,2)=acm(:,2)+9.81;
    figure; plot(t,acm(:,2)*63);
    ylabel('N'); xlabel('Time (s)');  title('Ground Reaction Force');
    
    kf=acm(:,1)./acm(:,2);
    kf=abs(kf);
    figure; plot(t,kf);
    ylabel('kf'); xlabel('Time (s)');  title('Friction |F/N|');
    
% %         %% check violation on step length and friction
% %     step_number=1;
% %     delta_l=1e-4;
% %     violation_counter=0;
% %     for i=1:(length(t)-1)
% %         if i>1
% %         if abs(LF(i+1)-LF(i))>0.15
% %             
% %             % check if violate step length
% %             if (lmin(i)-LF(i))>delta_l 
% %                 disp(['Violate l_min on step ' num2str(step_number) '!!!'])
% %                 violation_counter=violation_counter+1;
% %             end
% %             if (LF(i)-lmax(i))>delta_l
% %                 disp(['Violate l_max on step ' num2str(step_number) '!!!'])
% %                 violation_counter=violation_counter+1;
% %             end
% %             step_number=step_number+1;
% %         end
% %         end
% %         
% %         if acm(i,2)<(controller.friction_delta_a+delta_l)
% %             disp('Friction Violation (N < delta_a)!!!')
% %             violation_counter=violation_counter+1;
% %         end
% %         
% %         if kf(i)>(controller.friction_kf-delta_l)
% %             disp('Friction Violation (|F/N|>kf)!!!')
% %             violation_counter=violation_counter+1;
% %         end
% %     end
% %     
% %     if violation_counter==0
% %         disp('No step length of friction violation!!!')
% %     end

end