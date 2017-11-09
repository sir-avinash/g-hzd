t = 0:1e-3:1;
% x = [zeros(size(t)); zeros(size(t)); t];

t = -2:1e-3:2;
x = [t; zeros(size(t)); zeros(size(t))];
y = nnControllerEquilibriumReducedGrid(x);
figure(200)
plot(t, y)

% plot(t, [y(2,:); cumtrapz(y(3,:), t)])