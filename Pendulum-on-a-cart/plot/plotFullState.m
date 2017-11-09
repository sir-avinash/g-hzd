
%%
log = load('DataFiles\log\nnEqu_full');
x = log.logsout.getElement('x');
u = log.logsout.getElement('u');
V = log.logsout.getElement('sample_Data');

%%
try
close figure 1; catch
end
h1 = figure(1);clf
set(gcf, 'Name','LyapunovFunction');
plot(V.Values.Time(1:6), V.Values.Data(1:6),'o--','LineWidth',1.5)
xlabel('Time (s)')
ylabel('$V(x)$')
grid on
ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.XTick = [0:2:20];

P = get(gcf,'Position');
scale = 0.6;
set(gcf, 'Position', [P(1) P(2) P(3)*scale P(4)*scale]);

%%
try
close figure 2; catch
end
h1 = figure(2);clf
set(gcf, 'Name','FullStateLearned');
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
log = load('DataFiles\log\nnEqu_fullMPC');
x = log.logsout.getElement('x');
u = log.logsout.getElement('u');
V = log.logsout.getElement('sample_Data');

%%
try
close figure 10; catch
end
h1 = figure(10);clf
set(gcf, 'Name','FullStateMPC');
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
log = load('DataFiles\log\mpcController');
x = log.logsout.getElement('x');
u = log.logsout.getElement('u_zoh');
V = log.logsout.getElement('sample_Data');

%%
try
close figure 10; catch
end
h1 = figure(10);clf
set(gcf, 'Name','FullStateMPCshort');
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
% plot(u.Values.Time, u.Values.Data,'LineWidth',1.5)
stairs(u.Values.Time, u.Values.Data,'LineWidth',1.5)
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
parentPath = 'C:\Users\xingye\Dropbox (DynamicLegLocomotion)\TeamWide\Dennis\Journal 2017\Graphics\MATLAB\';

save_figure([parentPath, 'fig'])
