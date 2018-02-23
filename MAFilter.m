function img_out = MAFilter(Im)

% Set variables for height and size of the image and size of the filter
% window
H = size(Im,1);
W = size(Im,2);
a = 25;
b = a-1;

% Check if the image is rgb or grayscale
if (size(Im,3) == 3)
    img_out = zeros(H,W,3);
    % Take the first, second and third dimensions respectively and put a border
    % of NaN of width - filter window / 2. Create a new matrix and put all the
    % individual dimensions back into one multidimensional matrix
    rIm = Im(:,:,1);
    gIm = Im(:,:,2);
    bIm = Im(:,:,3);
    
    rIm = [nan(b/2,W+b);nan(H,b/2),rIm,nan(H,b/2);nan(b/2,W+b)];
    gIm = [nan(b/2,W+b);nan(H,b/2),gIm,nan(H,b/2);nan(b/2,W+b)];
    bIm = [nan(b/2,W+b);nan(H,b/2),bIm,nan(H,b/2);nan(b/2,W+b)];
    
    I = zeros(H+b,W+b,3);
    I(:,:,1) = rIm;
    I(:,:,2) = gIm;
    I(:,:,3) = bIm;
else
    img_out = zeros(H,W);
    
    I = [nan(b/2,W+b);nan(H,b/2),Im,nan(H,b/2);nan(b/2,W+b)];
end

% Loop through the whole image and all the dimensions, at each point apply
% the window filter and work out the mean of the values. Set this value to
% the current position, i and j, in the output image
for i = 1:W-1
    for j = 1:H-1
        if (size(I,3) == 3)
            for k=1:3
                box = I(i:i+b,j:j+b,k);
                bx = reshape(box(:,:),1,[]);
                m = mean(bx,'omitnan');
                img_out(i,j,k) = m;
            end
        else
            box = I(i:i+b,j:j+b);
            bx = reshape(box(:,:),1,[]);
            m = mean(bx,'omitnan');
            img_out(i,j) = m;
        end
    end
end

imshow(img_out)
axis on;
title('Filtered Image')
pause;