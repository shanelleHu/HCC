% dcm_selsame
% 找出各个序列中都有的ID
clc;clear all;close all
filepath = uigetdir('Please select a dir');%选择某个文件夹
files = dir(filepath);
IDfiles = dir('F:\项目\HCC\data\dataall');
IDinall = {}; % 保存所有序列都有的ID号
IDnotall = {}; % 保存不是所有序列都有的ID号

for IDnum = 3:length(IDfiles)
    if IDfiles(IDnum).isdir ~= 1
        continue;
    else
        ID = IDfiles(IDnum).name;
    end
    FLAG = 1;
    for i = 3:length(files)
        if files(i).isdir == 1 %判断是不是文件夹
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
            
        