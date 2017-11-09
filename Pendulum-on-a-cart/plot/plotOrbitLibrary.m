log = load('DataFiles\log\nnOrbitLibrary090917');
x = log.logsout.getElement('x');
u = log.logsout.getElement('u');
output_Data = log.logsout.getElement('output_Data');

%%
close(figure(1))
h1 = figure(1);clf
set(gcf, 'Name','OrbitTransition');
subplot(211)
plot(x.Values.Time, x.Values.Data(:,1),'LineWidth',1.5)
grid on
ax = gca;
ax.TickLabelInterpreter = 'latex';
% ax.YLim = [-2 1.5];
ax.YTick = [-3:0.5:2];
ColOrd = get(gca,'ColorOrder');
% ax.XTick = [0:2:20];
% xlabel('Time (s)')
% ylabel('States $x$')

legend('$p$','Location','southeast');
% title('$R^2$','Interpreter', 'latex')
h = findobj(gcf,'Tag','legend');
set(h,'Interpreter', 'latex')	

subplot(212)
ax = gca;
plot(x.Values.Time, x.Values.Data(:,3),'LineWidth',1.5, 'Color', ColOrd(2,:))
grid on
ax.TickLabelInterpreter = 'latex';
ax.YLim = [-2.3,2.3];
ax.YTick = [-2:0.5:2];
xlabel('Time (s)')
% ylabel('Input $u$')
legend('$\dot{p}$','Location','southeast');
h = findobj(gcf,'Tag','legend');
set(h,'Interpreter', 'latex')


%
P = get(gcf,'Position');
scale = 1;
set(gcf, 'Position', [P(1) P(2) P(3)*0.6 P(4)*scale]);
%%
close(figure(2))
h1 = figure(2);clf
set(gcf, 'Name','OrbitOutputError');
plot(output_Data.Values.Time, output_Data.Values.Data(:,1),'LineWidth',1.5)
grid on
ax = gca;
ax.TickLabelInterpreter = 'latex';
% ax.XLim = [0 20];
% ax.YLim = [-2 1];
ax.YTick = [-0.5:0.25:0.5];
% ax.XTick = [0:2:20];
xlabel('Time (s)')
% ylabel('$V(x)$')

% legend('$p$','$\dot{p}$','$\theta$','$\dot{\theta}$','Location','southeast');
legend('$y$ element 1','Location','northeast');
% title('$R^2$','Interpreter', 'latex')

h = findobj(gcf,'Tag','legend');
set(h,'Interpreter', 'latex')	
%
P = get(gcf,'Position');
scale = 0.6;
set(gcf, 'Position', [P(1) P(2) P(3)*scale P(4)*scale*0.5]);

%%
parentPath = 'C:\Users\xingye\Dropbox (DynamicLegLocomotion)\TeamWide\Dennis\Journal 2017\Graphics\MATLAB\';

save_figure([parentPath, 'fig'])