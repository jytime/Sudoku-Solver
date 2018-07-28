function lines = findEdges(image_bw)
% input:  a binary image of intereted region
% output: 20 solid lines expressed in polar and cartesian coordinates.
% This function is to detect the gridlines by finding peaks in the parameter
% space. The peaks in the function indicate the potential straight lines with
% the most dots on them.

%% parameter setting
max_gap = 400;
min_length = 100;

%% Apply Hough transformation
[H,theta,rho] = hough(image_bw);

%% Find Hough peaks
peaks = houghpeaks(H,20,'threshold',ceil(0.4*max(H(:))));
lines = houghlines(image_bw,theta,rho,peaks,'FillGap',max_gap,'MinLength',min_length);
end

