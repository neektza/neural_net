function [ centered_img ] = center( img )
%CENTER vraca centriranu sliku (slovo u sredini)

rp  = regionprops(~img, 'centroid');
x = round(rp.Centroid(1));
y = round(rp.Centroid(2));

dx = round(size(img,1)/2) - round(x);
dy = round(size(img,2)/2) - round(y);

se = translate(strel(1),[dy dx]);
cimg = imdilate(~img,se);

centered_img = ~cimg;

end

