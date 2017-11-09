x = -2:0.01:2;
% y = 1 - gaussmf(x,[.1 -1])/20 + 0.01;
y = roofProfile(x);
figure(100)
plot(x,y)
xlim([-2 2])
ylim([0 1.5])
% xlabel('gaussmf, P=[2 5]')