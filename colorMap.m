function [selected_color]=colorMap(num,max_color_value)
%颜色映射函数，输入一个数值范围0-max_clor_value,将
%颜色空间映射到0-max_clor_value的数值中去，输入一个
% 这个范围里面的数num,可以返回一个颜色值selected_color


% jet_color = colormap(hsv(max_color_value));
% jet_color = colormap(cool(max_color_value));
% jet_color = colormap(hot(max_color_value));
% jet_color = colormap(pink(max_color_value));
% jet_color = colormap(gray(max_color_value));
% jet_color = colormap(pink(max_color_value));
% jet_color = colormap(bone(max_color_value));
jet_color = colormap(jet(max_color_value));
% jet_color = colormap(copper(max_color_value));
% jet_color = colormap(prim(max_color_value));
% jet_color = colormap(flag(max_color_value));

   selected_color = jet_color(num,:);


