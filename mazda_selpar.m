% ���ձ�Ƕ�mazda�������
parpath = [uigetdir('Please select a dir'),'\'];%ѡ��ĳ���������ļ���
parfiles = dir([parpath,'*par']);
pospath = [parpath,'positive\']; %��Ÿ����ı���
negpath = [parpath,'negative\']; %���δ�����ı���
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
IDsel = xlsread('F:\��Ŀ\HCC\������\IDsel.xls','IDinall');
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
        
        