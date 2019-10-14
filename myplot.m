function img = myplot(A, plot_length)
x = plot_length*100; % cm
y = plot_length*100;  % cm
img = uint8(zeros(x,y,3)+255);
[nrow, ncol] = size(A);
% Next create the circles in the image.
for i = 1:nrow
    %test = i
    circle = [];
    centerX = A(i,3)*100;
    centerY = A(i,4)*100;
    radius = A(i,2)*5/(2*pi);
    x1 = fix(centerX)-fix(radius)-3;
    x2 = fix(centerX)+fix(radius)+3;
    y1 = fix(centerY)-fix(radius)-3;
    y2 = fix(centerY)+fix(radius)+3;
    [cuberow, cubcol] = meshgrid(x1:x2, y1:y2);
    circle = (cuberow - centerX).^2 ...
        + (cubcol - centerY).^2 <= radius.^2;

    if (x1 >0)&(x2<=x)&(y1>0)&(y2<=y)
        if A(i,1) == 1
            img(x1:x2, y1:y2,1) = img(x1:x2, y1:y2,1) - uint8(circle*255);
        else
           img(x1:x2, y1:y2,2) = img(x1:x2, y1:y2,2) - uint8(circle*255);
        end
    end
end
%imwrite(img,'testImg.jpg');
%warning('off', 'Images:initSize:adjustingMag');
%image(img)

        