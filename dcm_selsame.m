% dcm_selsame
% �ҳ����������ж��е�ID
clc;clear all;close all
filepath = uigetdir('Please select a dir');%ѡ��ĳ���ļ���
files = dir(filepath);
IDfiles = dir('F:\��Ŀ\HCC\data\dataall');
IDinall = {}; % �����������ж��е�ID��
IDnotall = {}; % ���治���������ж��е�ID��

for IDnum = 3:length(IDfiles)
    if IDfiles(IDnum).isdir ~= 1
        continue;
    else
        ID = IDfiles(IDnum).name;
    end
    FLAG = 1;
    for i = 3:length(files)
        if files(i).isdir == 1 %�ж��ǲ����ļ���
            roispath = [filepath,'\',files(i).name,'\rois\'];
            FLAG = FLAG & exist([roispath,ID,'_roi.bmp']);
        end
    end
    if FLAG == 1
        IDinall = [IDinall;ID];
    else
       IDnotall = [IDnotall;ID]; 
    end
end
xlswrite([filepath,'\IDsel.xls'],IDinall,'IDinall')
xlswrite([filepath,'\IDsel.xls'],IDnotall,'IDnotall')
            
        