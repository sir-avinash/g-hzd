function save_figure(FolderName, pngOnly)
if nargin < 1
	FolderName = 'SaveFigure';
	pngOnly = 0;
elseif nargin < 2
	pngOnly = 0;
end

	if ~exist(FolderName, 'dir')
	   mkdir(FolderName);
	end
	
fig_no=get(0, 'Children');
total_fig = length(fig_no);

for n = 1:total_fig
    figure(fig_no(n))
    set(gcf, 'Color', 'none'); % Sets axes background
	figName = get(gcf,'Name');
	if isempty(figName)
		figName = num2str(fig_no(n).Number);
	end
% 	saveas(gcf, [FolderName,'\',num2str(fig_no(n).Number),'.',format])
if ~pngOnly
	export_fig([FolderName,'\',figName], '-q101','-pdf','-png','-transparent','-m3')
	set(gcf, 'Color', 'w'); % Sets axes background
	savefig([FolderName,'\',figName])
else
	export_fig([FolderName,'\',figName],'-png','-m10','-transparent')
	set(gcf, 'Color', 'w'); % Sets axes background
end

% 	saveas(gcf, [FolderName,'\',num2str(total_fig-n+1),'.',format])
% 	print(gcf, [FolderName,'\',num2str(total_fig-n+1),'.',format])

end
clear total_fig fig_no na