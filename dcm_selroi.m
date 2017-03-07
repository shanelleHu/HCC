function ROIout = dcm_selroi(filepath,filename,roinum)
%  ����ROI���������õ�ROI����
%  û�в������괦����һ��ͼ������������ʣ��ͼ��û�в���ر�ͼ������һ������
%  ÿһ����ɫ���Զ�Ӧ����������һ��roi����������ʾ��ͬһ�����͵�roi
%  ����һ������roi����������һ������roi��û��roi�����˳�
%  ��ͬ���͵�roi�ò�ͬ����ɫ��ʾ
if nargin ~= 3
    roinum = 1;
end

if roinum <=6
    rois = 0;
    resultpath = [filepath,'rois'];
    if exist(resultpath) ~= 7
        mkdir(resultpath)
    end
    info = dicominfo([filepath,filename]);
    DCMimage = dicomread(info);
    imshow(DCMimage,[]),title(filename(1:end-4))   
    ROIout = uint8(zeros([size(DCMimage),3]));
    for roicount = roinum:6          
        set(gcf,'Position',get(0,'ScreenSize'))
        roiedges = imfreehand;
        roi = createMask(roiedges);
        if isempty(find(roi==1, 1)) == 1
            break
        else
            rois = rois + 1;
            ROIout1 = uint8(zeros([size(DCMimage),3]));
            ROIout_g = ROIout1(:,:,1);
            ROIout_g(roi==1) = 255;
            for k = 1:20
                roiedges = imfreehand;
                roi = createMask(roiedges);
                if isempty(find(roi==1, 1)) == 1
                    break
                else
                    ROIout_g(roi==1) = 255;
                end
            end
            switch roicount
                case 1 %��ʾΪ��ɫ
                I2 = cat(3,ROIout_g,ROIout1(:,:,1),ROIout1(:,:,1));
                case 2 %��ʾΪ��ɫ
                I2 = cat(3,ROIout1(:,:,1),ROIout_g,ROIout1(:,:,1));
                case 3 %��ʾΪ��ɫ
                I2 = cat(3,ROIout1(:,:,1),ROIout1(:,:,1),ROIout_g);
                case 4 %��ʾΪ��ɫ
                I2 = cat(3,ROIout_g,ROIout_g,ROIout1(:,:,1));
                case 5 %��ʾΪǳ��ɫ
                I2 = cat(3,ROIout1(:,:,1),ROIout_g,ROIout_g);
                case 6 %��ʾΪ��ɫ
                I2 = cat(3,ROIout_g,ROIout1(:,:,1),ROIout_g);
            end
        end
            ROIout = ROIout + I2;        
    end
    if isempty(find(ROIout>0,1)) == 0
    imwrite(ROIout,[resultpath,'\',filename(1:end-4),'_roi.bmp'])
    end 
else
    disp('ROI���Ϊ6�������޸�ROI��Ŀ')
end
    