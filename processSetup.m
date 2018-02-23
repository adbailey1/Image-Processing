function [CM,newH,newW] = processSetup(H,W,CM)

% Calculate the corners of the image 
% corners = [W;H;1]
corners = [0, W, 0, W;0, 0, H, H;1,1,1,1];

% Calculate the minimun x and y cordinates of the warped image
CMCorners = CM*corners;
minx = min(CMCorners(1,:));
miny = min(CMCorners(2,:));
maxx = max(CMCorners(1,:));
maxy = max(CMCorners(2,:));

% Calculate the transpose to be applied 
T = [1,0,-minx;...
    0,1,-miny;...
    0,0,1];

CM = T*CM;

% Calculate the new width and height of the image. +1 for boundary correction
newW = round(maxx-minx+1);
newH = round(maxy-miny+1);

end