function out = imageSelec(i)

switch i
    case 1
        image_selection = 'surrey.png';
        % Read the image in and normalise the colour
        out = double(imread(image_selection))./255;
    case 2
        image_selection = 'colour_gradient.jpg';
        % Read the image in and normalise the colour
        out = double(imread(image_selection))./255;
    case 3
        image_selection = 'Cat.jpg';
        % Read the image in and normalise the colour
        out = double(imread(image_selection))./255;
    case 4
        image_selection = 'BlackAndWhite.jpg';
        % Read the image in and normalise the colour
        out = double(imread(image_selection))./255;
    case 5
        Hi = 500; Wi = 500; Sx = 25; Sy = 25;
        out = ipv_cheqpattern(Hi,Wi,Sx,Sy);
end