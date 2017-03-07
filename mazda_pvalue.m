% 计算MaZda选取特征的pvalue
clc;clear all;close all
[dataname,datapath]=uigetfile('*.sel','Please select a file');
cd(datapath)
% datapath = 'F:\项目\HCC\data\reports\t1_vibe_fs_tra_bh_30.xlsx';
seldata = importdata([datapath,dataname]);
data = seldata.data;
text = seldata.textdata;
categoloc = find(strcmp(text,'*categories'));
featurename = text(4:categoloc-1,1);
classname = text(categoloc+1:categoloc+2,1);
num1 = find(data(:,1)==1);% 第一类的行号
num2 = find(data(:,1)==2);% 第二类的行号
ALPHA = 0.05; 
resultP = [];%存储P值
for i = 1:length(featurename)
    class1 = data(num1,1+i);
    class2 = data(num2,1+i);
    [H,P,CI]=ttest2(class1,class2,ALPHA); % T检验
    if P <= 0.1
        resultP = [resultP;i,P];
    end
end
resultP = sortrows(resultP,2); 
data = data(:,2:end);
xlswrite([datapath,dataname(1:end-4),'.xls'],featurename,'featurename','A1')
xlswrite([datapath,dataname(1:end-4),'.xls'],data(num1,resultP(:,1)),'class1','A2')
xlswrite([datapath,dataname(1:end-4),'.xls'],data(num2,resultP(:,1)),'class2','A2')
xlswrite([datapath,dataname(1:end-4),'.xls'],resultP,'ttest')
xlswrite([datapath,dataname(1:end-4),'.xls'],classname,'ttest','D1')

% xmin = resultP(1,1);
% ymin = resultP(3,1);
% zmin = resultP(3,1);
% % % 二维图
% plot(data(num1,xmin),data(num1,ymin),'r+');
% hold on
% plot(data(num2,xmin),data(num2,ymin),'b*');
% hold off
% 
% % 三维图
% figure
% plot3(data(num1,xmin),data(num1,ymin),data(num1,zmin),'r+');
% hold on
% plot3(data(num2,xmin),data(num2,ymin),data(num2,zmin),'b*');
% hold off