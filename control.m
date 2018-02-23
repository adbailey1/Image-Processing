function [T,image_out_forward_quality,image_out_backward_quality,...
    image_out_backward_quality_bilinear,io_gaussian_q] = control(image_in,theta,scale,filter)
if ((theta==0 || rem(theta,2*pi)==0) && (scale<1 || scale>1))
    [CM,H,W] = compoundMatrixS(image_in,scale);
elseif (((theta~=0 || rem(theta,2*pi)~=0) && scale==1) || (theta==0 && scale ==1))
    [CM,H,W] = compoundMatrixR(image_in,theta);
elseif ((theta~=0 || rem(theta,2*pi)~=0) && (scale<1 || scale>1))
    [T,image_out_forward_quality,image_out_backward_quality,...
        image_out_backward_quality_bilinear,io_gaussian_q] = specialCase(image_in,theta,scale,filter);
    return
end

[CM,newH,newW] = processSetup(H,W,CM);

fprintf('\nShowing the original image\n')
imgshow(image_in)
title('Original Image')
pause(0.01);

if (filter > 0)
    fprintf('\nFilters take a while to load, please allow up to 2 minutes\n')
    if (filter == 1)
        i_in = MAFilter(image_in);
        fprintf('\nShowing the mean average filter (low pass filter)\n')
    elseif (filter ==2)
        i_in = MedianFilter(image_in);
        fprintf('\nShowing the median filter\n')
    end
elseif (filter==0)
    i_in = image_in;
end

image_out_forward = forward_warp(i_in,H,W,CM,newW,newH);
image_out_forward_quality = inverseForward(image_out_forward,H,W,newH,newW,CM);
[SSD_f,MSE_Forward,PSNR_Forward] = msergb(image_out_forward_quality,i_in);

[image_out_backward,image_out_backward_bilinear,io_gaussian] = backward_warp(i_in,H,W,CM,newW,newH);
[image_out_backward_quality,image_out_backward_quality_bilinear,...
    io_gaussian_q] = inverseBackward(image_out_backward,image_out_backward_bilinear,...
    H,W,newH,newW,CM,io_gaussian);
[SSD_b,MSE_Backward,PSNR_Backward] = msergb(image_out_backward_quality,i_in);
[SSD_bb,MSE_Backward_bilinear,PSNR_Backward_bilinear] = msergb(image_out_backward_quality_bilinear,...
    image_in);
[SSD_g,MSE_g,PSNR_g] = msergb(io_gaussian_q,image_in);

fprintf('\nShowing the forward warp\n');
imgshow(image_out_forward);
title('Forward Map Warp')
pause;

fprintf('\nShowing the inverse forward warp\n');
imgshow(image_out_forward_quality)
title('Forward Map')
pause;

fprintf('\nShowing the backward warp\n')
imgshow(image_out_backward)
title('Backward Map Warp Nearest Neighbour')
pause;

fprintf('\nShowing the inverse backward warp\n')
imgshow(image_out_backward_quality)
title('Backward Map Nearest Neighbour')
pause;

fprintf('\nShowing the backward mapping using bi-linear interpolation\n')
imgshow(image_out_backward_bilinear)
title('Backward Map Warp Bi-Linear')
pause;

fprintf('\nShowing the inverse backward warp using bi-linear interpolation\n')
imgshow(image_out_backward_quality_bilinear)
title('Backward Map Bi-Linear')
pause;

fprintf('\nShowing the backward mapping using gaussian interpolation\n')
imgshow(io_gaussian)
title('Backward Map Warp Gaussian')
pause;

fprintf('\nShowing the inverse backward warp using gaussian interpolation\n')
imgshow(io_gaussian_q)
title('Backward Map Gaussian Quality')
pause;

SSD = [SSD_f;SSD_b;SSD_bb;SSD_g];
MSE = [MSE_Forward;MSE_Backward;MSE_Backward_bilinear;MSE_g];
PSNR = [PSNR_Forward;PSNR_Backward;PSNR_Backward_bilinear;PSNR_g];
Names = {'SSD','MSE','PSNR','Info'};
Title = {'Forward Mapping';'Backward Mapping Nearest Neighbour';'Backward Mapping Bi-Linear';...
    'Backward Mapping Gaussian'};

T = table(SSD,MSE,PSNR,Title,'VariableNames',Names,'RowNames',{'1','2','3','4'});
close all

subplot(3,2,1), imshow(image_in), title('Original Image')
if(filter == 1)
    subplot(3,2,2), imshow(i_in), title('Filtered Image')
end
subplot(3,2,3), imshow(image_out_forward_quality), title('Forward Warp')
subplot(3,2,4), imshow(image_out_backward_quality), title('Backward Warp')
subplot(3,2,5), imshow(image_out_backward_quality_bilinear), title('Backward Warp Bi-Linear')
subplot(3,2,6), imshow(io_gaussian_q), title('Backward Warp Gaussian')

pause;
close all;