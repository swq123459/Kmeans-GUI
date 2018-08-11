function KmeansMain
close all;clear;clc;
%������������
mu=[0 0];
%Э������󣬶Խ�Ϊ����ֵ0.3��0.35
var=[0.3 0;0 0.35];
samNum=200;
data=mvnrnd(mu,var,samNum);
a=figure;
plot(gca,data(:,1),data(:,2),'*','color','k');hold on;
classNum=[];%����
iterNum=0;%��������
x=[];y=[];centerPoint=[];centerPointPathAarry=[];
h_plotCenterPoint=[];%���ĵ����handle
h_plotPath=[];%���ĵ�·������handle
%centerPointPathAarry�ṹ
%��1�ε���|���ĵ�1(x,y)|���ĵ�2(x,y)|���ĵ�3(x,y)|���ĵ�n(x,y)
%��2�ε���|���ĵ�1(x,y)|���ĵ�2(x,y)|���ĵ�3(x,y)|���ĵ�n(x,y)
h_slider=uicontrol(a,'Style', 'slider',...
      'SliderStep',[0.02 0.02],...
        'Min',0,'Max',50,'Value',0,...
        'Position', [400 20 100 20],...
        'Callback', {@classify,gca});   
h_edit=uicontrol(a,'Style', 'edit',...  
       'String', '200',...
        'Position', [80 20 40 20],...
        'Callback', {@paintRandomPoint,gca});   
uicontrol('Style', 'popup',...
           'String', '�Զ���|���2��|���3��|���4��',...
           'Position', [200 22 120 20],...
           'Callback', {@SpsfPoit,gca});   
h_t1=uicontrol('Style','text','String','����', ...
                   'Position', [355 20 40 20]);
h_textClassNum=uicontrol('Style','text','String','���ĵ�', ...
                   'Position', [140 20 55 20]);
 uicontrol('Style','text','String','��������:', ...
                   'Position', [25 20 50 20]);
h_textshow=uicontrol('Style','text','String','0', ...
                   'Position', [500 20 20 20]);                         
set(gca,'xtick',[],'ytick',[],...
    'title',text('string','Kmeans��ʾ�ű�','color','k'));
xlim([-1.5 1.5]);ylim([-1.5 1.5]);
%%%%%%%%%%%%%%%%%%%%
function SpsfPoit(hObj,event,ax)
set(h_slider,'value',0);    %���㻬��������ʵ�ִ�0����
cla;%���axes
set(h_textshow,'string',0);%������ʾ�ĵ�����������
%�����ֵΪ��
 h_plotCenterPoint=[];
 h_plotPath=[];
 centerPointPathAarry=[];%�켣����
 plot(gca,data(:,1),data(:,2),'*','color','k');%��������ɫ��ʼ��
val = get(hObj,'Value');%���popup menu��ֵ
if val == 1   
    %ѡ���������ɵ���Ϊ���ĵ�
     [x,y]=ginput;
     centerPoint=[x y];
    [classNum,~]=size(centerPoint);
   repaintBeginPoint(h_plotCenterPoint,classNum,centerPoint);
elseif val == 2
    %ѡ������2����Ϊ���ĵ�
   centerPoint=rand(2,2)*2-0.5;
   [classNum,~]=size(centerPoint);
   repaintBeginPoint(h_plotCenterPoint,classNum,centerPoint);
elseif val == 3
   %ѡ������3����Ϊ���ĵ�
   centerPoint=rand(3,2)*2-0.5;
    [classNum,~]=size(centerPoint); 
    repaintBeginPoint(h_plotCenterPoint,classNum,centerPoint);
elseif val == 4
    %ѡ������4����Ϊ���ĵ�
    centerPoint=rand(4,2)*2-0.5;
    [classNum,~]=size(centerPoint);
    repaintBeginPoint(h_plotCenterPoint,classNum,centerPoint);
