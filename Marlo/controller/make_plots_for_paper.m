function make_plots_for_paper(response,y,dy,data,controller,ls_last)
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
    end
 
    figure; plot(t,u);
    xlabel('Time (s)'); ylabel('u (Nm)'); 
%     title('Control Inputs');
    axis tight;
    ylim([-7.5 7.5]);
    savename='figures\control_inputs';
    pos=[0 0 9.69/2 2];
    set(gcf, 'PaperPosition', pos); 
    set(gcf, 'PaperSize', pos(3:4));
    saveas(gcf, savename, 'pdf')
    
    lmin=ld-controller.stone_size; lmax=ld+controller.stone_size;
    figure; f=plot(t,LF,t,lmin,':',t,lmax,':');
%     set(f(1),'linewidth',2);
    xlabel('Time (s)'); ylabel('(m)'); 
%     title('Step Length');
    h=legend('$l_f$','$l_{min}$','$l_{max}$');
    set(h,'Interpreter','latex','Location','northoutside','Orientation','horizontal');
    axis tight;
    savename='figures\step_length';
    pos=[0 0 9.69/2 2.5];
    set(gcf, 'PaperPosition', pos); 
    set(gcf, 'PaperSize', pos(3:4));
    saveas(gcf, savename, 'pdf')

    figure; f=plot(t,hb(:,1),':',t,abs(hb(:,2)));
    set(f(1),'linewidth',2);
    set(f(2),'linewidth',1);
%     ylabel('CBF constraints'); 
    xlabel('Time (s)');  
%     title('CBF position constraints');
	h=legend('$h_1(x)$','$h_2(x)$');
    set(h,'Interpreter','latex','Location','northoutside','Orientation','horizontal');
    axis tight;
%     ylim([-0.2 inf]);
    savename='figures\CBF_constraints';
    pos=[0 0 9.69/2 2.5];
    set(gcf, 'PaperPosition', pos); 
    set(gcf, 'PaperSize', pos(3:4));
    saveas(gcf, savename, 'pdf')
%     figure; plot(t,hb(:,1));
%     ylabel('h1'); xlabel('Time (s)');  title('CBF position constraints');
%     
%     figure; plot(t,hb(:,2));
%     ylabel('h2'); xlabel('Time (s)');  title('CBF position constraints');
    
%      figure; plot(t,gb);
%     xlabel('gb'); ylabel('Time (s)');  title('CBF constraints gb');
%     legend('gb1','gb2');
    
    acm(:,2)=acm(:,2)+9.81;
    figure; plot(t,acm(:,2)*63); % robot weight= 60kg
    ylabel('N (N)'); xlabel('Time (s)');  
%     title('Ground Reaction Force');
    axis tight;
    ylim([0 inf]);
    savename='figures\contact_force';
    pos=[0 0 9.69/2 2];
    set(gcf, 'PaperPosition', pos); 
    set(gcf, 'PaperSize', pos(3:4));
    saveas(gcf, savename, 'pdf')
    
    kf=acm(:,1)./acm(:,2);
    kf=abs(kf);
    figure; plot(t,kf);
    ylabel('|F/N|'); xlabel('Time (s)');  
%     title('Friction |F/N|');
    axis tight;
    ylim([-inf 0.65]);
    savename='figures\friction_cone';
    pos=[0 0 9.69/2 2];
    set(gcf, 'PaperPosition', pos); 
    set(gcf, 'PaperSize', pos(3:4));
    saveas(gcf, savename, 'pdf')
end