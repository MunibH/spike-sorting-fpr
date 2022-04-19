function rasterPlot(times,spikes)


dt = median(diff(times));

f = figure; hold on
for trix = 1:size(spikes,2)
    spktm = find(spikes(:,trix)) .* dt;
    if isempty(spktm)
        continue
    end
    plot(spktm, trix,'k.')
end
ax = f.CurrentAxes;
xlabel(ax,'Time (s)')
ylabel('Trial Number')
ax.FontSize = 20;

end % rasterPlot