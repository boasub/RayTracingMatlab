function objectpoints = simpleImage2objectpoints(img, width, height, depth)
% The following parameters for the function are described below:
%   img = imread(?someimage.png?,?png?);
%   width = width of image in meters
%   height = height of image in meters
%   depth = depth of image in meters
obj = double(img);
thresh = 128;
row = 1;
for i=1:size(obj,1)
    for j=1:size(obj,2)
        if obj(i,j) > thresh
            objectpoints(row,:) = [(i-size(obj,1)/2)*(width/size(obj,1)), (j-size(obj,2)/2)*(height/size(obj,2)), depth];
            row = row + 1;
        end
    end
end
