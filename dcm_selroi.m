function ROIout = dcm_selroi(filepath,filename,roinum)
%  画出ROI的轮廓，得到ROI区域
%  没有病灶单击鼠标处理下一张图像，如果这个序列剩下图像都没有病灶，关闭图像处理下一个序列
%  每一个颜色可以对应多个病灶，画完一个roi，继续画表示是同一个类型的roi
%  画完一个类型roi，单击画下一个类型roi，没有roi单击退出
%  不同类型的roi用不同的颜色表示
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
                case 1 %显示为红色
                I2 = cat(3,ROIout_g,ROIout1(:,:,1),ROIout1(:,:,1));
                case 2 %显示为绿色
                I2 = cat(3,ROIout1(:,:,1),ROIout_g,ROIout1(:,:,1));
                case 3 %显示为蓝色
                I2 = cat(3,ROIout1(:,:,1),ROIout1(:,:,1),ROIout_g);
                case 4 %显示为黄色
                I2 = cat(3,ROIout_g,ROIout_g,ROIout1(:,:,1));
                case 5 %显示为浅蓝色
                I2 = cat(3,ROIout1(:,:,1),ROIout_g,ROIout_g);
                case 6 %显示为紫色
                I2 = cat(3,ROIout_g,ROIout1(:,:,1),ROIout_g);
            end
        end
            ROIout = ROIout + I2;        
    end
    if isempty(find(ROIout>0,1)) == 0
    imwrite(ROIout,[resultpath,'\',filename(1:end-4),'_roi.bmp'])
    end 
else
    disp('ROI最多为6个，请修改ROI数目')
end
    