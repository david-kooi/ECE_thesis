function [modF, modJ] = get_hybrid_plot_mods(color, line_width, marker, marker_size)
modF{1} = color;
modF{2} = 'LineWidth';
modF{3} = line_width;

modJ{1} = color;
modJ{2} = 'Marker';
modJ{3} = marker;
modJ{4} = 'MarkerSize';
modJ{5} = marker_size;
modJ{6} = 'MarkerFaceColor';
modJ{7} = color;

end