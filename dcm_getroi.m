% ѡȡ�ļ��У����ļ������DCM�ļ����лҶȡ���ֵ�������õ�ROI
% �ر�
clc;clear all;close all
% [filename,filepath]=uigetfile('*.*','Please select a file');%������ĳ���ļ� 
filetype = '*.dcm';
filepath = uigetdir('Please select a dir');%ѡ��ĳ���ļ���
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