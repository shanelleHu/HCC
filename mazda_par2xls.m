% 把mazda生成的report文件转化为xls文件
% 按照Image File重命名，选出Image File和ROI File不一样的ID号
clc;clear all;close all

filepath = uigetdir('Please select a dir');%选择某个文件夹
if filepath == 0
    disp('No dir selected')
else
    cd(filepath)
    filepath = [filepath, '\'];
    files = dir([filepath,'*par']);   
    resultpath = [filepath,'xls\'];
    diffroi = {};%保存Image File和ROI File不一样的ID号
    if exist(resultpath) ~= 7
        mkdir(resultpath)
    end
    for parcount = 1:length(files)
        filename = files(parcount).name;
        pardata = importdata([filepath,filename]);
        cutlength = length(pardata.textdata) - length(pardata.data);
        imagename = strrep(pardata.textdata{1,1},'Image File: ','');  
        roiname = strrep(pardata.textdata{2,1},'ROI File: ','');
        if strcmp(imagename(1:end-5),roiname(1:end-9)) == 1
            oldfile = [filepath,filename];
            newfile = [filepath,imagename(1:end-5),'.par'];
            if strcmp(newfile,oldfile) == 1 
                continue % 如果par文件已经按照DCM文件名命名，不再重命名
            else
                movefile(oldfile,newfile)
%                 xlswrite([resultpath,imagename(1:end-5),'.xls'],...
%                 pardata.textdata,'sheet1','A1');
%                 xlswrite([resultpath,imagename(1:end-5),'.xls'],...
%                 pardata.data,'sheet1',['B',num2str(cutlength+1)]);  
            end
        else
            diffroi = [diffroi;imagename(1:end-5)];
        end
    end
end