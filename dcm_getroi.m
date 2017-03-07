% 选取文件夹，对文件夹里的DCM文件进行灰度、二值化处理，得到ROI
% 关闭
clc;clear all;close all
% [filename,filepath]=uigetfile('*.*','Please select a file');%单独打开某个文件 
filetype = '*.dcm';
filepath = uigetdir('Please select a dir');%选择某个文件夹
if filepath == 0
    disp('No dir selected')
    [filename,filepath]=uigetfile(filetype,'Please select a dcm file');
    if filepath == 0
        disp('No file selected')
    else
        cd(filepath)
        try
            rois = dcm_selroi(filepath,filename,2);   
            catch err
                if strcmpi(err.identifier, 'MATLAB:minrhs')
                    disp('Finished manually')
                end
        end
    end
else
    cd(filepath)
    filepath = [filepath, '\'];
    files = dir([filepath,filetype]);
    for imagec = 1:length(files)
        filename = files(imagec).name;
    %     ROI = autoDCMROI(filepath,filename,2);
        try
            rois = dcm_selroi(filepath,filename,2);   
            catch err
                if strcmpi(err.identifier, 'MATLAB:minrhs')
                    disp('Finished manually')
                    break
                else
                    continue
                end
        end
    end
end