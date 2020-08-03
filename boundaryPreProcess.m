%File Name: convertToAscii
%Purpose: To take an image and conver it to an ASCII image

function [out] = boundaryPreProcess(image)
%Get image boundary
img = imbinarize(image);
se = strel('square', 5);
SquareErode = imerode(img, se);
boundary = imsubtract(img, SquareErode);

%Do stuff w/ boundary
%type
end