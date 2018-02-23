function img_out = MedianFilter(I)

H = size(I,1);
W = size(I,2);
a = 31;
b = a-1;

if(size(I,3) == 3)
    img_out = zeros(H,W,3);
    
    % Take the first, second and third dimensions respectively and put a border
    % of NaN of width - filter window / 2. Create a new matrix and put all the
    % individual dimensions back into one multidimensional matrix
    rIm = I(:,:,1);
    gIm = I(:,:,2);
    bIm = I(:,:,3);
    
    rIm = [nan(b/2,W+b);nan(H,b/2),rIm,nan(H,b/2);nan(b/2,W+b)];
    gIm = [nan(b/2,W+b);nan(H,b/2),gIm,nan(H,b/2);nan(b/2,W+b)];
    bIm = [nan(b/2,W+b);nan(H,b/2),bIm,nan(H,b/2);nan(b/2,W+b)];
    
    I = zeros(H+b,W+b,3);
    I(:,:,1) = rIm;
    I(:,:,2) = gIm;
    I(:,:,3) = bIm;
else
    img_out = zeros(H,W);
    
    I = [nan(b/2,W+b);nan(H,b/2),I,nan(H,b/2);nan(b/2,W+b)];
end

for i = 1:W
    for j = 1:H
        if (size(I,3) == 3)
            for k=1:3
                box = I(i:i+b,j:j+b,k);
                bx = reshape(box(:,:),1,[]);
                m = floor(median(bx,'omitnan'));
                img_out(i,j,k) = m;
            end
        else
            box = I(i:i+b,j:j+b);
            bx = reshape(box(:,:),1,[]);
            m = floor(median(bx,'omitnan'));
            img_out(i,j) = m;
        end
    end
end

imshow(img_out)
pause;
close all;