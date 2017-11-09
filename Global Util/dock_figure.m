fig_no=get(0, 'Children');
total_fig = length(fig_no);

for n = 1:total_fig
    figure(fig_no(n));
    set(gcf, 'WindowStyle', 'docked')
end
clear total_fig fig_no n