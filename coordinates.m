function [xnew,ynew,xmin,ymin,xmax,ymax,xround,yround] = coordinates(b)

xnew = b(1);
ynew = b(2);
xmin = floor(xnew/b(3));
ymin = floor(ynew/b(3));
xmax = ceil(xnew/b(3));
ymax = ceil(ynew/b(3));
xround = round(b(1)/b(3));
yround = round(b(2)/b(3));