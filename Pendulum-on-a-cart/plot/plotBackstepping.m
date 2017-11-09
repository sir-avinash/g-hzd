log = load('DataFiles\log\EquBack080917');
x = log.logsout.getElement('x');
u = log.logsout.getElement('u');
output_Data = log.logsout.getElement('output_Data');
%%
% close figure 1
% h1 = figure(1);clf
% set(gcf, 'Name','BackSteppingState');
% plot(x.Values.Time, x.Values.Data,'LineWidth',1.5)
% ax = gca;
% % ax.XLim = [0 20];
% ax.YLim = [-2 1];
% 
% xlabel('Time (s)')
% ylabel('$V(x)$')
% 
% legend('$p$','$\dot{p}$','$\theta$','$\dot{\theta}$','Location','southeast');
% % title('$R^2$','Interpreter', 'latex')
% 
% h = findobj(gcf,'Tag','legend');
% set(h,'Interpreter', 'latex')	
% %
% P = get(gcf,'Position');
% scale = 0.6;
% set(gcf, 'Position', [P(1) P(2) P(3)*scale P(4)*scale]);

%%
try
close figure 2; catch
end
h1 = figure(2);clf
set(gcf, 'Name','BackSteppingState2');
subplot(211)
plot(x.Values.Time, x.Values.Data(:,[1 3 2 4]),'LineWidth',1.5)
grid on
ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.YLim = [-2 1.5];
ax.YTick = [-2:0.5:1.5];
ax.XTick = [0:2:20];
% xlabel('Time (s)')
% ylabel('States $x$')

legend('$p$','$\dot{p}$','$\theta$','$\dot{\theta}$','Location','southeast');
% title('$R^2$','Interpreter', 'latex')
h = findobj(gcf,'Tag','legend');
set(h,'Interpreter', 'latex')	

subplot(212)
plot(u.Values.Time, u.Values.Data,'LineWidth',1.5)
grid on
ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.XTick = [0:2:20];
% ax.YLim = [-5 5];
% ax.YTick = [-6:2:6];
ax.YLim = [-20 10];
ax.YTick = [-20:5:10];
xlabel('Time (s)')
% ylabel('Input $u$')
legend('$u$','Location','southeast');
h = findobj(gcf,'Tag','legend');
set(h,'Interpreter', 'latex')


%
P = get(gcf,'Position');
scale = 1;
set(gcf, 'Position', [P(1) P(2) P(3)*0.6 P(4)*scale]);

%%
% close figure 3
% h1 = figure(3);clf
% set(gcf, 'Name','BackSteppingState3');
% subplot(121)
% plot(x.Values.Time, x.Values.Data(:,[1 3 2 4]),'LineWidth',1.5)
% ax = gca;
% % ax.XLim = [0 20];
% ax.YLim = [-2 1];
% ax.YTick = [-2:0.5:1];
% ax.XTick = [0:5:20];
% xlabel('Time (s)')
% % ylabel('States $x$')
% 
% legend('$p$','$\dot{p}$','$\theta$','$\dot{\theta}$','Location','southeast');
% % title('$R^2$','Interpreter', 'latex')
% h = findobj(gcf,'Tag','legend');
% set(h,'Interpreter', 'latex')	
% 
% subplot(122)
% plot(u.Values.Time, u.Values.Data(:),'LineWidth',1.5)
% % ax = gca;
% % ax.XLim = [0 20];
% % ax.YLim = [-2 1];
% ax = gca;
% ax.XTick = [0:5:20];
% xlabel('Time (s)')
% % ylabel('Input $u$')
% legend('$u$','Location','southeast');
% % title('$R^2$','Interpreter', 'latex')
% h = findobj(gcf,'Tag','legend');
% set(h,'Interpreter', 'latex')
% 
% 
% %
% P = get(gcf,'Position');
% scale = 0.5;
% set(gcf, 'Position', [P(1) P(2) P(3)*0.8 P(4)*scale]);

%%
try
close figure 4; catch
end
h1 = figure(4);clf
set(gcf, 'Name','OutputError');
plot(output_Data.Values.Time, output_Data.Values.Data,'LineWidth',1.5)
grid on
ax = gca;
ax.TickLabelInterpreter = 'latex';
% ax.XLim = [0 20];
ax.YLim = [-0.6 1.2];
ax.YTick = [-0.5:0.5:1];
% ax.YTick = [-0.6:0.2:1.2];
ax.XTick = [0:2:20];

xlabel('Time (s)')
% ylabel('$Output Error$')

legend('$y$ element 1','$y$ element 2','Location','northeast');
% title('$R^2$','Interpreter', 'latex')

h = findobj(gcf,'Tag','legend');
set(h,'Interpreter', 'latex')	
%
P = get(gcf,'Position');
scale = 0.6;
set(gcf, 'Position', [P(1) P(2) P(3)*scale P(4)*scale]);


%%
parentPath = 'C:\Users\xingye\Dropbox (DynamicLegLocomotion)\TeamWide\Dennis\Journal 2017\Graphics\MATLAB\';

save_figure([parentPath, 'fig'])