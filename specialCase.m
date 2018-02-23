function [T,iof_4,iob_4,iobb_4,iobg_4] = specialCase(image_in,theta,scale,filter)

[CMR,HR,WR] = compoundMatrixR(image_in,theta);
[CMR,newHR,newWR] = processSetup(HR,WR,CMR);

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
else
    i_in = image_in;
end

iof_1 = forward_warp(i_in,HR,WR,CMR,newWR,newHR);

[CMS,HS,WS] = compoundMatrixS(iof_1,scale);
[CMS,newHS,newWS] = processSetup(HS,WS,CMS);

iof_2 = forward_warp(iof_1,HS,WS,CMS,newWS,newHS);
iof_3 = inverseForward(iof_2,HS,WS,newHS,newWS,CMS);
iof_4 = inverseForward(iof_3,HR,WR,HS,WS,CMR);

[iob_1,iobb_1,iobg_1] = backward_warp(i_in,HR,WR,CMR,newWR,newHR);

[iob_2,iobb_nul,iobg_nul] = backward_warp(iob_1,HS,WS,CMS,newWS,newHS);
[iob_nul2,iobb_2,iobg_null] = backward_warp(iobb_1,HS,WS,CMS,newWS,newHS);
[iob_nul3,iobb_null4,iobg_2] = backward_warp(iobg_1,HS,WS,CMS,newWS,newHS);


[iob_3,iobb_3,iobg_3] = inverseBackward(iob_2,iobb_2,HS,WS,newHS,newWS,CMS,iobg_2);
[iob_4,iobb_4,iobg_4] = inverseBackward(iob_3,iobb_3,HR,WR,HS,WS,CMR,iobg_3);

fprintf('\nShowing the forward warp rotation\n');
imgshow(iof_1);
title('Forward Map Warp Rotation')
pause;

fprintf('\nShowing the forward warp scale\n');
imgshow(iof_2)
title('Forward Map Scale')
pause;

fprintf('\nShowing the inverse forward warp\n');
imgshow(iof_4)
title('Forward Map')
pause;

fprintf('\nShowing the backward warp rotation Nearest Neighbour\n');
imgshow(iob_1);
title('Backward Map Warp Rotation Nearest Neighbour')
pause;

fprintf('\nShowing the backward warp scale Nearest Neighbour\n');
imgshow(iob_2)
title('Backward Map Scale Nearest Neighbour')
pause;

fprintf('\nShowing the backward forward warp Nearest Neighbour\n');
imgshow(iob_4)
title('Backward Map Nearest Neighbour')
pause;

fprintf('\nShowing the backward bi-linear warp rotation\n');
imgshow(iobb_1);
title('Backward Map Warp Rotation Bilinear')
pause;

fprintf('\nShowing the backward bi-linear warp scale\n');
imgshow(iobb_2)
title('Backward Map Scale Bilinear')
pause;

fprintf('\nShowing the backward bi-linear forward warp\n');
imgshow(iobb_4)
title('Backward Map Bilinear')
pause;

fprintf('\nShowing the backward gaussian warp rotation\n');
imgshow(iobg_1);
title('Backward Map Gaussian Rotation')
pause;

fprintf('\nShowing the backward gaussian warp scale\n');
imgshow(iobg_2)
title('Backward Map Gaussian Scale')
pause;

fprintf('\nShowing the backward gaussian forward warp\n');
imgshow(iobg_4)
title('Backward Map Gaussian')
pause;

[SSD_f,MSE_Forward,PSNR_Forward] = msergb(iof_4,i_in);
[SSD_b,MSE_Backward,PSNR_Backward] = msergb(iob_4,i_in);
[SSD_bb,MSE_Backward_bilinear,PSNR_Backward_bilinear] = msergb(iobb_4,image_in);
[SSD_g,MSE_g,PSNR_g] = msergb(iobg_4,image_in);

SSD = [SSD_f;SSD_b;SSD_bb;SSD_g];
MSE = [MSE_Forward;MSE_Backward;MSE_Backward_bilinear;MSE_g];
PSNR = [PSNR_Forward;PSNR_Backward;PSNR_Backward_bilinear;PSNR_g];
Names = {'SSD','MSE','PSNR','Info'};
Title = {'Forward Mapping';'Backward Mapping Nearest Neighbour';'Backward Mapping Bi-Linear';'Backward Mapping Gaussian'};

T = table(SSD,MSE,PSNR,Title,'VariableNames',Names,'RowNames',{'1','2','3','4'});
close all

subplot(3,2,1), imshow(image_in), title('Original Image')
if(filter == 1)
    subplot(3,2,2), imshow(i_in), title('Filtered Image')
end
subplot(3,2,3), imshow(iof_4), title('Forward Warp')
subplot(3,2,4), imshow(iob_4), title('Backward Warp Nearest Neighbour')
subplot(3,2,5), imshow(iobb_4), title('Backward Warp Bi-Linear')
subplot(3,2,6), imshow(iobg_4), title('Backward Warp Gaussian')

pause;