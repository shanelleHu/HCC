%   将mazda生成的xls数据整合到一个xls中
%   
clc; clear all
N = 2;%第二个ROI
filepath = uigetdir('Please select a dir');%选择某个文件夹
if filepath == 0
    disp('No dir selected')
else
    cd(filepath)
    filepath = [filepath, '\'];
    files = dir([filepath,'*xls']);
    filename = files(1).name;
    [xlsdata,xlstext] = xlsread([filepath,filename]);
    cutlength = length(xlstext) - length(xlsdata);
    xlswrite([filepath,'allreports','.xls'],...
        xlstext(cutlength+1:end),'sheet1','A2');
    imagename = strrep(xlstext{1,1},'Image File: ','');
    xlswrite([filepath,'allreports','.xls'],...
        cellstr(imagename(1:end-5)),'sheet1','B1')
    xlswrite([filepath,'allreports','.xls'],...
            xlsdata(:,N),'sheet1','B2');
    for xlscount = 2:length(files)
        filename = files(xlscount).name;
        [xlsdata,xlstext] = xlsread([filepath,filename]);
        imagename = strrep(xlstext{1,1},'Image File: ','');
        xlswrite([filepath,'allreports','.xls'],...
        cellstr(imagename(1:end-5)),'sheet1',[char(double('A'+xlscount)),'1'])
        xlswrite([filepath,'allreports','.xls'],...
            xlsdata(:,N),'sheet1',[char(double('A'+xlscount)),'2']);
    end
end
    
