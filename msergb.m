function [SSD,MSE,PSNR] = msergb(a,b)
% Work out the size of the width and height of the input image
n = size(a,2);
m = size(a,1);
% Sum the difference of the input and output images squared and summed
% again to give a single value for the three channels
% MSE is cummalative error between 2 images
if (size(a,3)==3)
    P=[ reshape(a(:,:,1),1,[]) ; reshape(a(:,:,2),1,[]) ; reshape(a(:,:,3),1,[])];
    Q=[ reshape(b(:,:,1),1,[]) ; reshape(b(:,:,2),1,[]) ; reshape(b(:,:,3),1,[])];
    
    squared_diff = (P-Q).^2;
    SSD = sum(sum(squared_diff));
    MSE = (sum(sum(squared_diff))/(3*n*m))*100;
    
    % PSNR is measure of peak error
    PSNR = 10*log10(1/MSE);
else
    P=reshape(a(:,:),1,[]);
    Q=reshape(b(:,:,1),1,[]);
    
    squared_diff = (P-Q).^2;
    SSD = sum(sum(squared_diff));
    MSE = (sum(sum(squared_diff))/(n*m))*100;
    
    % PSNR is measure of peak error
    PSNR = 10*log10(1/MSE);
end
end