function [image_out_backward,image_out_backward_bilinear,io_gaussian] = backward_warp(image_in,H,W,CM,newW,newH)

%check whether image is RGB or grayscale
if size(image_in,3)==3          
    image_out_backward = zeros(newW,newH,3);
    image_out_backward_bilinear = zeros(newW,newH,3);
    io_gaussian = zeros(newW,newH,3);
else
    image_out_backward = zeros(newW,newH);
    image_out_backward_bilinear = zeros(newW,newH);
    io_gaussian = zeros(newW,newH);
end

for i = 1:newW
    for j = 1:newH
        b = [i;j;1];
        a = CM\b;
        
        % Round up and down to build a virtual square for use with
        % bi-linear interpolation. The rounded down values are used for
        % nearest neighbour         
        [xnew,ynew,xmin,ymin,xmax,ymax,xround,yround] = coordinates(a);
               
        if (xmin>0 && xmin<=W && ymin>0 && ymin<=H)
            image_out_backward(j,i,:) = image_in(ymin,xmin,:);
        end
        
        if (xmin>0 && xmax<=W && ymin>0 && ymax<=H)
            G = bi_linear_inter(image_in,xmin,ymin,xmax,ymax,xnew,ynew);
            Gau = gaussian(image_in,xround,yround,xnew,ynew);
            if (size(image_in,3) == 3)
                for k=1:3
                    image_out_backward_bilinear(j,i,k) = G(k);
                    io_gaussian(j,i,k) = Gau(k);
                end
            else
                image_out_backward_bilinear(j,i) = G;
                io_gaussian(j,i) = Gau;
            end
        end
    end
end