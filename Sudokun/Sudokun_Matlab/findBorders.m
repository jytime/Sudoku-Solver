
function endpoints = findBorders(lines)
%input: all solid lines found from Hough transform
%output: four outer-most borders named as 'endpoints'
%This funtion is to find the outer-most four borders from all lines
%detected from Hought transform
%The general idea is: With twenty gridlines recorded in coordinates, we classify them into two groups, 
% namely horizontal and vertical lines. The grouping is done based on their polar angles: 
% the polar angles of the lines in the same group are quite close. By doing so, we eliminate the influence
% of unitary rotation. Then we identify and extract the outer borders by finding two lines in each group 
%that are the closest and the furthest to the origin.
%%
theta_extracted = abs(extractfield(lines,'theta')); 
%give absolute value to all the theta(angle) extracted in polar coordinates
pho_extracted = abs(extractfield(lines,'rho'));
%give absolute value to all the pho (length) extracted in polar coordinates

threshold = (max(theta_extracted)+ min(theta_extracted))/2; %define a threshold for comparison
%[~, ind_sorted] = sort(theta_extracted);
% ind_1 = ind_sorted(1:4);
% ind_2 = ind_sorted(5:8);
ind_1 = find(theta_extracted <= threshold); %divide two groups based on threshold
ind_2 = find(theta_extracted > threshold);

rho_val_1 = pho_extracted(ind_1);
rho_val_2 = pho_extracted(ind_2);
%find four lines based on the rho value
[~,ind_max_2] = max(rho_val_2);
[~,ind_min_2] = min(rho_val_2);
[~,ind_max_1] = max(rho_val_1);
[~,ind_min_1] = min(rho_val_1);

%extract four outer-most lines. Note that there is a conversion between
%polar and cartesian coordinates.
top_line = [lines(ind_2(ind_min_2)).point1,lines(ind_2(ind_min_2)).point2];
bottom_line = [lines(ind_2(ind_max_2)).point1,lines(ind_2(ind_max_2)).point2];
left_line = [lines(ind_1(ind_min_1)).point1,lines(ind_1(ind_min_1)).point2];
right_line = [lines(ind_1(ind_max_1)).point1,lines(ind_1(ind_max_1)).point2];

endpoints = [top_line;bottom_line;left_line;right_line]; %stack as a matrix called endpoints
end