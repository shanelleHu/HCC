% function ProtocolCount = MoveDCM1( )
%   按DCM中的ProtocolName对图像进行分类
%   DCMpath 原始DCM路径;
%   Newpath 保存序列路径
DCMpath = [uigetdir('Please select the dir of original data'),'\']; 
Newpath = [uigetdir('Please select a dir to save the result'),'\'];
files = dir(DCMpath);
for PatientCount = 3:length(files)
    if files(PatientCount).isdir == 1
        PatientID = files(PatientCount).name(1:end-9);%病人ID后带有日期，去除后面的日期
        Patientpath = [DCMpath, files(PatientCount).name, '\'];
        NewPatientPath = [Newpath, PatientID,'\'];
        Patientfiles = dir([Patientpath, '*.dcm']);
        ProtocolCount = 0;
        for i = 1:length(Patientfiles)
            info=dicominfo([Patientpath, Patientfiles(i).name]);
            ProtocolName = info.ProtocolName;
            if exist([NewPatientPath, ProtocolName]) ~= 7
                mkdir([NewPatientPath, ProtocolName])
                ProtocolCount = ProtocolCount + 1;
            end
            Newname = strrep(Patientfiles(i).name,'FILE','');
            copyfile([Patientpath, Patientfiles(i).name],...
                [NewPatientPath, ProtocolName, '\', Newname])   
        end
    end
end

