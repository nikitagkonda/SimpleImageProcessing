function img1=myImageFilter(img0,h)
if size(img0,3)==3
img0 = rgb2gray(img0);
end
img0=double(img0);
[r,c]= size(img0);
h = rot90(h,2);
[m,n]=size(h);
img0_pad = padarray(img0,[(m-1)/2 (n-1)/2],'replicate');
img1=zeros(r,c);
for i = 1 : r
for j = 1 : c
for p = 1 : m
for q = 1 : n
img1(i, j) = img1(i, j) + (img0_pad(p + (i-1), q + (j-1)) * h(p, q));
end
end
end
end
%img1=uint8(img1);