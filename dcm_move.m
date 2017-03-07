function ProtocolCount = MoveDCM()
%   按DCM中的ProtocolName对图像进行分类
DCMpath = uigetdir('Please select a dir'); 
files = dir([DCMpath,'\', '*.dcm']);
ProtocolCount = 0;
for i = 1:length(files)
    DCMname = [DCMpath, files(i).name];
    info=dicominfo(DCMname);
    ProtocolName = info.ProtocolName;
    NewPath = [DCMpath, ProtocolName];
    if exist(NewPath) ~= 7
        mkdir(NewPath)
        ProtocolCount = ProtocolCount + 1;
    end
    copyfile(DCMname, [NewPath, '\', files(i).name])   
end

