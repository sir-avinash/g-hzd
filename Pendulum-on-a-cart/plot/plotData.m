log = load('DataFiles\log\EquBack080917');
x = log.logsout.getElement('x');
u = log.logsout.getElement('u');
%%
figure(1)
plot(x.Values.Time, x.Values.Data)






%%
log = load('DataFiles\log\nnEqu_full');
x = log.logsout.getElement('x');
u = log.logsout.getElement('u');
V = log.logsout.getElement('sample_Data');
%%
figure(1)
plot(V.Values.Time, V.Values.Data(:),'o')
xlabel('Time (s)')
ylabel('$V(x)$')






%%
save_figure('fig')
