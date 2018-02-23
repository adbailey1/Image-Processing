function [image_out_backward_quality,image_out_backward_quality_bilinear,io_gaussian_q] = inverseBackward(image_out_backward,image_out_backward_bilinear,H,W,newH,newW,CM,io_gaussian)

if (size(image_out_backward,3) == 3)
    image_out_backward_quality = zeros(W,H,3);
    image_out_backward_quality_bilinear = zeros(W,H,3);
    io_gaussian_q = zeros(W,H,3);
else
    image_out_backward_quality = zeros(W,H);
    image_out_backward_quality_bilinear = zeros(W,H);
    io_gaussian_q = zeros(W,H);
end

for i = 1:W
    for j = 1:H
        b = [i;j;1];
        a = CM * b;
                
        [xnew,ynew,xmin,ymin,xmax,ymax,xround,yround] = coordinates(a);
       
        if (xmin>0 && xmin<=newW && ymin>0 && ymin<=newH)
            image_out_backward_quality(j,i,:) = image_out_backward(ymin,xmin,:);
        end
        
        if (xmin>=1 && xmax<=newW && ymin>=1 && ymax<=newH)
            G = bi_linear_inter(image_out_backward_bilinear,xmin,ymin,xmax,ymax,xnew,ynew);
            Gau = gaussian(io_gaussian,xround,yround,xnew,ynew);
            if (size(image_out_backward_bilinear,3) == 3)
                for k=1:3
                    image_out_backward_quality_bilinear(j,i,k) = G(k);
                    io_gaussian_q(j,i,k) = Gau(k);
                end
            else
                image_out_backward_quality_bilinear(j,i) = G;
                io_gaussian_q(j,i) = Gau;
            end
        end
    end
end