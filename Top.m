close all;
clear all;

% Select the values for the corresponding program. Picture selection is as
% follows;
% 1 = Surrey
% 2 = Checkered Pattern (Black and White)
% WARNING filters will take a while to load due to the large amount of 
% calculation.
% Filter options are displayed below
% 0 = No filter
% 1 = Moving Average Filter
% 2 = Median Filter
theta = [pi/4];
scale = [1];
filter = [0];

image_in = imageSelec(1);

for j=1:size(theta)
    
    fprintf('\nNow showing forward and backward mapping using nearest neighbour followed by Bi-Linear\n')
    fprintf('\nSome of these functions will take a while to load, especially when applying filters\n')
    fprintf('\nThe scale, rotation and filter settings are chosen below by the user\n')
    fprintf('\nValue of theta = %.2f, Scale factor = %.2f and filter value = %i\n',theta(j),scale(j),filter(j))
    [T,image_out_forward_quality,image_out_backward_quality,image_out_backward_quality_bilinear,io_gaussian_q] = control(image_in,theta(j),scale(j),filter(j));
    
    disp(T)
    
    close all;
end