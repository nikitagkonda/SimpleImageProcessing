function [Im,Io,Ix,Iy]=myEdgeFilter(img,sigma)
if mod(3*sigma,2)==0
    x=3*sigma +1;
else
    x=3*sigma;
end
k=fspecial('gaussian',[x x],sigma);
img_gaussian= myImageFilter(img,k);
[r,c]=size(img_gaussian);
Gx=[-1 0 1;-2 0 2;-1 0 1];
Gy=[1 2 1;0 0 0;-1 -2 -1];
Ix=myImageFilter(img_gaussian,Gx);
Iy=myImageFilter(img_gaussian,Gy);
Im=zeros(r,c);
Io=zeros(r,c);
for i=1:r
    for j=1:c
        Im(i,j)=sqrt(power(Ix(i,j),2)+power(Iy(i,j),2));
        Io(i,j)=atan(Iy(i,j)/Ix(i,j));
    end
end
Im=uint8(Im);
for i=2:r-1
    for j=2:c-1
        if Io(i-1,j-1)<=-0.3926991 && Io(i-1,j-1)>=-1.178097 && Io(i+1,j+1)<=-0.3926991 && Io(i+1,j+1)>=-1.178097
            if Im(i-1,j-1)>Im(i,j) || Im(i+1,j+1)>Im(i,j)
                Im(i,j)=0;
            end
        elseif Io(i-1,j) >= 1.178097 && Io(i-1,j) <= 1.5708 && Io(i+1,j)>=1.178097 && Io(i+1,j)<=1.5708
            if Im(i-1,j)>Im(i,j) || Im(i+1,j)>Im(i,j)
                Im(i,j)=0;
            end 
        elseif Io(i-1,j+1)>=0.3926991 && Io(i-1,j+1)<=1.178097 && Io(i+1,j-1)>=0.3926991 && Io(i+1,j-1)<=1.178097
            if Im(i-1,j+1)>Im(i,j) || Im(i+1,j-1)>Im(i,j)
                Im(i,j)=0;
           end 
        elseif Io(i,j-1) >= -0.3926991 && Io(i,j-1) <= 0.3926991 && Io(i,j+1)>= -0.3926991 && Io(i,j+1)<= 0.3926991
            if Im(i,j-1)>Im(i,j) || Im(i,j+1)>Im(i,j)
                Im(i,j)=0;
            end 
        end
    end
end

            