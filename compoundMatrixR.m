function [CMR,H,W] = compoundMatrixR(image_in,theta)

H = size(image_in,1);
W = size(image_in,2);

R = [cos(theta),-sin(theta),0;...
    sin(theta),cos(theta),0;...
    0,0,1];

T = [1,0,-W/2;...
    0,1,-H/2;...
    0,0,1];

CMR = T\R*T;