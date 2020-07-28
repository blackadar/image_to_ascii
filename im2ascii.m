function [ascii_mat] = im2ascii(filename, cols, scale)
%IM2ASCII Outputs ASCII file for image input.
%   filename: string path to image input
%   cols: number of columns to use in ascii output
%   scale: ratio of width to height for font (0.43 default)
%
%   References technique: 
%   https://www.geeksforgeeks.org/converting-image-ascii-image-python/

large_ramp = '$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\|()1{}[]?-_+~<>i!lI;:,"^`''. ';
small_ramp = '@%#*+=-:. ';

ramp = small_ramp;

% Read Image and Comvert to Grayscale
image = imread(filename);
image = rgb2gray(image);

% Find image dimensions
width = size(image, 2);
height = size(image, 1);

% Compute tile dimensions
t_width = width / cols;
t_height = t_width / scale;

% Compute #rows
rows = fix(height / t_height);

% Make sure the image isn't too small
if(cols > width || rows > height)
    fprintf('Image too small for %d columns.', cols);
    return
end

% Do the conversion
ascii_mat = char(rows, cols);
for r=1:rows
    y_start = fix(r * t_height);
    y_end = fix( (r+1) * t_height);
    
    % Fix last tile
    if(r == rows)
        y_end = height;
    end
    
    for c=1:cols
        x_start = fix(c * t_width);
        x_end = fix( (c+1) * t_width);
        
        % Fix last tile
        if(c == cols)
            x_end = width;
        end
        
        % Find the tile
        %fprintf("y %d of %d: (%d,%d) x %d of %d: (%d,%d)\n", r, rows, y_start, y_end, c, cols, x_start, x_end);
        tile = image(y_start:y_end, x_start:x_end);
        
        % Find luminance
        lum = fix(mean(tile, 'all'));
        % This could be weighted as needed
        %fprintf("Luminance: %d  ", lum);
        
        % Map to Char
        val = fix( (lum * (strlength(ramp))-1) / 255) + 1;
        %fprintf("Val: %d  ", val);
        asc = ramp(1, val);
        %fprintf("Char: %s  \n", asc);
        
        % Place the character
        ascii_mat(r, c) = asc;
    end
end

% Write the File
fid = fopen(strcat([filename,'.txt']),'w');
for r=1:rows
    fprintf(fid,'%s\n',ascii_mat(r,:));
end

