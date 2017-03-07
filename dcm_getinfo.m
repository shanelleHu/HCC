% 提取DCM中的有用信息
clc;clear all
DCMpath = uigetdir('Please select the dir of original data'); 
if DCMpath == 0
    DCMpath = 'H:\HCC\201612';    
end
DCMpath = [DCMpath,'\'];
Newpath = uigetdir('Please select a dir to save the result');
if Newpath == 0
    Newpath = 'F:\项目\HCC\data\reports';
end
Newpath = [Newpath,'\'];
files = dir(DCMpath);
fileinfo = {'PatientID','PatientAge','PatientWeight','PatientSex'};
xlswrite([Newpath,'patientinfo.xls'],fileinfo,'sheet1','A1')
for PatientCount = 3:length(files)
    if files(PatientCount).isdir == 1
        PatientID = files(PatientCount).name(1:end-9);%病人ID后带有日期，去除后面的日期
        Patientpath = [DCMpath, files(PatientCount).name, '\'];
        Patientfiles = dir([Patientpath, '*.dcm']);
        info=dicominfo([Patientpath, Patientfiles(100).name]);
        PatientAge = info.PatientAge;
        PatientWeight = info.PatientWeight;
        PatientSex = info.PatientSex;
        xlswrite([Newpath,'patientinfo.xls'],...
        cellstr(PatientID),'sheet1',['A',num2str(PatientCount-1)])
        xlswrite([Newpath,'patientinfo.xls'],...
        cellstr(PatientAge),'sheet1',['B',num2str(PatientCount-1)])
        xlswrite([Newpath,'patientinfo.xls'],...
        PatientWeight,'sheet1',['C',num2str(PatientCount-1)])
        xlswrite([Newpath,'patientinfo.xls'],...
        cellstr(PatientSex),'sheet1',['D',num2str(PatientCount-1)])
    end
end
