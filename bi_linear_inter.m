function G = bi_linear_inter(image_in,xmin,ymin,xmax,ymax,xnew,ynew)
    
if (size(image_in,3) == 3)
    colA = image_in(ymin,xmin,:);
    colB = image_in(ymax,xmin,:);
    colC = image_in(ymin,xmax,:);
    colD = image_in(ymax,xmax,:);
else    
    colA = image_in(ymin,xmin);
    colB = image_in(ymax,xmin);
    colC = image_in(ymin,xmax);
    colD = image_in(ymax,xmax);
end
    uppery = ymax - ynew;
    lowery = 1 - uppery;
    upperx = xmax - xnew;
    lowerx = 1 - upperx;
    % We are taking it from E and F's point of view. Therefore, if the
    % pixel is positioned closer to C then, C will have the greater
    % influence
    E = uppery*colA + lowery*colC;
    F = uppery*colB + lowery*colD;
    
    G = (lowerx)*F + (upperx)*E;
end