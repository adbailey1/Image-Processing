function ImG = gaussian(Image,xround,yround,xnew,ynew)

W = size(Image,2);
H = size(Image,1);

xminus = xround-1;
yminus = yround - 1;
xplus = xround+1;
yplus = yround+1;

if (xminus<1||yminus<1||xplus>W||yplus>H)
    xmin = floor(xnew);
    xmax = ceil(xnew);
    ymin = floor(ynew);
    ymax = ceil(ynew);
    G = bi_linear_inter(Image,xmin,ymin,xmax,ymax,xnew,ynew);
    ImG = G;
else
    xcoord = [xminus,xround,xplus];
    ycoord = [yminus,yround,yplus];
    
    [X,Y] = meshgrid(xcoord,ycoord);
    
    sigma = 2;
    
    gaussian = exp(-((X-xnew).^2)/(2*sigma)^2 + ((Y-ynew).^2)/(2*sigma)^2);
    
    g = sum(sum(gaussian,'omitnan'));
    
    if(size(Image,3)==3)
    
    Im = Image(yround-1:yround+1,xround-1:xround+1,:);
    
    ImrG = sum(sum((Im(:,:,1).*gaussian),'omitnan'))/g;
    ImgG = sum(sum((Im(:,:,2).*gaussian),'omitnan'))/g;
    ImbG = sum(sum((Im(:,:,3).*gaussian),'omitnan'))/g;
    
    ImG = [ImrG,ImgG,ImbG];
    else
    Im = Image(yround-1:yround+1,xround-1:xround+1);
    ImG = sum(sum((Im.*gaussian),'omitnan'))/g;
    end
end