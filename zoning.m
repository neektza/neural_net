function [ sums ] = zoning( img )
%ZONING 2 x 2 matrica sa sumama svakog kvadranta

sums = [0 0; 0 0];

sums(1,1) = sum(sum(~img(1:round(end/2), 1:round(end/2))));
sums(1,2) = sum(sum(~img(1:round(end/2), round(end/2)+1:end)));
sums(2,1) = sum(sum(~img(round(end/2)+1:end, 1:round(end/2))));
sums(2,2) = sum(sum(~img(round(end/2)+1:end, round(end/2)+1:end)));

end

