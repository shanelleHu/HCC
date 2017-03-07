% 按序列提取每个ID的相应DCM到一个文件夹
clc;clear all
[data,text] = xlsread('F:\项目\HCC\data\肝癌病例信息_病理_20170302.xlsx','Sheet2','C:I');
datapath = 'F:\项目\HCC\data\201703\';
resultpath = 'E:\HCC\按序列\';
[m,n] = find(data(:,end)==3);
for i = 1:length(m)
    ID = data(m(i),1);
    serial1 = [num2str(data(m(i),4)),'.dcm'];
    serial2 = [num2str(data(m(i),5)),'.dcm'];
    serial3 = [num2str(data(m(i),6)),'.dcm'];
    IDdatapath = [datapath,num2str(ID),'\'];
    serialpath1 = [IDdatapath,'t1_vibe_fs_tra_bh','\'];
    serialpath2 = [IDdatapath,'t1_vibe_fs_tra_bh_5min','\'];
    serialpath3 = [IDdatapath,'t1_vibe_fs_tra_bh_10min','\'];
    copyfile([serialpath1,serial1],...
        [resultpath,'t1_vibe_fs_tra_bh\',num2str(ID),'.dcm'])
    copyfile([serialpath2,serial2],...
        [resultpath,'t1_vibe_fs_tra_bh_5min\',num2str(ID),'.dcm'])
    copyfile([serialpath3,serial3],...
        [resultpath,'t1_vibe_fs_tra_bh_10min\',num2str(ID),'.dcm'])
end
    
    
    