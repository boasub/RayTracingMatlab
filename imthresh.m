function film = imthresh(film, threshold)
%  film = an NxN matrix of complex numbers representing a hologram
%  threshold = value used to determine the transformation of grey pixels to black or white
film = real(film);
film = film*128;
film = film+128;
for i=1:size(film,1)
    for j=1:size(film,2)
        if film(i,j) > threshold
            film(i,j)=255;
        else
            film(i,j)=0;
        end
    end
end
%filepath = ['images/out_thresh' int2str(threshold) '.png'];
%imwrite(film, filepath)