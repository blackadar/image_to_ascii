%File Name: convertToAscii
%Purpose: To take an image and conver it to an ASCII image

function [out] = convertToAscii(image)
characters = char("`^"",:;Il!i~+_-?][}{1)(|\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$");
color = false;
imgSize = size(image);
if size(image,3)==3
    %Color Image
    adjIntensity = zeros(imgSize(1), imgSize(2));
    color = true;
    for i=1:imgSize(1)
        for j=1:imgSize(2)
            %Average
            adjIntensity(i,j)=uint8((image(i,j,1)+image(i,j,2)+image(i,j,3))/3);
            %Luminosity (We might make a setting for these later)
            %adjIntensity(i,j)=(0.21*image(i,j,1))+(0.72*image(i,j,2))+ (0.07*image(i,j,3));
        end
    end
else
    %Grayscale image
    adjIntensity = uint8(image);
end
for i=1:imgSize(1)
    for j=1:imgSize(2)
        %Convert range from 0-255 (normal pixel values) to 0-65 (ASCII
        %values that we have avalible to us)
        adjIntensity(i,j) = fix(((adjIntensity(i,j)-0)*length(characters))/256)+0;
    end
end
asciiMat = char(imgSize(1),imgSize(2));
for i=1:imgSize(1)
    for j=1:imgSize(2)
        asciiMat(i,j) = characters(adjIntensity(i,j));
    end
end
out = asciiMat;
end
