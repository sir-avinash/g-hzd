plot(sin(linspace(0, 10, 1000)), 'b:', 'LineWidth', 4);
hold on
plot(cos(linspace(0, 7, 1000)), 'r--', 'LineWidth', 3);
grid on
export_fig('haha\test', '-q101','-eps')

% export_fig( [filename] -pdf -eps -png -jpg -tiff