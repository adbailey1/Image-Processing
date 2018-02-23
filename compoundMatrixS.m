function [CMS,H,W] = compoundMatrixS(image_in,a)

H = size(image_in,1);
W = size(image_in,2);

S = [a,0,0;...
    0,a,0;...
    0,0,1];

T = [1,0,-W/2;...
    0,1,-H/2;...
    0,0,1];

CMS = T\S*T;