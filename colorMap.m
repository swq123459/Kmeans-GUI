function [selected_color]=colorMap(num,max_color_value)
%��ɫӳ�亯��������һ����ֵ��Χ0-max_clor_value,��
%��ɫ�ռ�ӳ�䵽0-max_clor_value����ֵ��ȥ������һ��
% �����Χ�������num,���Է���һ����ɫֵselected_color


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


