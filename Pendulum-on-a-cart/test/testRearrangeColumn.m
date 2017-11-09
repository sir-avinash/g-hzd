t = 0:1:3*pi;

y = sin(2*t);

y2 = y;
cutLine = 1:2;
y2 = [y2, y2(cutLine)];
y2(cutLine) = [];

figure(100)
plot(t, [y; y2])