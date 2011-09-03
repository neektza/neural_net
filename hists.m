function [ x, y ] = hists( img )
%XY_HIST suma pixela po x i y osima

x = sum(~img, 1); % suma po kolumnama
y = sum(~img, 2); % suma po redovima

end

