function image_out_forward = forward_warp(image_in,H,W,CM,newW,newH)

% Check whether image is RGB or grayscale and then create the respective
% matrix
if size(image_in,3)==3          
    image_out_forward = zeros(newW,newH,3);
else
    image_out_forward = zeros(newW,newH);
end

% Create a for loop to loop through every pixel in the original image
for i = 1:W
    for j = 1:H
        % At point a, apply compound matrix, CM.
        a = [i;j;1];
        b = CM * a;
        % Make sure hypotenuse is 1 - normalise
        [xnew,ynew,xmin,ymin,xmax,ymax,xround,yround] = coordinates(b);
               
        % If the coordinate is in the boundary of the new image, set the
        % current pixel possition of the original image to the new transposed
        % position in the new image
        if (xround>0 && xround<=newW && yround>0 && yround<=newH)
            image_out_forward(yround,xround,:) = image_in(j,i,:);
        end
    end  
end