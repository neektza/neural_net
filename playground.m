close all;
clearvars;

path(path,'~/faks/neumre/projekt/slova')

d = dir('~/faks/neumre/projekt/slova');

img = imread('B6.bmp');

imshow(img)

%% regionprops - centroid
% 
% rp  = regionprops(~img, 'centroid');
% x = round(rp.Centroid(1));
% y = round(rp.Centroid(2));
% 
% dx = round(size(img,1)/2) - round(x);
% dy = round(size(img,2)/2) - round(y);

% imshow(img)
% hold on
% plot(x, y, 'b*')
% hold off

%% regionprops - image

% rp  = regionprops(~img, 'image');
% img2 = rp.Image;

% imshow(img2);


%% centriranje
cimg = center(img);

%% stanjivanje slova ?? staviti ili ne?
skel = bwmorph(~cimg,'thin', 10);
figure, imshow(~skel);

%% histogrami
[x, y] = hists(cimg);

%% zoning
sums = zoning(cimg);


