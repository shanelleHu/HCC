% 按照标记对mazda报告分类
parpath = [uigetdir('Please select a dir'),'\'];%选择某个报告存放文件夹
parfiles = dir([parpath,'*par']);
pospath = [parpath,'positive\']; %存放复发的报告
negpath = [parpath,'negative\']; %存放未复发的报告
resultpath = [parpath,'undecided\'];
if exist(negpath) ~= 7
    mkdir(negpath)
end
if exist(pospath) ~= 7
    mkdir(pospath)
end
if exist(resultpath) ~= 7
    mkdir(resultpath)
end
IDsel = xlsread('F:\项目\HCC\按序列\IDsel.xls','IDinall');
for parcount = 1:length(parfiles)
    ID = str2num(parfiles(parcount).name(1:end-4));
    parfile = [parpath,parfiles(parcount).name];
    resultpath = [parpath,'undecided\'];
    if IDsel(find(IDsel(:,1)==ID),2) == 1
        resultpath = pospath;
    elseif IDsel(find(IDsel(:,1)==ID),2) == 0
        resultpath = negpath;   
    end
    copyfile(parfile,[resultpath,parfiles(parcount).name])
end
        
        