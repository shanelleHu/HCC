% ��������ȡÿ��ID����ӦDCM��һ���ļ���
clc;clear all
[data,text] = xlsread('F:\��Ŀ\HCC\data\�ΰ�������Ϣ_����_20170302.xlsx','Sheet2','C:I');
datapath = 'F:\��Ŀ\HCC\data\201703\';
resultpath = 'E:\HCC\������\';
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
    
    
    