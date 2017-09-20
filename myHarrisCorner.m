function [R] = myHarrisCorner(Ix,Iy,threshold)
k=0.04;
[r,c]=size(Ix);
R=zeros(r,c);
h=fspecial('gaussian',[3 3],0.6);
Ix2=Ix.^2;
Iy2=Iy.^2;
Ixy=Ix.*Iy;
Ix2=myImageFilter(Ix2,h);
Iy2=myImageFilter(Iy2,h);
Ixy=myImageFilter(Ixy,h);
for i=1:r
    for j=1:c
        M=[Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
        R(i,j)=det(M)-k*(power(trace(M),2));
            if R(i,j)>=threshold
                R(i,j)=1;
            else
                R(i,j)=0;
            end
    end
end