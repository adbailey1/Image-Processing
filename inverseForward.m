function image_out_forward_quality = inverseForward(image_out_forward,H,W,newH,newW,CM)

% Check whether image is RGB or grayscale and then create the respective
% matrix
if size(image_out_forward,3)==3          
    image_out_forward_quality = zeros(W,H,3);
else
    image_out_forward_quality = zeros(W,H);
end

% Create a loop to loop through every pixel in the new image
for i = 1:newW
    for j = 1:newH
        % At some point a, apply the inverse compound matrix to return to
        % the original startin position
        a = [i;j;1];
        b = CM\a;
        
        [xnew,ynew,xmin,ymin,xmax,ymax,xround,yround] = coordinates(b);
        
        if (xround>0 && xround<=W && yround>0 && yround<=H)
            image_out_forward_quality(yround,xround,:) = image_out_forward(j,i,:);
        end
    end
end