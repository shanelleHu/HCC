% function DCM2JPG(filepath)
% 将DCM批量转化为图片
filepath = 'D:\项目\HCC\data\';
files = dir(filepath);
for PatientCount = 3:length(files)
    if files(PatientCount).isdir == 1
        subfilespath = ['D:\项目\HCC\data\', files(PatientCount).name, '\'];
        subfiles = dir(subfilespath);
        for ProtocolCount = 3:length(subfiles)
            if subfiles(ProtocolCount).isdir == 1
                DCMdatapath = [subfilespath, subfiles(ProtocolCount).name, '\'];
                DCMdatafiles = dir([DCMdatapath, '*.DCM']);
                DCMimagepath = [DCMdatapath,'image\'];
                if exist(DCMimagepath) ~= 7
                    mkdir(DCMimagepath);
                end
                for DCMcount = 1:length(DCMdatafiles)
                    info = dicominfo([DCMdatapath, DCMdatafiles(DCMcount).name]);
                    DCMimage = dicomread(info);
                    set(gcf,'Units','centimeters','Position',[10 10 8.48 5.82]);
                    imshow(DCMimage,[],'border','tight','InitialMagnification','fit')
                    saveas(gcf,[DCMimagepath,DCMdatafiles(DCMcount).name(1:end-4),'.bmp'])
                end
            end
        end
    end
end
                    
                    
                    
                    
        