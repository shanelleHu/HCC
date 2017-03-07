
function rois = dcm_autoROI(filepath,filename,selcolor)
% % 选取DCM文件，得到指定位置的ROI
% %selcolor为选取的ROI标记的颜色，1为红色，2为绿色，3为蓝色

if nargin == 0
    [filename,filepath]=uigetfile('*.*','Please select a file');%单独打开某个文件
    cd(filepath);
end
if nargin ~=3
    selcolor = 1;
end
rois = 0;
if filename ~= 0    
    resultpath = [filepath,'rois'];
    if exist(resultpath) ~= 7
        mkdir(resultpath)
    end
    info = dicominfo([filepath,filename]);
    DCMimage = dicomread(info);
    k = double(max(max(DCMimage)))/255;
    I = uint8(zeros([size(DCMimage),3]));
    I(:,:,1)=DCMimage/k;I(:,:,2)=DCMimage/k;I(:,:,3)=DCMimage/k;
    grayimage = rgb2gray(I);
    H = fspecial('disk',1);
    blurimage = imfilter(grayimage,H,'replicate');
    edges = edge(blurimage,'canny');
    bwimage = im2bw(blurimage);  
    imshow(bwimage),title(filename(1:end-4))   
    [x,y]=ginput;
    if isempty(x) == 1
        imshow(edges),title(filename(1:end-4))
%        imshow(bwimage)
       [x,y]=ginput;
       if isempty(x) == 0
           edges = ~edges;
           labelimage = bwlabel(edges,4);
       else
           disp('No file selected')
       end
    else
        bwimage = ~bwimage;
        labelimage = bwlabel(bwimage,4);
    end
    if isempty(x) == 0
        ROIout = uint8(zeros([size(DCMimage),3]));
        ROIout_g = ROIout(:,:,selcolor);
        for roicount = 1:length(x)
            y1 = uint32(y(roicount));
            x1 = uint32(x(roicount));
            k = labelimage(y1,x1);
            ROIout_g(labelimage==k)=255;
        end
        switch selcolor
            case 1 %显示为红色
            I2 = cat(3,ROIout_g,ROIout(:,:,1),ROIout(:,:,3));
            case 2 %显示为绿色
            I2 = cat(3,ROIout(:,:,1),ROIout_g,ROIout(:,:,3));
            case 3 %显示为蓝色
            I2 = cat(3,ROIout(:,:,1),ROIout(:,:,2),ROIout_g);
        end
        imwrite(I2,[resultpath,'\',filename(1:end-4),'_roi.bmp'])
        rois = 1;
    else
        disp('No roi selected')
    end

end