end
  [labelSample]=classifyAndShowAndLabel(classNum,centerPoint,data,samNum,gca);
  centerPointPathAarry=[centerPointPathAarry;reshape(centerPoint',1,classNum*2)];
  set(h_textClassNum,'string',[num2str(classNum) '�����ĵ�']);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%�������ຯ��%%%%%%%%%%%%%%%%%%%%
function classify(hObj,event,ax)
    iterNum=round(get(hObj,'value')); 
     set(h_textshow,'string',iterNum);
       %������ʼ����࣬����Ϊ��ͬ�����ǲ�ͬ��ɫ�����ش���ǩ��������
       [labelSample]=classifyAndShowAndLabel(classNum,centerPoint,data,samNum,gca);
      %���»����ʼ�����centerPoint��x|y��
      [centerPoint]=recalClassCenter(labelSample,classNum);
     centerPointPathAarry=[centerPointPathAarry;reshape(centerPoint',1,classNum*2)];
      %���»�����ʼ��centerPoint��x|y����axes��
     repaintBeginPoint(h_plotCenterPoint,classNum,centerPoint);
    disp('path:');disp(centerPointPathAarry);%�����ĵ�Ĺ켣��ʾ����
    for i=1:classNum
         [selected_color]=colorMap(i,classNum);
        h_plotPath(i)=plot(centerPointPathAarry(:,(i*2)-1),centerPointPathAarry(: , i*2),'color',selected_color);
    end
end

%%%%%%%%%%%%%%%��������%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%���»�����ʼ�㺯��%%%%%%%%%
    function repaintBeginPoint(handle_plo,classnum,R)
       delete(h_plotCenterPoint);%������Ƶ����ĵ㣬���������ֵΪ��
        h_plotCenterPoint=[];
        %���»�����ʼ�㣬ÿ����ʼ�����ɫ��ͬ
       for i=1:classnum
        [selected_color]=colorMap(i,classnum);
        h_plotCenterPoint(i)=plot(R(i,1),R(i,2),'o','MarkerSize',7,'MarkerFaceColor',selected_color); 
    end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%���¼���������%%%%%%%%%%%%%%%%%%%%%%
    function [newCenterPoint]=recalClassCenter(labelSample,classNum)
        %RΪ���±������������
        newCenterPoint=[];
       %���ಢ�Ҽ���ÿ���������
      for i=1:classNum      
           %ȡ�����б�ǩΪi��������У�����i������е�
           classs=labelSample(labelSample(:,3)==i,:);
             %���õ�ֻ�е�һ�к͵ڶ��У�ȥ����ǩ��
           classs=[classs(:,1),classs(:,2)];
          %���¼�������
           classs_repoint=mean(classs);
           newCenterPoint=[newCenterPoint;classs_repoint];
      end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%������ʼ����࣬����Ϊ��ͬ�����ǲ�ͬ��ɫ�����ش���ǩ��������%%%%%%%%%
   function [labelSample]=classifyAndShowAndLabel(classNum,centerPoint,data1,samNum,gca)  
     disArray=[];
    for i=1:classNum
        calproA=[centerPoint(i,:);data1(:,1),data1(:,2)];
        Adist=pdist(calproA,'euclidean');
        Adist=Adist(1:samNum)';
        disArray=[disArray,Adist];
    end
  %ƴ��,�õ��������һ�д���һ���㵽����������ľ���
  %disArray=[Adist Bdist];
   %disp(disArray);
   %��ȡÿһ����Сֵ���ھ���������
   %����ԭ��������ƴ��ΪlabelSample
   %labelSample ��ʾ����ǵ�ԭʼ������ÿһ��Ϊһ������
   %ÿһ�е����һ��Ϊ���ֵ�����������Ǿ����ĸ������������
   minn=min(disArray');
   cols=[];
  for i=1:length(minn)
      [row,col] = find(disArray==minn(i));
      cols(i)=col;
  end
  cols=cols';
   labelSample=[data1(:,1),data1(:,2),cols];
   %����ͬ��ĵ���ϲ�ͬ����ɫ
   for i=1:samNum
        [selected_color]=colorMap(labelSample(i,3),classNum);
       plot(gca,data1(i,1),data1(i,2),'*','color',selected_color);
   end
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%colorMap��ɫӳ�亯��%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%������ѡ�񲢻��ƺ���%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function paintRandomPoint(hObj,event,ax)
        textt=get(hObj,'string');
        samNum=str2num(textt);
        data=mvnrnd(mu,var,samNum);
        cla;
        set(h_slider,'value',0);    %���㻬��������ʵ�ִ�0����
        plot(ax,data(:,1),data(:,2),'*','color','k');hold on;
        %set(h_t1,'string',textt);
    end
end


