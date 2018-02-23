function img_out = noise(I)

r=reshape(I(:,:,1),1,[]);
g=reshape(I(:,:,2),1,[]);
b=reshape(I(:,:,3),1,[]);

snp=rand(1,500*500)<=0.25;

for z=1:length(snp)
    if snp(z)
        rn=round(rand());
        r(z)=rn; g(z)=rn; b(z)=rn;
    end
end
img_out=reshape(r,500,500);
img_out(:,:,2)=reshape(g,500,500);
img_out(:,:,3)=reshape(b,500,500);
imshow(img_out)