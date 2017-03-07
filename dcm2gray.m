
% imagepath = uigetdir('Please select a dir');%选择某个文件夹
[imagename,imagepath]=uigetfile('*.dcm','Please select a dcm file');
resultpath = [imagepath,'bwresult'];
if exist(resultpath) ~= 7
    mkdir(resultpath)
end
% files = dir([imagepath,'*dcm']);
% for imagec = 1:length(files)
%     imagename = files(imagec).name;
    info = dicominfo([imagepath,imagename]);
    DCMimage = dicomread(info);
    k = double(max(max(DCMimage)))/255;
    I = uint8(zeros([size(DCMimage),3]));
    I(:,:,1)=DCMimage/k;I(:,:,2)=DCMimage/k;I(:,:,3)=DCMimage/k;
    grayimage = rgb2gray(I);
    bwimage = im2bw(grayimage);
    edges = edge(grayimage,'Canny');
    se1 = strel('line',100,0);
    se2 = strel('line',100,90);
    diedges = imdilate(edges,se1);
    diedges = imdilate(diedges,se2);
    subplot(221),imshow(I)
    subplot(222),imshow(grayimage)
    subplot(223),imshow(bwimage)
    subplot(224),imshow(edges)
%     saveas(gcf,[resultpath,'\',imagename(1:end-4),'.jpg']);
% end