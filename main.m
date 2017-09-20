function main()
clear;clc;
for i=1:5
    s = num2str(i);
    filename=strcat('img0',s,'.jpg');
    img=imread(filename);
    if size(img,3)==3
        img = rgb2gray(img);
    end

    %myEdgeFilter
    sigma=1;
    [Im,Io,Ix,Iy]=myEdgeFilter(img,sigma);
%     figure;
%     imshow(Im);
%     time = clock;
%     new_filename=strcat('EdgeFilter',num2str(time(1)),num2str(time(2)),num2str(time(3)),num2str(time(4)),num2str(time(5)), num2str(time(6)),'.jpg');
%     saveas(gcf,new_filename);
    
    %myHarrisCorner
    threshold=30000000;
    [R] = myHarrisCorner(Ix,Iy,threshold);
    [r,c]=size(img);
    figure;
    imshow(img);
    for j=1:r
        for k=1:c
             if R(j,k)==1
                 hold on;
                 plot(k,j,'ro','MarkerSize',2);
             end
        end
    end
    time = clock;
    new_filename=strcat('HarrisCorner',num2str(time(1)),num2str(time(2)),num2str(time(3)),num2str(time(4)),num2str(time(5)), num2str(time(6)),'.jpg');
    saveas(gcf,new_filename);
end